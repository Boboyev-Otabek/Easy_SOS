import 'dart:async';

import 'package:background_sms/background_sms.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/contact_model.dart';
import '../services/shared_prefs_service.dart';
import '../services/sqflite_service.dart';
import '../utils/toast_util/flutter_toast.dart';

class HomeViewModel extends ChangeNotifier {
  List<String> options = ['English', 'Russion', 'Uzbek'];
  String? messageLocation = '';
  String? lat = '';
  String? long = '';
  List<String> numberList = [];
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  Future getConnectivity(BuildContext context) async {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected && isAlertSet == false) {
        showDialogBox(context);
        isAlertSet = true;
        notifyListeners();
      }
    });
  }

  showDialogBox(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("No Connection"),
          content: Text("Please check your internet connectivity"),
          actions: [
            TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  isAlertSet = false;
                  notifyListeners();
                  isDeviceConnected =
                      await InternetConnectionChecker().hasConnection;
                  if (!isDeviceConnected) {
                    showDialogBox(context);
                    isAlertSet = true;
                    notifyListeners();
                  }
                },
                child: const Text("OK"))
          ],
        ),
      );

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Utils.toast('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Utils.toast('Location services are disabled.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Utils.toast(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  getPermission() async => await [
        Permission.sms,
      ].request();

  Future<bool> isPermissionGranted() async =>
      await Permission.sms.status.isGranted;

  sendMessage(String phoneNumber, String message, {int? simSlot}) async {
    var result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: simSlot);
    if (result == SmsStatus.sent) {
      Utils.toast("Send message");
    } else {
      Utils.toast("Failed");
    }
  }

  Future<void> setValueLatLong() async {
    Position value = await getCurrentPosition();
    lat = value.latitude.toString();
    long = value.longitude.toString();
    notifyListeners();
  }

  Future<void> getAllContactFromDB() async {
    List<MyContact>? item;
    item = await ContactSqflite.getAllContact();
    item?.forEach((element) {
      numberList.add(element.number.toString());
    });
  }

  String? currentOption;

  Future<void> sentSMS() async {
    messageLocation = 'http://maps.google.com/maps?f=q&q=$lat,$long';

    if (numberList.isEmpty) {
      Utils.toast("You have not contact");
    } else {
      for (var number in numberList) {
        if (await isPermissionGranted()) {
          sendMessage(number, "Help me! \n $messageLocation");
        } else {
          getPermission();
        }
      }
    }

    notifyListeners();
  }

  Future<void> setEnglishLanguage(BuildContext context, dynamic value) async {
    currentOption = value.toString();

    context.setLocale(const Locale('en', 'US'));
    SharedPrefs.storeLanguage('English');

    Navigator.pop(context);

    notifyListeners();
  }

  Future<void> setRussianLanguage(BuildContext context, dynamic value) async {
    currentOption = value.toString();

    context.setLocale(const Locale('ru', 'RU'));
    SharedPrefs.storeLanguage('Russian');

    Navigator.pop(context);

    notifyListeners();
  }

  Future<void> setUzbekLanguage(BuildContext context, dynamic value) async {
    currentOption = value.toString();

    context.setLocale(const Locale('uz', 'UZ'));
    SharedPrefs.storeLanguage('Uzbek');

    Navigator.pop(context);
    notifyListeners();
  }
}
