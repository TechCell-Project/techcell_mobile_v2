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
            expiredTime = expiredTime1;
          } else {
            print('không tìm thấy refreshToken');
          }
          // Kiểm tra xem user có đăng nhập hay chưa. Nếu chưa thì call handler.next(options)
          // để trả data về tiếp client
          if (expiredTime == 0) {
            if (!isRefreshing) {
              isRefreshing = true;
              try {
                final response = await dio.post(
                  '$uriAuth/refresh',
                  data: {"refreshToken": refreshToken1},
                );
                if (response.statusCode == 200) {
                  if (response.data != false) {
                    options.headers['Authorization'] =
                        "Bearer ${response.data["accessToken"]}";
                    final expiredTime = DateTime.now().add(Duration(
                        seconds: response.data["accessTokenExpires"] - 240));
                    await prefs.setString(
                        "accessToken", response.data["accessToken"]);
                    await prefs.setString(
                        "accessTokenExpires", expiredTime.toString());
                  }
                }
              } catch (error) {
                print(
                    'Lỗi khi gửi yêu cầu refresh token cua thang null: $error');
              } finally {
                isRefreshing = false;
              }
            }
            return handler.next(options);
          }

          if (expiredTime == 0) {
            try {
              final response = await dio.post(
                '$uriAuth/refresh',
                data: {"refreshToken": refreshToken1},
              );
              if (response.statusCode == 200) {
                if (response.data != false) {
                  options.headers['Authorization'] =
                      "Bearer ${response.data["accessToken"]}";
                  final expiredTime = DateTime.now().add(Duration(
                      seconds: response.data["accessTokenExpires"] - 240));
                  await prefs.setString(
                      "accessToken", response.data["accessToken"]);
                  await prefs.setString("expiredTime", expiredTime.toString());
                } else {
                  print('refresh token expired');
                }
              } else {
                print('refresh token expired 1');
              }
              return handler.next(options);
            } on DioError catch (error) {
              print('refresh token expired 2');
              return handler.reject(error, true);
            }
          } else {
            options.headers['Authorization'] = "Bearer $accessToken";
            return handler.next(options);
          }
        },
        onResponse: (Response response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            print('refresh token expired 3');
          }
          return handler.next(error);
        },
      ),
    );
    return dio;
  }
}
