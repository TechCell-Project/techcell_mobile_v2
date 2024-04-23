import 'package:flutter/cupertino.dart';
import 'package:single_project/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  ListProductModel _listProductModel = ListProductModel(
    data: [],
    hasNextPage: false,
  );
  ListProductModel get listProductModel => _listProductModel;

  void setListProductModel(ListProductModel listProductModel) {
    _listProductModel = listProductModel;
    notifyListeners();
  }
}
