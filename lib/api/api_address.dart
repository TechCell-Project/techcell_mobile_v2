import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:single_project/models/address_model.dart';
import 'package:single_project/util/constants.dart';

class ApiAddress {
  Dio dio = Dio();
  Future<void> addAdressUser(
    BuildContext context,
    AddressModel address,
  ) async {
    try {} catch (e) {}
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
