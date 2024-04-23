// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:single_project/util/constants.dart';

class TextTile extends StatelessWidget {
  String text;
  TextTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: SizedBox(
        height: 24,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                height: 7,
                color: primaryColors.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
