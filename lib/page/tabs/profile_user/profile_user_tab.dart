import 'package:flutter/material.dart';
import 'package:single_project/api/api_login.dart';
import 'package:single_project/widgets/button/button_send_requrest.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ButtonSendrequest(
          text: 'logout',
          submit: () {
            ApiLogin().logout(context);
          },
        ),
      ),
    );
  }
}
