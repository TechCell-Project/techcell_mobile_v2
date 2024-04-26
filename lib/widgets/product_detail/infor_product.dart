// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:single_project/models/product_detail_model.dart';
import 'package:single_project/util/constants.dart';

class InforProduct extends StatefulWidget {
  ProductDetailModel productDetail;
  int basePrice;
  int specialPrice;

  InforProduct({
    super.key,
    required this.productDetail,
    required this.basePrice,
    required this.specialPrice,
  });

  @override
  State<InforProduct> createState() => _InforProductState();
}

class _InforProductState extends State<InforProduct> {
  bool showMoreInfo = false;
  bool showMoreDescrip = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          widget.productDetail.productName,
          maxLines: 2,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w900,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.productDetail.variations.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  Row(
                    children: [
                      Text(
                        formatCurrency.format(widget.specialPrice),
                        style: const TextStyle(
                          color: primaryColors,
                          fontWeight: FontWeight.w500,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        formatCurrency.format(widget.basePrice),
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text(
                            '4.9/5',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.workspace_premium,
                            color: Colors.amber,
                          ),
                          Text(
                            'Hàng chính hãng - Bảo hành 12 Tháng',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.local_shipping,
                            color: Colors.amber,
                          ),
                          Text(
                            'Giao hàng toàn quốc',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }
            return Container();
          },
        ),
        const SizedBox(height: 15),
        Container(
          width: 400,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 400,
                color: const Color.fromARGB(255, 210, 210, 210),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    'ƯU ĐÃI THÊM',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  '- Giảm thêm tới 1% cho thành viên Smember (áp dụng tùy sản phẩm)',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  '- Giảm thêm tới 1% cho thành viên Smember (áp dụng tùy sản phẩm)',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  '- Giảm thêm tới 1% cho thành viên Smember (áp dụng tùy sản phẩm)',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Thông số kỹ thuật',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: showMoreInfo ? null : 190,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.productDetail.attributes.length,
                  itemBuilder: (context, index) {
                    final generalAttributes =
                        widget.productDetail.attributes[index];
                    return Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      border: TableBorder.all(width: 1, color: Colors.black26),
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                generalAttributes.name.capitalize(),
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                '${generalAttributes.value} ${generalAttributes.unit}',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showMoreInfo = !showMoreInfo;
                      });
                    },
                    child: Text(
                      showMoreInfo ? 'Ẩn bớt' : 'Xem cấu hình chi tiết',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              child: Text(
                'Đặc điểm chi tiết, nổi bật:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: showMoreDescrip ? null : 220,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: HtmlWidget(widget.productDetail.description),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      showMoreDescrip = !showMoreDescrip;
                    });
                  },
                  child: Text(
                    showMoreDescrip ? 'Xem thêm' : 'Ẩn bớt',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
