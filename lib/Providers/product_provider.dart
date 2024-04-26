import 'package:flutter/cupertino.dart';
import 'package:single_project/models/product_detail_model.dart';

class ProductProvider extends ChangeNotifier {
  ProductDetailModel _productDetailModel = ProductDetailModel(
    productId: '',
    productName: '',
    description: '',
    attributes: [],
    images: [],
    variations: [],
  );
  ProductDetailModel get productDetailModel => _productDetailModel;

  void setProductDetailModel(ProductDetailModel listProductModel) {
    _productDetailModel = listProductModel;
    notifyListeners();
  }
}
