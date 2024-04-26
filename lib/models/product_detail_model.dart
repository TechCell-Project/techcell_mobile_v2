class ProductDetailModel {
  final String productId;
  final String productName;
  final String description;
  final List<ProductAttribute> attributes;
  final List<ProductImage> images;
  final List<ProductVariation> variations;

  ProductDetailModel({
    required this.productId,
    required this.productName,
    required this.description,
    required this.attributes,
    required this.images,
    required this.variations,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      productId: json['productId'],
      productName: json['productName'],
      description: json['description'],
      attributes: (json['attributes'] as List)
          .map((attrJson) => ProductAttribute.fromJson(attrJson))
          .toList(),
      images: (json['images'] as List)
          .map((imgJson) => ProductImage.fromJson(imgJson))
          .toList(),
      variations: (json['variations'] as List)
          .map((varJson) => ProductVariation.fromJson(varJson))
          .toList(),
    );
  }
}

class ProductAttribute {
  final String key;
  final String value;
  final String unit;
  final String name;

  ProductAttribute({
    required this.key,
    required this.value,
    required this.unit,
    required this.name,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    return ProductAttribute(
      key: json['k'],
      value: json['v'],
      unit: json['u'],
      name: json['name'],
    );
  }
}

class ProductImage {
  final String publicId;
  final String url;
  final bool isThumbnail;

  ProductImage({
    required this.publicId,
    required this.url,
    required this.isThumbnail,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      publicId: json['publicId'],
      url: json['url'],
      isThumbnail: json['isThumbnail'],
    );
  }
}

class ProductVariation {
  String skuId;
  ProductPrice price;
  List<ProductAttribute> attributes;
  ProductImage image;
  List<String> tags;

  ProductVariation({
    required this.skuId,
    required this.price,
    required this.attributes,
    required this.image,
    required this.tags,
  });

  factory ProductVariation.fromJson(Map<String, dynamic> json) {
    return ProductVariation(
      skuId: json['skuId'],
      price: ProductPrice.fromJson(json['price']),
      attributes: (json['attributes'] as List)
          .map((attrJson) => ProductAttribute.fromJson(attrJson))
          .toList(),
      image: json['image'] != null
          ? ProductImage.fromJson(json['image'])
          : ProductImage(publicId: '', url: '', isThumbnail: false),
      tags: List<String>.from(json['tags']),
    );
  }
}

class ProductPrice {
  final int base;
  final int special;

  ProductPrice({
    required this.base,
    required this.special,
  });

  factory ProductPrice.fromJson(Map<String, dynamic> json) {
    return ProductPrice(
      base: json['base'],
      special: json['special'],
    );
  }
}
