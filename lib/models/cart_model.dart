class CartItem {
  String userId;
  List<Product> products;

  CartItem({
    required this.userId,
    required this.products,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      userId: json['userId'],
      products: (json['products'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
    );
  }
}

class Product {
  String productId;
  String skuId;
  int quantity;
  String createdAt;
  String updatedAt;

  Product({
    required this.productId,
    required this.skuId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      skuId: json['skuId'],
      quantity: json['quantity'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
