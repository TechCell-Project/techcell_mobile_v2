// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_project/Providers/user_provider.dart';
import 'package:single_project/models/user_model.dart';
import 'package:single_project/page/screens/main_screen.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/util/interceptor.dart';
import 'package:single_project/util/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class ApiLogin {
  Dio dio = Dio();

  final InterceptorClass interceptorClass = InterceptorClass();

  Map<String, String> headersHaveAccessToken(String token) {
    return {
      'Authorization': 'Bearer $token',
    };
  }

  Future<void> loginFaceBook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      print(result.accessToken);

      final userData = await FacebookAuth.instance.getUserData();
      print(userData);
    } else {
      print(result.status);
      print(result.message);
    }
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
      );
      httpSuccessHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('user', jsonEncode(res.data));
          userProvider.setUser(AuthModel.fromJson(jsonEncode(res.data)));
          print(res.data['accessToken']);
          print(res.data['accessTokenExpires']);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false);
        },
      );
    } catch (e) {
      showSnackBarError(context, 'Đăng nhập thất bại');
    }
  }

  Future<bool> checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    return userJson != null;
  }

  Future logout(BuildContext context) async {
    try {
      Dio dioWithInterceptor = interceptorClass.getDioWithInterceptor();
      Response res = await dioWithInterceptor.post(
        '$uriAuth/logout',
      );
      httpSuccessHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.clear();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false);
        },
      );
    } catch (e) {
      print('loi dang xuat');
    }
  }
}
