// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_project/Providers/user_provider.dart';
import 'package:single_project/page/screens/main_screen.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/util/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiLogin {
  Dio dio = Dio();
  Map<String, String> authServiceHeaders() {
    return {
      'Content-Type': 'application/json',
    };
  }

  Future<void> userLogin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      Response res = await dio.post(
        '$uriAuth/email/login',
        data: jsonEncode({'email': email, 'password': password}),
        options: Options(
          headers: authServiceHeaders(),
        ),
      );
      httpSuccessHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('user', jsonEncode(res.data));

          userProvider.setUser(jsonEncode(res.data));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false);
        },
      );
    } catch (e) {
      showSnackBarError(context, e.toString());
    }
  }

  Future<bool> checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    return userJson != null;
  }

  Future logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (route) => false);
  }
}
