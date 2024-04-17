// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:single_project/models/user_model.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/util/interceptor.dart';
import 'package:single_project/util/snackbar.dart';
import 'package:http_parser/http_parser.dart';

class AvatarApi {
  final InterceptorClass interceptorClass = InterceptorClass();
  Dio dio = Dio();

  Future<Avatar?> postImage({
    required BuildContext context,
    File? image,
  }) async {
    try {
      Dio dioWithInterceptor = interceptorClass.getDioWithInterceptor();
      String fileType = image!.path.split('.').last.toLowerCase();
      var validExtensions = ['.jpeg', '.jpg', '.png', '.gif', '.webp'];
      if (!validExtensions.contains('.$fileType')) {
        return null;
      }
      print(image);
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          image.path,
          filename: 'images',
          contentType: MediaType('image', '.$fileType'),
        ),
      });
      print(formData.boundary);
      Response response =
          await dioWithInterceptor.post('https://api.techcell.cloud/api/images',
              data: formData,
              options: Options(
                contentType: 'multipart/form-data',
              ));
      if (response.statusCode == 400) {
        print('no bi 400');
      }

      httpSuccessHandle(
        response: response,
        context: context,
        onSuccess: () {
          // var avatarRespone = Avatar.fromMap(response.data);
          showSnackBarSuccess(context, 'thanh cong');

          // changePasswordUser(context, avatarRespone.publicId);
        },
      );
    } catch (e, i) {
      print(i);
      showSnackBarError(context, 'loi o trong file nay');
      return null;
    }
    return null;
  }

  Future<void> changePasswordUser(BuildContext context, String imageId) async {
    try {
      Dio dioWithInterceptor = interceptorClass.getDioWithInterceptor();
      Response res = await dioWithInterceptor.patch(
        '$uriAuth/me',
        data: {"avatarImageId": imageId},
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
}
