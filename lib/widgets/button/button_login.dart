import 'package:flutter/material.dart';
import 'package:single_project/util/constants.dart';

// ignore: must_be_immutable
class ButtonLogin extends StatelessWidget {
  ButtonLogin({
    super.key,
    required this.image,
    required this.text,
    required this.loginWith,
  });
  String text;
  String image;
  final Function()? loginWith;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loginWith,
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(left: 50),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 246, 246, 246),
            boxShadow: [
              BoxShadow(
                color: primaryColors.withOpacity(0.2),
                offset: const Offset(0, 3),
                blurRadius: 10,
              )
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 30,
            ),
            const SizedBox(width: 15),
            Text(text),
          ],
        ),
      ),
    );
  }
}
