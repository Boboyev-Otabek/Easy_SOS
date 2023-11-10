import 'package:demo_back_sms/models/contact_model.dart';
import 'package:flutter/material.dart';

import '../services/sqflite_service.dart';

class ContactsViewModel extends ChangeNotifier {
  Future<void> deleteContact(BuildContext context, MyContact contact) async {
    await ContactSqflite.deleteContact(contact);

    // ignore: use_build_context_synchronously
    Navigator.pop(context);

    notifyListeners();
  }

  Future<void> closeWindow(BuildContext context) async {

    Navigator.pop(context);
    notifyListeners();
  }

}
