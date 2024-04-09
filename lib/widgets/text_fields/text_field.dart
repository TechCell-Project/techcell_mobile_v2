// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  TextEditingController controller;
  String labelText;
  Icon? icon;
  TextInputType? keyboardType;
  TextFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    this.icon,
    this.keyboardType,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(fontSize: 16, color: Colors.grey),
        border: const OutlineInputBorder(),
        prefixIcon: widget.icon,
      ),
    );
  }
}
