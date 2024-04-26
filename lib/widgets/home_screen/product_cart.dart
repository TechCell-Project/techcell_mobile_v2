// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:single_project/api/api_product.dart';
import 'package:single_project/models/product_model.dart';

import 'package:single_project/widgets/home_screen/in_frame_product.dart';

class ProductCart extends StatefulWidget {
  final ScrollController scrollController;
  const ProductCart(this.scrollController, {super.key});

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  ListProductModel products = ListProductModel(data: [], hasNextPage: false);
  int page = 1;
  int pageSize = 4;
  bool isLoading = false;

  Future<void> _fetchProducts(int index) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      try {
        final fetchedProducts = await ProductApi().getProductWithLiimit(
          context,
          index,
          pageSize,
        );
        setState(() {
          products.data.addAll(fetchedProducts.data);
          page++;
          isLoading = false;
        });
      } catch (error) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _scrollListener() {
    if (widget.scrollController.position.pixels ==
        widget.scrollController.position.maxScrollExtent) {
      _fetchProducts(page);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProducts(page);
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration:
            const BoxDecoration(color: Color.fromRGBO(247, 247, 247, 1)),
        child: Column(
          children: [
            _buildProduct(products),
            _buildProgressIndicator(isLoading),
          ],
        ),
      ),
    );
  }

  Widget _buildProduct(ListProductModel products) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: InFrameProduct(
          products: products,
        ));
  }

  Widget _buildProgressIndicator(isLoading) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 0.0,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
