// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:single_project/page/screens/cart_screen.dart';
import 'package:single_project/util/constants.dart';
import 'package:badges/badges.dart' as badges;

class HeaderHome extends StatefulWidget {
  final ScrollController scrollController;
  const HeaderHome(this.scrollController, {super.key});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<HeaderHome> {
  late Color _backgroundColor;
  late Color _colorIcon;
  double _opacity = 0.0;
  double _offset = 0.0;
  final _opacityMax = 0.01;

  _onScroll() {
    final scrollOffset = widget.scrollController.offset;
    if (scrollOffset >= _offset && scrollOffset > 5) {
      _opacity = double.parse((_opacity + _opacityMax).toStringAsFixed(2));
      if (_opacity >= 1.0) {
        _opacity = 1.0;
      }
      _offset = scrollOffset;
    } else if (scrollOffset < 100) {
      _opacity = double.parse((_opacity - _opacityMax).toStringAsFixed(2));
      if (_opacity <= 0.0) {
        _opacity = 0.0;
      }
    }

    setState(() {
      if (scrollOffset <= 0) {
        _colorIcon = Colors.black;
        _offset = 0.0;
        _opacity = 0.0;
      } else {
        _colorIcon = primaryColors;
      }

      _backgroundColor = primaryColors.withOpacity(0.1);
    });
  }

  @override
  void initState() {
    super.initState();
    _backgroundColor = primaryColors.withOpacity(0.1);
    _colorIcon = Colors.black;
    widget.scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return widget.scrollController.offset <= -50
        ? const SizedBox()
        : Container(
            color: _backgroundColor,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildSearch(),
                    _buildCartButton(),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buildSearch() {
    return InkWell(
      onTap: () {
        // showSearch(context: context, delegate: SearchProduct());
      },
      child: Container(
        height: 40,
        width: 320,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Icon(Icons.search, color: Colors.black),
            ),
            Text(
              'Tìm kiếm...',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartButton() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CartScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: badges.Badge(
          badgeContent: const Center(
            child: Text(
              '0',
              style: TextStyle(color: Colors.white),
            ),
          ),
          child: Icon(Icons.shopping_cart, color: _colorIcon, size: 40),
        ),
      ),
    );
  }
}
