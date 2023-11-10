import 'package:demo_back_sms/items/item_of_contact.dart';
import 'package:demo_back_sms/models/contact_model.dart';
import 'package:demo_back_sms/services/sqflite_service.dart';
import 'package:demo_back_sms/views_models/contacts_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contact_page.dart';
import 'home_page.dart';

class ContectsPage extends StatefulWidget {
  const ContectsPage({super.key});

  @override
  State<ContectsPage> createState() => _ContectsPageState();
}

class _ContectsPageState extends State<ContectsPage> {
  ContactsViewModel contactsViewModel = ContactsViewModel();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth<770){
          return  ChangeNotifierProvider(
            create: (context) => contactsViewModel,
            child: Consumer<ContactsViewModel>(
              builder: (context, value, child) => Scaffold(
                backgroundColor: Colors.white30,
                appBar: AppBar(
                  title: const Text('str_Contacts').tr(),
                  backgroundColor: Colors.indigo,
                  elevation: 10,
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                                  (route) => false);
                        },
                        icon: const Icon(Icons.home_filled,size: 30,)),
                  ],
                ),
                body: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      color: Colors.white30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            textAlign: TextAlign.start,
                            softWrap: true,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'txt_advice_addContact'.tr(),
                                    style: const TextStyle(fontSize: 16)),
                                const WidgetSpan(
                                    child: SizedBox(
                                      width: 8,
                                    )),
                                const TextSpan(
                                  text: '\n',
                                ),
                                TextSpan(
                                    text: 'txt_click_addContact'.tr(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                const TextSpan(
                                  text: '\n',
                                ),
                                const TextSpan(
                                  text: '\n',
                                ),
                                TextSpan(
                                    text: 'txt_advice_change'.tr(),
                                    style: const TextStyle(fontSize: 16)),
                                const WidgetSpan(
                                    child: SizedBox(
                                      width: 8,
                                    )),
                                const TextSpan(
                                  text: '\n',
                                ),
                                TextSpan(
                                    text: 'txt_click_once'.tr(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                const TextSpan(
                                  text: '\n',
                                ),
                                const TextSpan(
                                  text: '\n',
                                ),
                                TextSpan(
                                    text: 'txt_advice_delete'.tr(),
                                    style: const TextStyle(fontSize: 16)),
                                const WidgetSpan(
                                    child: SizedBox(
                                      width: 8,
                                    )),
                                const TextSpan(
                                  text: '\n',
                                ),
                                TextSpan(
                                    text: 'txt_LongPress'.tr(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 4, bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.only(top: 60),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const ContectPage(),
                                      ));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.purple,
                                      border:
                                      Border.all(color: Colors.green, width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: const Text(
                                      'txt_Add_Contact',
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ).tr(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: FutureBuilder<List<MyContact>?>(
                                future: ContactSqflite.getAllContact(),
                                builder: (context,
                                    AsyncSnapshot<List<MyContact>?> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text(snapshot.error.toString()),
                                    );
                                  } else if (snapshot.hasData) {
                                    if (snapshot.data != null) {
                                      return ListView.builder(
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            MyContact contact = snapshot.data![index];
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ContectPage(
                                                            myContact: contact,
                                                          ),
                                                    ));
                                              },
                                              onLongPress: () async {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          const Text(
                                                              'txt_delete_dialog')
                                                              .tr(),
                                                          Text(contact.name),
                                                        ],
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            contactsViewModel
                                                                .deleteContact(
                                                                context, contact);
                                                          },
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                  .red)),
                                                          child: const Text('str_yes')
                                                              .tr(),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            contactsViewModel
                                                                .closeWindow(context);
                                                          },
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                  .blueAccent)),
                                                          child: const Text('str_no')
                                                              .tr(),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child:
                                              itemOfContact(myContact: contact),
                                            );
                                          });
                                    }
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }else{
         return ChangeNotifierProvider(
            create: (context) => contactsViewModel,
            child: Consumer<ContactsViewModel>(
              builder: (context, value, child) => Scaffold(
                backgroundColor: Colors.white30,
                appBar: AppBar(
                  title: const Text('str_Contacts').tr(),
                  backgroundColor: Colors.indigo,
                  elevation: 10,
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                                  (route) => false);
                        },
                        icon: const Icon(Icons.home_filled,size: 30,)),
                  ],
                ),
                body: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      color: Colors.white30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            textAlign: TextAlign.start,
                            softWrap: true,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'txt_advice_addContact'.tr(),
                                    style: const TextStyle(fontSize: 16)),
                                const WidgetSpan(
                                    child: SizedBox(
                                      width: 8,
                                    )),
                                TextSpan(
                                    text: 'txt_click_addContact'.tr(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                const WidgetSpan(
                                    child: SizedBox(
                                      width: 12,
                                    )),
                                TextSpan(
                                    text: 'txt_advice_change'.tr(),
                                    style: const TextStyle(fontSize: 16)),
                                const WidgetSpan(
                                    child: SizedBox(
                                      width: 8,
                                    )),

                                TextSpan(
                                    text: 'txt_click_once'.tr(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                const WidgetSpan(
                                    child: SizedBox(
                                      width: 12,
                                    )),
                                TextSpan(
                                    text: 'txt_advice_delete'.tr(),
                                    style: const TextStyle(fontSize: 16)),
                                const WidgetSpan(
                                    child: SizedBox(
                                      width: 8,
                                    )),

                                TextSpan(
                                    text: 'txt_LongPress'.tr(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 4),
                      child: Container(
                        padding: const EdgeInsets.only(top: 30),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const ContectPage(),
                                      ));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.purple,
                                      border:
                                      Border.all(color: Colors.green, width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: const Text(
                                      'txt_Add_Contact',
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ).tr(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: FutureBuilder<List<MyContact>?>(
                                future: ContactSqflite.getAllContact(),
                                builder: (context,
                                    AsyncSnapshot<List<MyContact>?> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text(snapshot.error.toString()),
                                    );
                                  } else if (snapshot.hasData) {
                                    if (snapshot.data != null) {
                                      return ListView.builder(
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            MyContact contact = snapshot.data![index];
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ContectPage(
                                                            myContact: contact,
                                                          ),
                                                    ));
                                              },
                                              onLongPress: () async {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          const Text(
                                                              'txt_delete_dialog')
                                                              .tr(),
                                                          Text(contact.name),
                                                        ],
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            contactsViewModel
                                                                .deleteContact(
                                                                context, contact);
                                                          },
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                  .red)),
                                                          child: const Text('str_yes')
                                                              .tr(),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            contactsViewModel
                                                                .closeWindow(context);
                                                          },
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                  .blueAccent)),
                                                          child: const Text('str_no')
                                                              .tr(),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child:
                                              itemOfContact(myContact: contact),
                                            );
                                          });
                                    }
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }
    );
  }
}
