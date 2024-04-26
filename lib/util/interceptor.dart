// ignore_for_file: avoid_print, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_project/models/user_model.dart';
import 'package:single_project/util/constants.dart';

class InterceptorClass {
  Dio? dioWithInterceptor;
  bool isRefreshing = false;

  InterceptorClass() {
    dioWithInterceptor = getDioWithInterceptor();
  }
  bool isAccessTokenValid(int accessTokenExpires) {
    final currentTimeInMilliseconds = DateTime.now().millisecondsSinceEpoch;
    final expirationTimeInMilliseconds = accessTokenExpires * 1000;
    return currentTimeInMilliseconds < expirationTimeInMilliseconds;
  }

  Dio getDioWithInterceptor() {
    Dio dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();

          options.connectTimeout = const Duration(seconds: 3000);
          options.receiveTimeout = const Duration(seconds: 3000);

          // Lấy các token được lưu tạm từ local storage
          String? accessToken = '';
          int? expiredTime = 0;
          String? refreshToken1 = '';
          final userJson = prefs.getString('user');

          if (userJson != null) {
            final user = AuthModel.fromJson(userJson);
            final refreshToken = user.refreshToken;
            final expiredTime1 = user.accessTokenExpires;
            final accessToken1 = user.accessToken;
            refreshToken1 = refreshToken;
            accessToken = accessToken1;
            expiredTime = expiredTime1 * 1000;
          } else {
            print('không tìm thấy refreshToken');
          }
          if (expiredTime != 0) {
            final expiredTimeMilliseconds = int.parse(expiredTime.toString());
            final expiredTimeInSeconds = expiredTimeMilliseconds ~/ 1000;
            expiredTime = expiredTimeInSeconds;
          }
          // final expiredTimeConvert = DateTime.parse(expiredTime.toString());
          // final isExpired = DateTime.now().isAfter(expiredTimeConvert);
          if (expiredTime == 0) {
            print('vao check');
            try {
              print('vao trong cho nay');
              final response = await dio.post(
                '$uriAuth/refresh',
                data: {"refreshToken": refreshToken1},
              );
              if (response.statusCode == 200) {
                if (response.data != false) {
                  options.headers['Authorization'] =
                      "Bearer ${response.data["accessToken"]}";
                  final expiredTime = Duration(
                      seconds: response.data["accessTokenExpires"] - 240);
                  await prefs.setString(
                      "accessToken", response.data["accessToken"]);
                  await prefs.setString(
                      "accessTokenExpires", expiredTime.toString());
                } else {
                  print('access token expired');
                }
              } else {
                print('access token expired 1');
              }
              return handler.next(options);
            } on DioError catch (error) {
              print('refresh token expired 2');
              return handler.reject(error, true);
            }
          } else {
            print('access token valid');
            options.headers['Authorization'] = "Bearer $accessToken";
            return handler.next(options);
          }
        },
        onResponse: (Response response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) async {
          final prefs = await SharedPreferences.getInstance();

          String? refreshToken1 = '';
          final userJson = prefs.getString('user');

          if (userJson != null) {
            final user = AuthModel.fromJson(userJson);
            final refreshToken = user.refreshToken;

            refreshToken1 = refreshToken;
          } else {
            print('không tìm thấy refreshToken');
          }
          if (error.response?.statusCode == 401) {
            try {
              print('vao trong cho error');
              final response = await dio.post(
                '$uriAuth/refresh',
                data: {"refreshToken": refreshToken1},
              );
              if (response.statusCode == 200) {
                if (response.data != false) {
                  await prefs.setString(
                      "accessToken", response.data["accessToken"]);
                } else {
                  print('access token expired');
                }
              } else {
                print('access token expired 1');
              }
            } on DioError catch (error) {
              print('refresh token expired 2');
              return handler.reject(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
    return dio;
  }
}
