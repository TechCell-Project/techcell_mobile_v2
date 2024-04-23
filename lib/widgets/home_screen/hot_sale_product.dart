import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:single_project/api/api_product.dart';
import 'package:single_project/models/product_model.dart';
import 'package:single_project/widgets/home_screen/in_frame.dart';

class HotSaleProduct extends StatefulWidget {
  const HotSaleProduct({super.key});

  @override
  State<HotSaleProduct> createState() => _HotSaleProductState();
}

class _HotSaleProductState extends State<HotSaleProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(230, 230, 230, 1)),
      child: FutureBuilder<ListProductModel>(
        future: ProductApi().getProducts(context),
        builder: (context, snapshoot) {
          if (snapshoot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshoot.data == null) {
            return const Center(
              child: Text('No Data!'),
            );
          }

          ListProductModel products = snapshoot.data!;
          return SizedBox(
              height: 325,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: InFrame(product: products),
              ));
        },
      ),
    );
  }
}
