// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
    required this.label,
    required this.pressFunc,
  }) : super(key: key);

  final String label;
  final Function() pressFunc;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange, foregroundColor: Colors.white),
      onPressed: pressFunc,
      child: Text(label),
    );
  }
}
