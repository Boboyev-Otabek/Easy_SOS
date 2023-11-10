import 'package:demo_back_sms/models/contact_model.dart';
import 'package:demo_back_sms/views_models/contact_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContectPage extends StatefulWidget {
  final MyContact? myContact;

  const ContectPage({super.key, this.myContact});

  @override
  State<ContectPage> createState() => _ContectPageState();
}

class _ContectPageState extends State<ContectPage> {
  ContactViewModel viewModel = ContactViewModel();

  @override
  Widget build(BuildContext context) {
    viewModel.checkContactData(widget.myContact);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.myContact == null
                ? 'txt_Add_Contact'
                : 'txt_edit_contact')
            .tr(),
      ),
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<ContactViewModel>(
          builder: (context, value, child) => SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // #name
                Container(
                  height: 70,
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  child: TextField(
                    controller: viewModel.nameController,
                    maxLines: 1,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      label: const Text('str_name').tr(),
                      hintStyle: const TextStyle(fontSize: 17),
                      labelStyle: const TextStyle(fontSize: 18),
                      hintText: 'str_enter_name'.tr(),
                    ),
                  ),
                ),

                Container(
                  height: 70,
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  child: TextField(
                    controller: viewModel.numberController,
                    maxLines: 1,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      label: const Text('str_number').tr(),
                      hintStyle: const TextStyle(fontSize: 17),
                      labelStyle: const TextStyle(fontSize: 18),
                      hintText: 'str_enter_number'.tr(),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        viewModel.checkInputData(widget.myContact);

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.black),
                      child: Text(
                        widget.myContact == null ? 'str_save' : 'str_update',
                        style: const TextStyle(fontSize: 17),
                      ).tr(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
