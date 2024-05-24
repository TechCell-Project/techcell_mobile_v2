// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:single_project/page/screens/main_screen.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/util/interceptor.dart';
import 'package:single_project/util/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
          (route) => false);
      // Dio dioWithInterceptor = interceptorClass.getDioWithInterceptor();
      // Response res = await dioWithInterceptor.post(
      //   '$uriAuth/logout',
      // );
      // httpSuccessHandle(
      //   response: res,
      //   context: context,
      //   onSuccess: () async {
      //     final prefs = await SharedPreferences.getInstance();
      //     await prefs.clear();
      //     Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(builder: (context) => const MainScreen()),
      //         (route) => false);
      //   },
      // );
    } catch (e) {
      print('loi dang xuat');
    }
  }

  void signInWithGoogle({required BuildContext context}) async {
    try {
      final GoogleSignIn signinInstance = GoogleSignIn(
        scopes: ['openid', 'email', 'profile'],
        clientId: dotenv.env['GOOGLE_CLIENT_ID'],
      );
      final GoogleSignInAccount? googleUser = await signinInstance.signIn();
      if (googleUser == null) {
        return showSnackBarError(context, 'Sigin Google failed');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // String? idToken = googleAuth.idToken;

      await signinInstance.signIn().then((result) {
        result?.authentication.then((googleKey) {
          print(googleKey.accessToken);
          print(googleKey.idToken);
        }).catchError((err) {
          print('inner error');
        });
      }).catchError((err) {
        print('error occured');
      });
      // if (idToken == null) return;
      print('ggAUTH:: ${googleAuth.toString()}');
      print('idToken:: ${googleAuth.idToken}');
      sendIdTokenToServer(context,
          idToken: '${googleAuth.idToken}',
          accessTokenGoogle: '${googleAuth.accessToken}');
    } catch (e) {
      print(e);
    }
  }

  void sendIdTokenToServer(BuildContext context,
      {required String idToken, required String accessTokenGoogle}) async {
    try {
      Response res = await dio.post('$uriAuth/google/login',
          data: {"idToken": idToken, "accessTokenGoogle": accessTokenGoogle});
      httpSuccessHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('user', jsonEncode(res.data));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false);
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
