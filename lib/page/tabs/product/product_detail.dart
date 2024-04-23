// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:single_project/api/api_product.dart';
import 'package:single_project/models/product_detail_model.dart';
import 'package:single_project/page/tabs/product/header_product.dart';
import 'package:single_project/widgets/product_detail/animated_to_slider.dart';
import 'package:single_project/widgets/product_detail/infor_product.dart';
import 'package:single_project/widgets/product_detail/slider_image.dart';

class ProductDetail extends StatefulWidget {
  String id;
  ProductDetail({super.key, required this.id});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ProductDetailModel>(
        future: ProductApi().getProductById(context, widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return Container();
          } else if (snapshot.hasError || snapshot.data == null) {
            return Container();
          }
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                SliderImgProduct(
                                  productDetail: snapshot.data!.images,
                                ),
                                AnimateToSlider(
                                    productDetail: snapshot.data!.images),
                                InforProduct(
                                  productDetail: snapshot.data!,
                                ),
                              ],
                            ),
                          ),
                          // _builPurchaseSuggestions(),
                        ],
                      ),
                    ),
                    HeaderProductDetail(scrollController),
                  ],
                ),
              ),
            ),
            // bottomNavigationBar: _buildBottom(),
          );
        },
      ),
    );
  }
}
