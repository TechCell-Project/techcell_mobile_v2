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
                  builder: (context) =>
                      ProductDetail(id: widget.product.data[index].id),
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
                  if (product.imageModel.url != '')
                    Image(
                      image: NetworkImage(
                          widget.product.data[index].imageModel.url),
                      height: 200,
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
                    Row(
                      children: [
                        Text(
                          formatCurrency.format(product.price.special),
                          style: const TextStyle(
                            color: primaryColors,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          formatCurrency.format(product.price.base),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
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
