// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialog {
  final String title;
  AppDialog({
    required this.title,
  });

  void normalDialog({
    Widget? firstAction,
    Widget? secondAction,
    Widget? contentWidget,
  }) {
    Get.dialog(AlertDialog(scrollable: true,
      title: Text(title),
      content: contentWidget,
      actions: [
        secondAction ?? const SizedBox(),
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
