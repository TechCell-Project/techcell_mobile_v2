// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:single_project/Providers/user_provider.dart';
import 'package:single_project/models/user_model.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/util/interceptor.dart';
import 'package:single_project/util/snackbar.dart';

class ApiUser {
  Dio dio = Dio();
  final InterceptorClass interceptorClass = InterceptorClass();
  Map<String, String> header() {
    return {
      'Content-Type': 'application/json',
    };
  }

  Future<void> changePasswordUser(
    BuildContext context,
    String oldPassword,
    String newPassword,
    String reNewPasswrod,
  ) async {
    try {
      Dio dioWithInterceptor = interceptorClass.getDioWithInterceptor();
      Response res = await dioWithInterceptor.patch(
        '$uriAuth/me',
        data: {
          'oldPassword': oldPassword,
          'password': newPassword,
          're_password': reNewPasswrod,
        },
        options: Options(headers: header()),
      );
      httpSuccessHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBarSuccess(context, 'Thay đổi mật khẩu thành công');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBarError(context, 'Thay đổi thất bại');
    }
  }

  Future<void> changeProfileUser(
      BuildContext context, String firstName, String lastName) async {
    try {
      Dio dioWithInterceptor = interceptorClass.getDioWithInterceptor();
      Response response = await dioWithInterceptor.patch(
        '$uriAuth/me',
        data: {
          'firstName': firstName,
          'lastName': lastName,
        },
      );
      httpSuccessHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBarSuccess(context, 'Thanh cong');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBarError(context, 'Thay đổi thất bại');
    }
  }

  Future<User> getProfileUser(BuildContext context) async {
    User user = User(
      email: '',
      emailVerified: true,
      provider: '',
      socialId: '',
      firstName: '',
      lastName: '',
      role: '',
      avatar: Avatar(publicId: '', url: ''),
      address: [],
      createdAt: '',
      updatedAt: '',
    );
    try {
      Dio dioWithInterceptor = interceptorClass.getDioWithInterceptor();
      var res = await dioWithInterceptor.get('$uriAuth/me');
      httpSuccessHandle(
        response: res,
        context: context,
        onSuccess: () {
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          user = User.fromJson(jsonEncode(res.data));
          userProvider.setUser(user);
          print(userProvider.user.createdAt);
          print(userProvider.user.updatedAt);
        },
      );
    } catch (e, i) {
      print(i);
      print(e);
    }
    return user;
  }
}
