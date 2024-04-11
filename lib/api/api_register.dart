// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:single_project/page/screens/main_screen.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/util/snackbar.dart';

class RegisterApi {
  Dio dio = Dio();
  Map<String, String> authServiceHeaders() {
    return {
      'Content-Type': 'application/json',
    };
  }

  void signUpUser({
    required BuildContext context,
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    try {
      Response res = await dio.post('$uriAuth/email/register',
          data: json.encode({
            'email': email,
            'password': password,
            'firstName': firstName,
            'lastName': lastName
          }),
          options: Options(
            headers: authServiceHeaders(),
          ));
      httpSuccessHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBarSuccess(context, 'Đăng ký thành công');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false);
        },
      );
    } catch (e) {
      showSnackBarError(context, 'Đăng ký thất bại');
    }
  }
}
