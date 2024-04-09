// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TextFieldPassword extends StatefulWidget {
  TextEditingController controller;
  String labelText;
  bool obscureText;
  Icon icon;
  TextFieldPassword(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.icon,
      required this.obscureText});

  @override
  State<TextFieldPassword> createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: const TextStyle(fontSize: 16, color: Colors.grey),
          border: const OutlineInputBorder(),
          prefixIcon: widget.icon,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                widget.obscureText = !widget.obscureText;
              });
            },
            child: Icon(
              widget.obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
              size: 25,
            ),
          ),
          isDense: true,
        ));
  }
}
