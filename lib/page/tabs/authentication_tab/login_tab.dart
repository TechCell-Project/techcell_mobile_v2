import 'package:flutter/material.dart';
import 'package:single_project/api/api_login.dart';
import 'package:single_project/page/tabs/authentication_tab/forgot_tab.dart';
import 'package:single_project/page/tabs/authentication_tab/register_tab.dart';
import 'package:single_project/widgets/button/button_login.dart';
import 'package:single_project/widgets/button/button_send_requrest.dart';
import 'package:single_project/widgets/text_fields/text_field.dart';
import 'package:single_project/widgets/text_fields/text_field_password.dart';

class LoginTap extends StatefulWidget {
  const LoginTap({super.key});

  @override
  State<LoginTap> createState() => _LoginTapState();
}

class _LoginTapState extends State<LoginTap> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ApiLogin authLogin = ApiLogin();
  void loginUser() {
    authLogin.userLogin(
        context: context,
        email: emailController.text,
        password: passwordcontroller.text);
  }

  void loginGoogle() {
    authLogin.signInWithGoogle(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset('assets/logos/logo-red.png'),
            const SizedBox(height: 50),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFieldWidget(
                      controller: emailController,
                      labelText: 'email',
                      icon: const Icon(Icons.person),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    TextFieldPassword(
                      controller: passwordcontroller,
                      labelText: 'Mật khẩu',
                      obscureText: true,
                      icon: const Icon(Icons.lock),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgotTab()));
                        },
                        child: const Text(
                          'Quên Mật Khẩu?',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ButtonSendrequest(text: 'Đăng nhập', submit: loginUser),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Bạn chưa có tài khoản?'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterTab(),
                                ));
                          },
                          child: const Text(
                            'Đăng ký',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Text(
                          'Hoặc',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    ButtonLogin(
                      loginWith: () {
                        ApiLogin().signInWithGoogle(context: context);
                      },
                      image: 'assets/icons/google.png',
                      text: 'Đăng nhập bằng Google',
                    ),
                    const SizedBox(height: 10),
                    ButtonLogin(
                      loginWith: () {
                        ApiLogin().loginFaceBook();
                      },
                      image: 'assets/icons/facebook.png',
                      text: 'Đăng nhập bằng facebook',
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
