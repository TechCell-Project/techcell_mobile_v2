// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:single_project/util/constants.dart';
import 'package:single_project/util/snackbar.dart';

class RegisterApi {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String userName,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uriAuth/email/register'),
        body: json.encode({
          'email': email,
          'userName': userName,
          'password': password,
          'firstName': firstName,
          'lastName': lastName
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpSuccessHandle(
        response: res,
        context: context,
        onSuccess: () {
          print('123123');
          showSnackBarSuccess(context, 'Đăng ký thành công');
        },
      );
    } catch (e) {
      showSnackBarError(context, e.toString());
      print(e.toString());
    }
  }
}
