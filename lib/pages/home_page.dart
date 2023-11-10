import 'package:demo_back_sms/services/shared_prefs_service.dart';
import 'package:demo_back_sms/views_models/home_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import 'contacts_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getConnectivity(context);
    SharedPrefs.loadLanguage().then((value) {
      viewModel.currentOption = value.toString();
    });

    viewModel.getAllContactFromDB();
    viewModel.setValueLatLong();
  }

  @override
  void dispose() {

    viewModel.subscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text(
              'str_HomePageAppBar',
              style: TextStyle(color: Colors.black),
            ).tr(),
          ),
          body: Stack(
            children: [
              (viewModel.lat!.isEmpty || viewModel.long!.isEmpty)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GestureDetector(
                      onTap: () async {
                        viewModel.sentSMS();
                      },
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: MediaQuery.of(context).size.width/3,
                          child: const Text(
                            'str_SOS',
                            style: TextStyle(
                                fontSize: 40,color: Colors.black, fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                      ),
                    ),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              animatedIconTheme: const IconThemeData(size: 25),
              overlayColor: Colors.black,
              overlayOpacity: 0.5,
              buttonSize: const Size(70, 70),
              label: const Text(
                'str_Menu',
                style: TextStyle(fontSize: 18),
              ).tr(),
              shape: const CircleBorder(),
              children: [
                SpeedDialChild(
                  child: const Icon(Icons.language),
                  backgroundColor: Colors.yellow,
                  label: 'str_Languages'.tr(),
                  labelBackgroundColor: Colors.yellow,
                  labelStyle: const TextStyle(fontSize: 18),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('str_Languages').tr(),
                          actions: [
                            Column(
                              children: [
                                ListTile(
                                  title: const Text('str_language_en').tr(),
                                  leading: Radio(
                                    value: viewModel.options[0],
                                    groupValue: viewModel.currentOption,
                                    onChanged: (value) {
                                      viewModel.setEnglishLanguage(
                                          context, value);
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('str_language_ru').tr(),
                                  leading: Radio(
                                    value: viewModel.options[1],
                                    groupValue: viewModel.currentOption,
                                    onChanged: (value) {
                                      viewModel.setRussianLanguage(
                                          context, value);
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('str_language_uz').tr(),
                                  leading: Radio(
                                    value: viewModel.options[2],
                                    groupValue: viewModel.currentOption,
                                    onChanged: (value) {
                                      viewModel.setUzbekLanguage(
                                          context, value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                SpeedDialChild(
                  child: const Icon(Icons.contacts),
                  backgroundColor: Colors.green,
                  label: 'str_Contacts'.tr(),
                  labelBackgroundColor: Colors.green,
                  labelStyle: const TextStyle(fontSize: 18),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContectsPage(),
                        ),
                        (route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
