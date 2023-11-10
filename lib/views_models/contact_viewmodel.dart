import 'package:flutter/cupertino.dart';

import '../models/contact_model.dart';
import '../services/sqflite_service.dart';

class ContactViewModel extends ChangeNotifier {
  var nameController = TextEditingController();
  var numberController = TextEditingController();

  Future<void> checkContactData(MyContact? myContact) async {
    if (myContact != null) {
      nameController.text = myContact.name;
      numberController.text = myContact.number;
    }
  }

  Future<void> checkInputData(MyContact? myContact) async {
    final name = nameController.value.text;
    final number = numberController.value.text;
    if (name.isEmpty || number.isEmpty) {
      return;
    }

    final MyContact model =
        MyContact(number: number, name: name, id: myContact?.id);
    if (myContact == null) {
      await ContactSqflite.addContact(model);
    } else {
      await ContactSqflite.updateContact(model);
    }
  }
}
