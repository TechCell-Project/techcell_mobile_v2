// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:single_project/util/constants.dart';

class TextInAvatar extends StatelessWidget {
  String textAvatar;
  double width;
  double height;
  double fontSized;
  TextInAvatar({
    super.key,
    required this.textAvatar,
    required this.height,
    required this.width,
    required this.fontSized,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: primaryColors.withOpacity(0.2),
      ),
      child: Center(
        child: Text(
          textAvatar,
          style: TextStyle(color: Colors.white, fontSize: fontSized),
        ),
      ),
    );
  }
}
