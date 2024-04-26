import 'package:flutter/material.dart';
import 'package:single_project/api/api_product.dart';
import 'package:single_project/models/product_model.dart';
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
          future: ProductApi().getProducts(context),
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

            return Container();
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
