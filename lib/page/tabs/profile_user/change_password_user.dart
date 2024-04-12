import 'package:flutter/material.dart';
import 'package:single_project/api/api_profile_user.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/widgets/button/button_send_requrest.dart';
import 'package:single_project/widgets/text_fields/text_field_password.dart';

class ChangePasswordTab extends StatefulWidget {
  const ChangePasswordTab({super.key});

  @override
  State<ChangePasswordTab> createState() => _ChangePasswordTabState();
}

class _ChangePasswordTabState extends State<ChangePasswordTab> {
  @override
  Widget build(BuildContext context) {
    TextEditingController oldPassword = TextEditingController();
    TextEditingController newPassword = TextEditingController();
    TextEditingController reNewPassword = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: primaryColors,
          title: const Text('Đổi Mật khẩu'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              TextFieldPassword(
                controller: oldPassword,
                labelText: 'Mật khẩu cũ',
                icon: const Icon(Icons.lock),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextFieldPassword(
                controller: newPassword,
                labelText: 'Mật khẩu mới',
                icon: const Icon(Icons.lock),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextFieldPassword(
                controller: reNewPassword,
                labelText: 'Nhập lại mật khẩu mới',
                icon: const Icon(Icons.lock),
                obscureText: true,
              ),
              const SizedBox(height: 30),
              ButtonSendrequest(
                  text: 'Đổi Mật khẩu',
                  submit: () {
                    ApiUser().changePasswordUser(
                      context,
                      oldPassword.text,
                      newPassword.text,
                      reNewPassword.text,
                    );
                  })
            ],
          ),
        ));
  }
}
