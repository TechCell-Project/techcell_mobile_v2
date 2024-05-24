// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:single_project/models/address_model.dart';
import 'package:single_project/models/cart_model.dart';
import 'package:single_project/models/order_model.dart';
import 'package:single_project/page/screens/main_screen.dart';
import 'package:single_project/page/tabs/order/create_order.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/util/interceptor.dart';
import 'package:single_project/util/snackbar.dart';

class ApiOrder {
  Dio dio = Dio();
  final InterceptorClass interceptorClass = InterceptorClass();
  Future<void> createOrder(
    BuildContext context,
    List<ProductOrder> products,
    int indexAdress,
  ) async {
    try {
      Dio dioWithInterceptor = interceptorClass.getDioWithInterceptor();
      Map<String, String> authServiceHeaders() {
        return {
          'accept': '*/*',
          'Content-Type': 'application/json',
        };
      }

      List<Map<String, dynamic>> productsData = products.map((product) {
        return {
          'skuId': product.skuId,
          'quantity': product.quantity,
        };
      }).toList();

      Response res = await dioWithInterceptor.post(
        uriOrder,
        data: {
          "products": productsData,
          "addressIndex": indexAdress,
          "paymentMethod": "COD",
          "orderNote": "Bọc kĩ giúp em nha!",
          "shipNote": "",
          "paymentReturnUrl": "https://techcell.cloud",
          "isSelectFromCart": true
        },
        options: Options(headers: authServiceHeaders()),
      );
      httpSuccessHandle(
        response: res,
        context: context,
        onSuccess: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false);
        },
      );
    } catch (e) {
      print(e);
      showSnackBarError(context, 'That bai');
    }
  }

  Future<void> preViewOrderFromCart(
    BuildContext context,
    int indexAdress,
    List<Product> products,
  ) async {
    Dio dioWithInterceptor = interceptorClass.getDioWithInterceptor();
    OrderModel orderModel1 = OrderModel(
        id: '',
        customer: Customer(
          customerId: '',
          email: '',
          address: AddressModel(
              provinceLevel: ProvinceLevel(provinceId: 0, provinceName: ''),
              districtLevel: DistrictLevel(districtId: 0, districtName: ''),
              wardLevel: WardLevel(wardCode: '', wardName: ''),
              detail: '',
              isDefault: false,
              customerName: '',
              type: '',
              phoneNumbers: ''),
        ),
        note: '',
        products: [],
        payment: Payment(method: '', status: '', url: '', paymentData: {}),
        orderStatus: '',
        shipping: Shipping(
            orderShipCode: '',
            provider: '',
            fee: 0,
            expectedDeliveryTime: '',
            trackingLink: '',
            logs: []),
        orderLogs: [],
        totalPrice: 0);
    List<Map<String, dynamic>> productsData = products.map((product) {
      return {
        'skuId': product.skuId,
        'quantity': product.quantity,
      };
    }).toList();
    try {
      Response res = await dioWithInterceptor.post('$uriOrder/preview', data: {
        "products": productsData,
        "addressIndex": indexAdress,
        "paymentMethod": "COD"
      });
      httpSuccessHandle(
        response: res,
        context: context,
        onSuccess: () {
          orderModel1 = OrderModel.fromJson(res.data);
          final orderResponse = orderModel1;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateOrder(
                        orderResponse: orderResponse,
                        indexAdreess: indexAdress,
                      )));
        },
      );
    } catch (e) {
      showSnackBarError(context, 'That bai');
    }
  }

  Future<void> preViewOrderBuyNow(
    BuildContext context,
    int indexAdress,
    String skuId,
  ) async {
    Dio dioWithInterceptor = interceptorClass.getDioWithInterceptor();
    OrderModel orderModel1 = OrderModel(
        id: '',
        customer: Customer(
          customerId: '',
          email: '',
          address: AddressModel(
              provinceLevel: ProvinceLevel(provinceId: 0, provinceName: ''),
              districtLevel: DistrictLevel(districtId: 0, districtName: ''),
              wardLevel: WardLevel(wardCode: '', wardName: ''),
              detail: '',
              isDefault: false,
              customerName: '',
              type: '',
              phoneNumbers: ''),
        ),
        note: '',
        products: [],
        payment: Payment(method: '', status: '', url: '', paymentData: {}),
        orderStatus: '',
        shipping: Shipping(
            orderShipCode: '',
            provider: '',
            fee: 0,
            expectedDeliveryTime: '',
            trackingLink: '',
            logs: []),
        orderLogs: [],
        totalPrice: 0);

    try {
      Response res = await dioWithInterceptor.post('$uriOrder/preview', data: {
        "products": [
          {
            'skuId': skuId,
            'quantity': 1,
          }
        ],
        "addressIndex": indexAdress,
        "paymentMethod": "COD"
      });
      httpSuccessHandle(
        response: res,
        context: context,
        onSuccess: () {
          orderModel1 = OrderModel.fromJson(res.data);
          final orderResponse = orderModel1;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateOrder(
                        orderResponse: orderResponse,
                        indexAdreess: indexAdress,
                      )));
        },
      );
    } catch (e) {
      showSnackBarError(context, 'That bai');
    }
  }

  Future<ListOrderModel> getOrder(
      BuildContext context, String orderStatus) async {
    ListOrderModel orderModel = ListOrderModel(orders: [], hasNextPage: false);
    Dio dioWithInterceptor = interceptorClass.getDioWithInterceptor();
    try {
      Response response = await dioWithInterceptor
          .get(uriOrder, queryParameters: {'filter': '[$orderStatus]'});
      httpSuccessHandle(
        response: response,
        context: context,
        onSuccess: () {
          orderModel = ListOrderModel.fromJson(response.data);
        },
      );
    } catch (e) {
      print(e);
    }

    return orderModel;
  }

  Future<OrderModel> getOrderDetail(
    BuildContext context,
    String id,
  ) async {
    OrderModel orderModel1 = OrderModel(
      id: '',
      customer: Customer(
        customerId: '',
        email: '',
        address: AddressModel(
            provinceLevel: ProvinceLevel(provinceId: 0, provinceName: ''),
            districtLevel: DistrictLevel(districtId: 0, districtName: ''),
            wardLevel: WardLevel(wardCode: '', wardName: ''),
            detail: '',
            isDefault: false,
            customerName: '',
            type: '',
            phoneNumbers: ''),
      ),
      note: '',
      products: [],
      payment: Payment(method: '', status: '', url: '', paymentData: {}),
      orderStatus: '',
      shipping: Shipping(
          orderShipCode: '',
          provider: '',
          fee: 0,
          expectedDeliveryTime: '',
          trackingLink: '',
          logs: []),
      orderLogs: [],
      totalPrice: 0,
      createdAt: '',
      updatedAt: '',
    );
    Dio dioWithInterceptor = interceptorClass.getDioWithInterceptor();
    try {
      Response response = await dioWithInterceptor.get('$uriOrder/$id');
      httpSuccessHandle(
        response: response,
        context: context,
        onSuccess: () {
          orderModel1 = OrderModel.fromJson(response.data);
        },
      );
    } catch (e) {
      print(e);
    }

    return orderModel1;
  }

  Future<void> cancellOrder(
      BuildContext context, String id, String reason) async {
    Dio dioWithInterceptor = interceptorClass.getDioWithInterceptor();
    try {
      Response res = await dioWithInterceptor
          .patch('$uriOrder/$id/cancel', data: {'reason': reason});
      httpSuccessHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBarSuccess(context, 'Thành công');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBarError(context, 'Thất bại');
    }
  }
}
