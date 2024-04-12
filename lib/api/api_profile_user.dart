// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/util/interceptor.dart';
import 'package:single_project/util/snackbar.dart';

class ApiUser {
  Dio dio = Dio();
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
      final InterceptorClass interceptorClass = InterceptorClass();
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
        },
      );
    } catch (e) {
      showSnackBarError(context, 'Thay đổi thất bại');
    }
  }
}
