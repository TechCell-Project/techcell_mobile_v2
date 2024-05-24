import 'package:flutter/material.dart';
import 'package:single_project/api/api_product.dart';
import 'package:single_project/models/product_model.dart';
import 'package:single_project/page/tabs/product/product_detail.dart';
import 'package:single_project/util/constants.dart';

class SearchProduct extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.close,
          size: 30,
          color: primaryColors,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        size: 30,
        color: primaryColors,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: FutureBuilder<ListProductModel>(
          future: ProductApi().getProducts(context, query: query),
          builder: (context, snapshot) {
            if (snapshot.hasError || !snapshot.hasData) {
              return Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (snapshot.data == null) {
              return const Center(
                child: Text('No Data!'),
              );
            }

            if (snapshot.data!.data.isEmpty) {
              return Column(
                children: [
                  Container(
                    height: 150,
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Sản phẩm không tồn tại!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 250,
                    width: 400,
                    color: Colors.white,
                    child: Image.asset(
                      'assets/images/data_empty.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            }
            ListProductModel? products = snapshot.data;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                mainAxisExtent: 320,
              ),
              itemCount: products?.data.length,
              itemBuilder: (context, index) {
                final product = products!.data[index];
                Size size = MediaQuery.of(context).size;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetail(
                          id: product.id,
                          basePrice: product.price.base,
                          specialPrice: product.price.special,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: size.width * 0.4,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        if (product.imageModel.isNotEmpty)
                          Image(
                            image: NetworkImage(product.imageModel[0].url),
                            height: 160,
                            fit: BoxFit.cover,
                          )
                        else
                          Image.asset(
                              'assets/images/galaxy-z-fold-5-xanh-1.png'),
                        Text(
                          product.modelName,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        if (product.price.special != 0)
                          Column(
                            children: [
                              Text(
                                formatCurrency.format(product.price.base),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                formatCurrency.format(product.price.special),
                                style: const TextStyle(
                                  color: primaryColors,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        else
                          Text(
                            formatCurrency.format(product.price.base),
                            style: const TextStyle(
                              color: primaryColors,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 470,
                  width: 400,
                  child: Image.asset(
                    'assets/images/search.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
