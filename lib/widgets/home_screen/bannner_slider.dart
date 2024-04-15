import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _current = 0;
  final List<String> _imgList = [
    'assets/images/carousel_img/img1.png',
    'assets/images/carousel_img/img2.jpg',
    'assets/images/carousel_img/img3.png',
    'assets/images/carousel_img/img4.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _current;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSlider(),
        _buildDotTransfer(),
      ],
    );
  }

  Widget _buildSlider() {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 1.873,
          viewportFraction: 1.0,
          autoPlay: true,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
        ),
        items: _imgList
            .map(
              (item) => Container(
                margin: const EdgeInsets.only(top: 92),
                child: Image.asset(
                  item,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildDotTransfer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _imgList.map(
          (url) {
            int index = _imgList.indexOf(url);
            return Container(
              width: 8,
              height: _current == index ? 8 : 1,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                shape: _current == index ? BoxShape.circle : BoxShape.rectangle,
                color: Colors.grey,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
