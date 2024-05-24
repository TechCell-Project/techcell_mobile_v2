// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:single_project/models/product_model.dart';
import 'package:single_project/page/tabs/product/product_detail.dart';
import 'package:single_project/util/constants.dart';

class InFrame extends StatefulWidget {
  ListProductModel product;
  InFrame({
    super.key,
    required this.product,
  });

  @override
  State<InFrame> createState() => _InFrameState();
}

class _InFrameState extends State<InFrame> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount:
          widget.product.data.length >= 5 ? 5 : widget.product.data.length,
      itemBuilder: (context, index) {
        final product = widget.product.data[index];
        if (widget.product.data.isNotEmpty) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetail(
                    id: widget.product.data[index].id,
                    specialPrice: widget.product.data[index].price.special,
                    basePrice: widget.product.data[index].price.base,
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
                  if (widget.product.data[index].imageModel.isNotEmpty)
                    Image(
                      image: NetworkImage(
                          widget.product.data[index].imageModel[0].url),
                      height: 165,
                      fit: BoxFit.cover,
                    )
                  else
                    Image.asset('assets/images/galaxy-z-fold-5-xanh-1.png'),
                  Text(
                    product.modelName,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (product.price.special != 0)
                    Column(
                      children: [
                        Text(
                          formatCurrency.format(product.price.base),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          formatCurrency.format(product.price.special),
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
                      formatCurrency.format(product.price.base),
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
