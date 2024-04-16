import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:single_project/api/api_register.dart';
import 'package:single_project/widgets/button/button_send_requrest.dart';

class ForgotTab extends StatefulWidget {
  const ForgotTab({super.key});

  @override
  State<ForgotTab> createState() => _ForgotTabState();
}

class _ForgotTabState extends State<ForgotTab> {
  final TextEditingController emailController = TextEditingController();
  bool clrButton = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Quên Mật khẩu',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                'Nhập địa chỉ email để nhận cách lấy lại mật khẩu',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                onChanged: (val) {
                  if (val != "") {
                    setState(() {
                      clrButton = true;
                    });
                  }
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Email",
                  suffix: InkWell(
                    onTap: () {
                      setState(() {
                        emailController.clear();
                      });
                    },
                    child: const Icon(
                      CupertinoIcons.multiply,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ButtonSendrequest(
                  text: 'Gửi Mã OTP',
                  submit: () {
                    RegisterApi().forgotPassword(
                      context,
                      emailController.text,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
