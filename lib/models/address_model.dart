import 'dart:convert';

class AddressModel {
  ProvinceLevel provinceLevel;
  DistrictLevel districtLevel;
  WardLevel wardLevel;
  String detail;
  bool isDefault;
  String customerName;
  String type;

  AddressModel({
    required this.provinceLevel,
    required this.districtLevel,
    required this.wardLevel,
    required this.detail,
    required this.isDefault,
    required this.customerName,
    required this.type,
  });
  factory AddressModel.fromRawJson(String str) =>
      AddressModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());
  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        provinceLevel: ProvinceLevel.fromJson(json["provinceLevel"]),
        districtLevel: DistrictLevel.fromJson(json["districtLevel"]),
        wardLevel: WardLevel.fromJson(json["wardLevel"]),
        detail: json["detail"],
        isDefault: json["isDefault"] ?? true,
        customerName: json["customerName"],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        "provinceLevel": provinceLevel.toJson(),
        "districtLevel": districtLevel.toJson(),
        "wardLevel": wardLevel.toJson(),
        "detail": detail,
        "isDefault": isDefault,
        "customerName": customerName,
        "type": type,
      };
}

class ProvinceLevel {
  int provinceId;
  ProvinceLevel({required this.provinceId});
  factory ProvinceLevel.fromRawJson(String str) =>
      ProvinceLevel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProvinceLevel.fromJson(Map<String, dynamic> json) => ProvinceLevel(
        provinceId: json["provinceId"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "provinceId": provinceId,
      };
}

class DistrictLevel {
  int districtId;
  DistrictLevel({required this.districtId});
  factory DistrictLevel.fromRawJson(String str) =>
      DistrictLevel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DistrictLevel.fromJson(Map<String, dynamic> json) => DistrictLevel(
        districtId: json["districtId"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "districtId": districtId,
      };
}

class WardLevel {
  String wardId;
  WardLevel({required this.wardId});
  factory WardLevel.fromRawJson(String str) =>
      WardLevel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WardLevel.fromJson(Map<String, dynamic> json) => WardLevel(
        wardId: json["wardId"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "wardId": wardId,
      };
}
