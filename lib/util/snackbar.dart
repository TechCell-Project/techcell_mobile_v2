import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:single_project/util/constants.dart';

void showSnackBarError(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline,
            size: 30,
            color: Colors.white,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    ),
    showCloseIcon: true,
    closeIconColor: Colors.white,
    behavior: SnackBarBehavior.floating,
    backgroundColor: primaryColors,
  ));
}

void showSnackBarSuccess(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Icon(
              Icons.check_circle,
              size: 30,
              color: Colors.white,
            ),
            const SizedBox(width: 5),
            Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
    ),
  );
}

void httpSuccessHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 201:
      onSuccess();
      break;
    case 400:
      showSnackBarError(
        context,
        'Loi 400',
      );
      break;
    case 401:
      showSnackBarError(
        context,
        'Tài khoản hoặc mật khẩu sai',
      );
    case 403:
      showSnackBarError(context, 'Tài khoản của bạn bị khóa!');
    case 404:
      showSnackBarError(
        context,
        'Tài khoản hoặc mật khẩu bị sai',
      );
      break;
    case 406:
      showSnackBarError(
        context,
        'Tài khoản của bạn chưa được xác thực',
      );
      break;

    case 429:
      showSnackBarError(
        context,
        jsonDecode(response.body)['error'],
      );
      break;
    case 502:
      showSnackBarError(context, 'loi o day');
    default:
      showSnackBarError(context, response.body);
  }
}
