// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:single_project/models/cart_model.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/util/interceptor.dart';
import 'package:single_project/util/snackbar.dart';

class ApiCart {
  Dio dio = Dio();
  final InterceptorClass interceptorClass = InterceptorClass();

  Future<void> addToCart(
    BuildContext context,
    String productId,
    String skuId,
  ) async {
    try {
      Dio dioWithInterceptor = interceptorClass.getDioWithInterceptor();
      Response res = await dioWithInterceptor.post(uriCart, data: {
        "products": [
          {
            "productId": productId,
            "skuId": skuId,
            "quantity": 1,
          }
        ]
      });
      httpSuccessHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBarSuccess(context, 'Thanh cong');
          });
    } catch (e) {
      print(e);
      showSnackBarError(context, 'That bai');
    }
  }

  Future<void> updateCart(
    BuildContext context,
    String productId,
    String skuId,
    int quantity,
  ) async {
    try {
      Dio dioWithInterceptor = interceptorClass.getDioWithInterceptor();
      Response res = await dioWithInterceptor.post(uriCart, data: {
        "products": [
          {
            "productId": productId,
            "skuId": skuId,
            "quantity": quantity,
          }
        ]
      });
      httpSuccessHandle(response: res, context: context, onSuccess: () {});
    } catch (e) {
      showSnackBarError(context, 'That bai');
    }
  }

  Future<CartItem> getCart(BuildContext context) async {
    CartItem cartItem = CartItem(userId: '', products: []);
    try {
      Dio dioWithInterceptor = interceptorClass.getDioWithInterceptor();
      Response res = await dioWithInterceptor.get(uriCart);
      httpSuccessHandle(
        response: res,
        context: context,
        onSuccess: () {
          cartItem = CartItem.fromJson(res.data);
        },
      );
    } catch (e, i) {
      print(e);
      print(i);
      showSnackBarError(context, 'That bai');
    }
    return cartItem;
  }
}
