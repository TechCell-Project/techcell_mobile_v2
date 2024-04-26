// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:single_project/api/api_login.dart';
import 'package:single_project/models/product_detail_model.dart';
import 'package:single_project/page/tabs/authentication_tab/login_tab.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/widgets/product_detail/add_to_store.dart';
import 'package:single_project/widgets/product_detail/buy_now.dart';

class BuildBottom extends StatelessWidget {
  ProductDetailModel productDetail;
  BuildBottom({super.key, required this.productDetail});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => FutureBuilder(
                    future: ApiLogin().checkSession(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Scaffold(
                          body: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        if (snapshot.hasError) {
                          return Scaffold(
                            body: Center(
                              child: Text('Error: ${snapshot.error}'),
                            ),
                          );
                        } else {
                          final bool isLoggedIn = snapshot.data ?? false;
                          if (isLoggedIn) {
                            return AddToStore(
                              productId: productDetail.productId,
                              variations: productDetail.variations,
                            );
                          } else {
                            return const LoginTap();
                          }
                        }
                      }
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(
                  width: 0.5,
                  color: primaryColors,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: primaryColors,
                    ),
                    Text(
                      "Thêm vào giỏ hàng",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: primaryColors,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 5),
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => BuyNow(
                      variations: productDetail.variations,
                      id: productDetail.productId,
                      handleSelectVariation: () {},
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColors,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.08,
                      vertical: 10),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Mua ngay",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
