// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:single_project/Providers/product_provider.dart';
import 'package:single_project/models/product_detail_model.dart';
import 'package:single_project/models/product_model.dart';
import 'package:single_project/util/snackbar.dart';

class ProductApi {
  Dio dio = Dio();
  Future<ListProductModel> getProducts(BuildContext context) async {
    ListProductModel listProduct =
        ListProductModel(data: [], hasNextPage: false);
    try {
      Response res = await dio.get('https://api.techcell.cloud/api/products');

      httpSuccessHandle(
        context: context,
        response: res,
        onSuccess: () {
          Map<String, dynamic> responseData = res.data;
          listProduct = ListProductModel.fromJson(responseData);
        },
      );
    } catch (e) {
      showSnackBarError(context, 'that bai');
    }
    return listProduct;
  }

  Future<ListProductModel> getProductWithLiimit(
      BuildContext context, int page, int pageSize) async {
    ListProductModel listProduct =
        ListProductModel(data: [], hasNextPage: false);
    try {
      Response res = await dio.get(
          'https://api.techcell.cloud/api/products?page=$page&limit=$pageSize');

      httpSuccessHandle(
        context: context,
        response: res,
        onSuccess: () {
          Map<String, dynamic> responseData = res.data;
          listProduct = ListProductModel.fromJson(responseData);
        },
      );
    } catch (e) {
      showSnackBarError(context, 'that bai');
    }
    return listProduct;
  }

  Future<ProductDetailModel> getProductById(
      BuildContext context, String id) async {
    ProductDetailModel productDetail = ProductDetailModel(
        productId: '',
        productName: '',
        description: '',
        attributes: [],
        images: [],
        variations: []);
    try {
      var productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      Response res =
          await dio.get('https://api.techcell.cloud/api/products/$id');
      httpSuccessHandle(
          response: res,
          context: context,
          onSuccess: () {
            Map<String, dynamic> responseData = res.data;
            productDetail = ProductDetailModel.fromJson(responseData);
            productProvider.setProductDetailModel(productDetail);
          });
    } catch (e) {
      showSnackBarError(context, 'that bai');
    }
    return productDetail;
  }
}
