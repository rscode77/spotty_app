import 'package:flutter/material.dart';

class ExtendedTextEditingController extends TextEditingController {
  String? errorText;

  void setErrorText(String? error) {
    errorText = error;
  }
}