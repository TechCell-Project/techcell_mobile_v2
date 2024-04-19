// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:single_project/Providers/user_provider.dart';
import 'package:single_project/models/address_model.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/util/interceptor.dart';
import 'package:single_project/util/snackbar.dart';

class ApiAddress {
  Dio dio = Dio();
  final InterceptorClass interceptorClass = InterceptorClass();
  Map<String, String> header() {
    return {
      'Content-Type': 'application/json',
    };
  }

  Future<void> addAdressUser(
    BuildContext context,
    AddressModel address,
  ) async {
    try {
      Dio dioWithInterceptor = interceptorClass.getDioWithInterceptor();
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      List<AddressModel> allAddress = userProvider.user.address;
      allAddress.add(address);
      Response res = await dioWithInterceptor.patch(
        '$uriAuth/me',
        data: {"address": allAddress},
        options: Options(headers: header()),
      );
      httpSuccessHandle(
        response: res,
        context: context,
        onSuccess: () {
          Navigator.pop(context);
          showSnackBarSuccess(context, 'Thay đổi thành công');
        },
      );
    } catch (e) {
      print(e);
      showSnackBarError(context, 'Thay đổi thất bại');
    }
  }

  void updateAddress(
      List<AddressModel> addresses, AddressModel addressModel, int index) {
    if (index >= 0 && index < addresses.length) {
      addresses[index] = AddressModel(
        type: addressModel.type,
        customerName: addressModel.customerName,
        phoneNumbers: addressModel.phoneNumbers,
        provinceLevel: addressModel.provinceLevel,
        districtLevel: addressModel.districtLevel,
        wardLevel: addressModel.wardLevel,
        detail: addressModel.detail,
        isDefault: addressModel.isDefault,
      );
    }
  }

  Future<void> changeAdreesUser(
    BuildContext context,
    List<AddressModel> address,
  ) async {
    try {
      Dio dioWithInterceptor = interceptorClass.getDioWithInterceptor();
      Response res = await dioWithInterceptor.patch(
        '$uriAuth/me',
        data: {"address": address},
        options: Options(headers: header()),
      );
      httpSuccessHandle(
        response: res,
        context: context,
        onSuccess: () {
          Navigator.pop(context);
          showSnackBarSuccess(context, 'Thay đổi thành công');
        },
      );
    } catch (e) {
      print(e);
      showSnackBarError(context, 'Thay đổi thất bại');
    }
  }

  Future<List<ProvinceLevel>> getProvince() async {
    List<ProvinceLevel> provinces = [];
    final res = await dio.get('$uriAddress/provinces');
    if (res.statusCode == 200) {
      print(res.data);
      List<dynamic> mapProvince = jsonDecode(jsonEncode(res.data));
      if (!mapProvince.isNotEmpty) {
        throw Exception('Failed to load data');
      }

      for (int i = 0; i < mapProvince.length; i++) {
        if (mapProvince[i] != null) {
          provinces.add(ProvinceLevel.fromJson(mapProvince[i]));
        }
      }
      return provinces;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<DistrictLevel>> getDistrict(int id) async {
    List<DistrictLevel> districts = [];
    final res = await dio.get('$uriAddress/districts/$id');
    if (res.statusCode == 200) {
      print(res.data);
      List<dynamic> mapDistrict = jsonDecode(jsonEncode(res.data));
      if (!mapDistrict.isNotEmpty) {
        throw Exception('Failed to load data');
      }

      for (int i = 0; i < mapDistrict.length; i++) {
        if (mapDistrict[i] != null) {
          districts.add(DistrictLevel.fromJson(mapDistrict[i]));
        }
      }
      return districts;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<WardLevel>> getWards(int id) async {
    List<WardLevel> wards = [];
    final res = await dio.get('$uriAddress/wards/$id');
    if (res.statusCode == 200) {
      print(res.data);
      List<dynamic> mapWard = jsonDecode(jsonEncode(res.data));
      if (!mapWard.isNotEmpty) {
        throw Exception('Failed to load data');
      }

      for (int i = 0; i < mapWard.length; i++) {
        if (mapWard[i] != null) {
          wards.add(WardLevel.fromJson(mapWard[i]));
        }
      }
      return wards;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
