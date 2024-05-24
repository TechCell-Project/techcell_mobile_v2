// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:single_project/models/product_model.dart';
import 'package:single_project/page/tabs/product/product_detail.dart';
import 'package:single_project/util/constants.dart';

class InFrameProduct extends StatefulWidget {
  ListProductModel products;
  InFrameProduct({
    super.key,
    required this.products,
  });

  @override
  State<InFrameProduct> createState() => _InFrameProductState();
}

class _InFrameProductState extends State<InFrameProduct> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        mainAxisExtent: 320,
      ),
      itemCount: widget.products.data.length,
      itemBuilder: (context, index) {
        if (widget.products.data.isNotEmpty) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetail(
                    id: widget.products.data[index].id,
                    basePrice: widget.products.data[index].price.base,
                    specialPrice: widget.products.data[index].price.special,
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
                  if (widget.products.data[index].imageModel.isNotEmpty)
                    Image(
                      image: NetworkImage(
                          widget.products.data[index].imageModel[0].url),
                      height: 160,
                      fit: BoxFit.cover,
                    )
                  else
                    Image.asset('assets/images/galaxy-z-fold-5-xanh-1.png'),
                  Text(
                    widget.products.data[index].modelName,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (widget.products.data[index].price.special != 0)
                    Column(
                      children: [
                        Text(
                          formatCurrency
                              .format(widget.products.data[index].price.base),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          formatCurrency.format(
                              widget.products.data[index].price.special),
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
                      formatCurrency
                          .format(widget.products.data[index].price.base),
                      style: const TextStyle(
                        color: primaryColors,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  const SizedBox(height: 5),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 244, 244, 244),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Giảm giá đến : 15 % và nhiều khuyến mại hấp dẫn khác',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          // Handle case when data is empty
          return const SizedBox();
        }
      },
    );
  }
}
