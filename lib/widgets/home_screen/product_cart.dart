// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:single_project/api/api_product.dart';
import 'package:single_project/models/product_model.dart';
import 'package:single_project/util/constants.dart';

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
            const BoxDecoration(color: Color.fromRGBO(230, 230, 230, 1)),
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
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          mainAxisExtent: 320,
        ),
        itemCount: products.data.length,
        itemBuilder: (context, index) {
          if (products.data.isNotEmpty) {
            return Container(
              width: size.width * 0.4,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  if (products.data[index].imageModel.url != '')
                    Image(
                      image: NetworkImage(products.data[index].imageModel.url),
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  else
                    Image.asset('assets/images/galaxy-z-fold-5-xanh-1.png'),
                  Text(
                    products.data[index].modelName,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (products.data[index].price.special != 0)
                    Row(
                      children: [
                        Text(
                          formatCurrency
                              .format(products.data[index].price.special),
                          style: const TextStyle(
                            color: primaryColors,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          formatCurrency
                              .format(products.data[index].price.base),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      formatCurrency.format(products.data[index].price.base),
                      style: const TextStyle(
                        color: primaryColors,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                ],
              ),
            );
          } else {
            // Handle case when data is empty
            return const SizedBox();
          }
        },
      ),
    );
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
