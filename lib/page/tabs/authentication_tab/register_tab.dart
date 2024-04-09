import 'package:flutter/material.dart';
import 'package:single_project/api/api_register.dart';
import 'package:single_project/util/snackbar.dart';
import 'package:single_project/widgets/button/button_send_requrest.dart';
import 'package:single_project/widgets/text_fields/text_field.dart';
import 'package:single_project/widgets/text_fields/text_field_password.dart';

class RegisterTab extends StatefulWidget {
  const RegisterTab({super.key});

  @override
  State<RegisterTab> createState() => _RegisterTabState();
}

class _RegisterTabState extends State<RegisterTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController repassword = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final RegisterApi authSignUp = RegisterApi();

  void signUpUser() {
    if (password.text == repassword.text) {
      if (_formKey.currentState!.validate()) {
        authSignUp.signUpUser(
          context: context,
          email: email.text,
          userName: userName.text.trim(),
          firstName: firstName.text,
          lastName: lastName.text,
          password: password.text.trim(),
        );
      }
    } else {
      showSnackBarError(context, 'Mật khẩu không khớp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset('assets/logos/logo-red.png'),
            const SizedBox(height: 50),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFieldWidget(
                        controller: email,
                        labelText: 'Email',
                        icon: const Icon(Icons.mail),
                        keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                        controller: firstName,
                        labelText: 'Tên',
                        icon: const Icon(Icons.person),
                        keyboardType: null),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                        controller: lastName,
                        labelText: 'Họ',
                        icon: const Icon(Icons.person),
                        keyboardType: null),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                        controller: userName,
                        labelText: 'Tên đăng nhập',
                        icon: const Icon(Icons.person),
                        keyboardType: null),
                    const SizedBox(height: 10),
                    TextFieldPassword(
                        controller: password,
                        labelText: 'Mật khẩu',
                        obscureText: true,
                        icon: const Icon(Icons.lock)),
                    const SizedBox(height: 10),
                    TextFieldPassword(
                        controller: repassword,
                        labelText: 'Nhập lại Mật khẩu',
                        obscureText: true,
                        icon: const Icon(Icons.lock)),
                    const SizedBox(height: 50),
                    ButtonSendrequest(text: 'Đăng ký', submit: signUpUser)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
