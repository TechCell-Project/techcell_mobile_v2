import 'package:flutter/material.dart';
import 'package:single_project/widgets/home_screen/bannner_slider.dart';
import 'package:single_project/widgets/home_screen/header_home.dart';

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
            child: const Column(
              children: [
                BannerSlider(),
                // Category(),
                // TitleWithMoreBtn(text: 'Sản phẩm nổi bật:'),
                // ProductHotSale(),
                // TitleWithMoreBtn(text: 'Gợi ý cho bạn:'),
                // ProductCart(scrollController),
              ],
            ),
          ),
          HeaderHome(scrollController),
        ],
      ),
    );
  }
}
