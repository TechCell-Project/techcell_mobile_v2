import 'package:single_project/models/address_model.dart';
import 'package:single_project/models/product_detail_model.dart';
import 'package:single_project/models/product_model.dart';

class ListOrderModel {
  List<OrderModel> orders;
  bool hasNextPage;
  ListOrderModel({
    required this.orders,
    required this.hasNextPage,
  });

  factory ListOrderModel.fromJson(Map<String, dynamic> json) {
    return ListOrderModel(
      orders: List<OrderModel>.from(
          json['data'].map((x) => OrderModel.fromJson(x))),
      hasNextPage: json['hasNextPage'],
    );
  }
}

class OrderModel {
  String id;
  Customer customer;
  String note;
  List<ProductOrder> products;
  Payment payment;
  String orderStatus;
  Shipping shipping;
  List<OrderLog> orderLogs;
  int totalPrice;
  String? createdAt;
  String? updatedAt;

  OrderModel({
    required this.id,
    required this.customer,
    required this.note,
    required this.products,
    required this.payment,
    required this.orderStatus,
    required this.shipping,
    required this.orderLogs,
    required this.totalPrice,
    this.createdAt,
    this.updatedAt
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'] ?? '',
      customer: Customer.fromJson(json['customer']),
      note: json['note'] ?? '',
      products: (json['products'] as List)
          .map((productJson) => ProductOrder.fromJson(productJson))
          .toList(),
      payment: Payment.fromJson(json['payment']),
      orderStatus: json['orderStatus'] ?? '',
      shipping: Shipping.fromJson(json['shipping']),
      orderLogs: (json['orderLogs'] as List)
          .map((logJson) => OrderLog.fromJson(logJson))
          .toList(),
      totalPrice: json['totalPrice'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class Customer {
  String customerId;
  String email;
  AddressModel address;

  Customer({
    required this.customerId,
    required this.email,
    required this.address,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerId: json['customerId'],
      email: json['email'],
      address: AddressModel.fromJson(json['address']),
    );
  }
}

class ProductOrder {
  String skuId;
  String productName;
  String productType;
  List<String> serialNumber;
  ImageModel image;
  ProductPrice unitPrice;
  int quantity;

  ProductOrder({
    required this.skuId,
    required this.productName,
    required this.productType,
    required this.serialNumber,
    required this.image,
    required this.unitPrice,
    required this.quantity,
  });

  factory ProductOrder.fromJson(Map<String, dynamic> json) {
    return ProductOrder(
      skuId: json['skuId'],
      productName: json['productName'],
      productType: json['productType'] ?? '',
      serialNumber: List<String>.from(json['serialNumber']),
      image: json['image'] != null
          ? ImageModel.fromJson(json['image'])
          : ImageModel(publicId: '', url: '', isThumbnail: false),
      unitPrice: ProductPrice.fromJson(json['unitPrice']),
      quantity: json['quantity'],
    );
  }
}

class Payment {
  String method;
  String status;
  String url;
  Map<String, dynamic> paymentData;

  Payment({
    required this.method,
    required this.status,
    required this.url,
    required this.paymentData,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      method: json['method'] ?? '',
      status: json['status'] ?? '',
      url: json['url'] ?? '',
      paymentData: json['paymentData'] ?? {},
    );
  }
}

class Shipping {
  String orderShipCode;
  String provider;
  int fee;
  String expectedDeliveryTime;
  String trackingLink;
  List<String> logs;

  Shipping({
    required this.orderShipCode,
    required this.provider,
    required this.fee,
    required this.expectedDeliveryTime,
    required this.trackingLink,
    required this.logs,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      orderShipCode: json['orderShipCode'] ?? '',
      provider: json['provider'] ?? '',
      fee: json['fee'] ?? '',
      expectedDeliveryTime: json['expectedDeliveryTime'] ?? '',
      trackingLink: json['trackingLink'] ?? '',
      logs: List<String>.from(json['logs'] ?? []),
    );
  }
}

class OrderLog {
  String actorId;
  String action;
  String note;

  OrderLog({
    required this.actorId,
    required this.action,
    required this.note,
  });

  factory OrderLog.fromJson(Map<String, dynamic> json) {
    return OrderLog(
      actorId: json['actorId'],
      action: json['action'],
      note: json['note'],
    );
  }
}
