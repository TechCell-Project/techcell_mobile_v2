// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:single_project/models/product_detail_model.dart';
import 'package:single_project/util/constants.dart';

class AnimateToSlider extends StatefulWidget {
  List<ProductImage> productDetail;
  AnimateToSlider({super.key, required this.productDetail});

  @override
  State<AnimateToSlider> createState() => _AnimateToSliderState();
}

class _AnimateToSliderState extends State<AnimateToSlider> {
  int current = 0;
  final CarouselController _carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.productDetail.length,
        itemBuilder: (context, index) {
          final generalImages = widget.productDetail[index];
          return Container(
            width: 110,
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              border: Border.all(
                  color: current == index ? primaryColors : Colors.black26),
              borderRadius: BorderRadius.circular(5),
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  current = index;
                });
                _carouselController.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
              child: Image(
                image: NetworkImage(generalImages.url),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
