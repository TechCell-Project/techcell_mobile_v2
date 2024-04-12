// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextformAddress extends StatelessWidget {
  TextEditingController controller;
  String hint;
  TextInputType? keyboard;
  String? Function(String?)? validate;
  TextformAddress({
    super.key,
    required this.controller,
    required this.hint,
    required this.validate,
    this.keyboard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 5),
        child: TextFormField(
          keyboardType: keyboard,
          controller: controller,
          validator: validate,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
