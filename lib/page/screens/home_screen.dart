import 'package:flutter/material.dart';
import 'package:single_project/widgets/home_screen/bannner_slider.dart';
import 'package:single_project/widgets/home_screen/header_home.dart';
import 'package:single_project/widgets/home_screen/hot_sale_product.dart';
import 'package:single_project/widgets/home_screen/product_cart.dart';
import 'package:single_project/widgets/home_screen/text_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BannerSlider(),
                TextTile(text: 'Khuyến mãi hot'),
                const SizedBox(height: 10),
                const HotSaleProduct(),
                Image.asset('assets/images/banner.webp'),
                TextTile(text: 'Gợi ý cho bạn'),
                // Category(),

                ProductCart(scrollController),
              ],
            ),
          ),
          HeaderHome(scrollController),
        ],
      ),
    );
  }
}
