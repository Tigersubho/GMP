import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;

  CustomDialog({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      backgroundColor: Colors.blue.shade50,

      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
