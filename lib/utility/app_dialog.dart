// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialog {
  final String title;
  AppDialog({
    required this.title,
  });

  void normalDialog({Widget? firstAction}) {
    Get.dialog(AlertDialog(
      title: Text(title),
      actions: [
        firstAction ??
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Cancel'))
      ],
    ));
  }
}
