// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:single_project/models/product_detail_model.dart';

class SliderImgProduct extends StatefulWidget {
  List<ProductImage> productDetail;
  SliderImgProduct({super.key, required this.productDetail});

  @override
  State<SliderImgProduct> createState() => _SliderImgProductState();
}

class _SliderImgProductState extends State<SliderImgProduct> {
  int current = 0;
  final CarouselController _carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.only(top: 65),
      child: CarouselSlider.builder(
        carouselController: _carouselController,
        options: CarouselOptions(
          aspectRatio: 1.873,
          viewportFraction: 1.0,
          onPageChanged: (index, reason) {
            setState(() {
              current = index;
            });
          },
        ),
        itemCount: widget.productDetail.length,
        itemBuilder: (BuildContext context, int index, int pageViewIndex) {
          Container image;
          try {
            final generalImages = widget.productDetail[index];
            image = Container(
              child: Image(
                image: NetworkImage(generalImages.url),
                fit: BoxFit.cover,
              ),
            );
          } catch (e) {
            image = Container(
              margin: const EdgeInsets.only(top: 25),
              child: Image.asset(
                "assets/images/galaxy-z-fold-5-xanh-1.png",
                fit: BoxFit.cover,
              ),
            );
          }
          return Container(
            child: image,
          );
        },
      ),
    );
  }
}
