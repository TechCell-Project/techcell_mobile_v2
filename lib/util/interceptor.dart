// ignore_for_file: avoid_print

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
    Dio dio = Dio()
      ..options.connectTimeout = const Duration(seconds: 3)
      ..options.receiveTimeout = const Duration(seconds: 3);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _handleOnRequest,
        onResponse: _handleOnResponse,
        onError: _handleOnError,
      ),
    );

    return dio;
  }

  Future<void> _handleOnRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson != null) {
      final user = AuthModel.fromJson(userJson);
      options.headers['Authorization'] = "Bearer ${user.accessToken}";
    }

    handler.next(options);
  }

  void _handleOnResponse(
      Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  Future<void> _handleOnError(
      // ignore: deprecated_member_use
      DioError error,
      ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401 && !isRefreshing) {
      isRefreshing = true;

      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');

      if (userJson != null) {
        final user = AuthModel.fromJson(userJson);
        final refreshToken = user.refreshToken;

        try {
          final response = await dioWithInterceptor!.post(
            '$uriAuth/refresh',
            data: {"refreshToken": refreshToken},
            options: Options(headers: {"Content-Type": "application/json"}),
          );

          if (response.statusCode == 200 && response.data != false) {
            final newAccessToken = response.data["accessToken"];
            user.accessToken = newAccessToken;
            await prefs.setString('user', user.toJson());

            // Retry the original request with the new access token
            final retryOptions = error.requestOptions;
            retryOptions.headers['Authorization'] = "Bearer $newAccessToken";
            final cloneReq = await dioWithInterceptor!.request(
              retryOptions.path,
              options: Options(
                method: retryOptions.method,
                headers: retryOptions.headers,
              ),
              data: retryOptions.data,
              queryParameters: retryOptions.queryParameters,
            );
            handler.resolve(cloneReq);
          } else {
            print(
                'Failed to refresh token, status code: ${response.statusCode}');
            handler.reject(error);
          }
        } catch (e) {
          print('Refresh token request failed: $e');
          handler.reject(error);
        } finally {
          isRefreshing = false;
        }
      } else {
        print('User data not found in SharedPreferences');
        handler.reject(error);
      }
    } else {
      handler.next(error);
    }
  }
}
