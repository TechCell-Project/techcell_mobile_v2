// ignore_for_file: unused_element, must_be_immutable

import 'package:flutter/material.dart';
import 'package:single_project/models/product_detail_model.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/widgets/cart/open_dialog_buy_now.dart';

class BuyNow extends StatefulWidget {
  List<ProductVariation> variations;
  String id;
  Function handleSelectVariation;
  String text;
  BuyNow({
    super.key,
    required this.variations,
    required this.id,
    required this.handleSelectVariation,
    required this.text,
  });

  @override
  State<BuyNow> createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  Map<String, ProductAttribute> selectedAttributes = {};
  String? selectedSku;
  ProductVariation? selectedVariation;
  int basePrice = 0;
  int specialPrice = 0;
  String skuId = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 10,
              right: 10,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3.25,
                    mainAxisSpacing: 5,
                    mainAxisExtent: 45,
                  ),
                  itemCount: widget.variations.length,
                  itemBuilder: (context, index) {
                    final variation = widget.variations[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedVariation = variation;
                          basePrice = variation.price.base;
                          specialPrice = variation.price.special;
                          skuId = variation.skuId;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedVariation == variation
                                ? primaryColors // Màu border khi được chọn
                                : Colors.grey, // Màu border mặc định
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          variation.attributes
                              .map((attr) => ' ${attr.value}${attr.unit}')
                              .join('-'),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      const Text(
                        'Giá sản phẩm: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      if (specialPrice != 0)
                        Text(
                          formatCurrency.format(specialPrice),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: primaryColors,
                          ),
                        )
                      else
                        Text(basePrice.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: primaryColors,
                            )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedVariation != null) {
                        Navigator.pop(context);
                        Future.delayed(const Duration(milliseconds: 200), () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => OpenDialogAddreessBuyNow(
                              skuId: skuId,
                            ),
                          );
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedVariation != null
                          ? primaryColors // Màu border khi được chọn
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 85, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.text,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
