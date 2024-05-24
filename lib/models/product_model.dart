import 'dart:convert';

class ListProductModel {
  List<ListProductResponse> data;
  bool hasNextPage;

  ListProductModel({required this.data, required this.hasNextPage});

  factory ListProductModel.fromJson(Map<String, dynamic> json) {
    return ListProductModel(
      data: json["data"] != null
          ? List<ListProductResponse>.from(
              (json["data"] as List?) // Access "data" instead of "address"
                      ?.where((x) => x != null)
                      .map((x) => ListProductResponse.fromJson(
                          x as Map<String, dynamic>))
                      .toList() ??
                  [],
            )
          : [],
      hasNextPage: json['hasNextPage'] ?? false,
    );
  }
  Map<String, dynamic> toJson() => {
        "data": data,
        "hasNextPage": hasNextPage,
      };
  factory ListProductModel.fromRawJson(String str) =>
      ListProductModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());
}

class ListProductResponse {
  String id;
  String name;
  String modelName;
  String brandName;
  List<ImageModel> imageModel;
  PriceModel price;
  List<String> tag;

  ListProductResponse({
    required this.id,
    required this.name,
    required this.modelName,
    required this.brandName,
    required this.imageModel,
    required this.price,
    required this.tag,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'modelName': modelName,
      'brandName': brandName,
      'imageModel': imageModel.map((x) => x.toMap()).toList(),
      'tag': tag,
      'price': price.toMap(),
    };
  }

  factory ListProductResponse.fromJson(Map<String, dynamic> json) {
    return ListProductResponse(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        modelName: json['modelName'] ?? '',
        brandName: json['brandName'] ?? '',
        imageModel: (json['images'] as List<dynamic>?)
                ?.map((imageJson) => ImageModel.fromJson(imageJson))
                .toList() ??
            [],
        tag: json['tag'] ?? [],
        price: PriceModel.fromJson(
          json['price'] ?? {},
        ));
  }
}

class ImageModel {
  String url;
  String publicId;
  bool isThumbnail;

  ImageModel({
    required this.url,
    required this.publicId,
    required this.isThumbnail,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'publicId': publicId,
      'isThumbnail': isThumbnail,
    };
  }

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      url: json['url'] ?? '',
      publicId: json['publicId'] ?? '',
      isThumbnail: json['isThumbnail'] ?? false,
    );
  }
}

class PriceModel {
  int special;
  int base;
  PriceModel({
    required this.special,
    required this.base,
  });
  Map<String, dynamic> toMap() {
    return {
      'special': special,
      'base': base,
    };
  }

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      special: json['special'] ?? 0,
      base: json['base'] ?? 0,
    );
  }
}
