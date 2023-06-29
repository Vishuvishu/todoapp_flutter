import 'package:flutter/material.dart';

class ShowMessage extends SnackBar {
  final String message;
  final bool isgoood;
  ShowMessage({required this.message, this.isgoood: true})
      : super(
            content: Text(message),
            backgroundColor: isgoood ? Colors.blue : Colors.red);
}
