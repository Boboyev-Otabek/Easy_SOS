import 'package:flutter/material.dart';

import '../models/contact_model.dart';

Widget? itemOfContact({required MyContact myContact}) {
  return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Colors.green)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(myContact.name),
          Text(myContact.number),
        ],
      ));
}
