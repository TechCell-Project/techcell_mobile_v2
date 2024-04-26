import 'package:flutter/material.dart';
import 'package:single_project/api/api_cart.dart';
import 'package:single_project/api/api_product.dart';
import 'package:single_project/models/cart_model.dart';
import 'package:single_project/models/product_detail_model.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/widgets/button/button_send_requrest.dart';
import 'package:single_project/widgets/cart/open_dialog.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  List<Product> productSend = [];
  int valueChecked = 0;
  int priceProduct = 0;
  double totalAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CartItem>(
        future: ApiCart().getCart(context),
        builder: (context, snapshot1) {
          if (snapshot1.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot1.error != null) {
            return Container();
          } else if (snapshot1.hasError || snapshot1.data == null) {
            return Container();
          }
          productSend = snapshot1.data!.products;

          void inCrementQuantity(int index) {
            setState(() {
              valueChecked = 1;
            });
            ApiCart().updateCart(
              context,
              snapshot1.data!.products[index].productId,
              snapshot1.data!.products[index].skuId,
              valueChecked,
            );
          }

          void deleteCart(int index) {
            ApiCart().updateCart(
              context,
              snapshot1.data!.products[index].productId,
              snapshot1.data!.products[index].skuId,
              0,
            );
          }

          void deCrementQuantity(int index) {
            setState(() {
              if (snapshot1.data!.products[index].quantity >= 1) {
                valueChecked = -1;
              } else {
                valueChecked = 1;
              }
            });
            ApiCart().updateCart(
              context,
              snapshot1.data!.products[index].productId,
              snapshot1.data!.products[index].skuId,
              valueChecked,
            );
            print(snapshot1.data!.products[index].quantity);
          }

          return Scaffold(
            appBar: AppBar(
              foregroundColor: primaryColors,
              elevation: 0,
              title: const Text('Giỏ hàng'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot1.data!.products.length,
                      itemBuilder: (context, indexCart) {
                        final product = snapshot1.data!.products[indexCart];
                        return FutureBuilder<ProductDetailModel?>(
                            future: ProductApi()
                                .getProductById(context, product.productId),
                            builder: (context, snapshot2) {
                              if (snapshot2.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if ((snapshot2.hasError) ||
                                  (!snapshot2.hasData)) {
                                return const Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              double total = 0;
                              for (var i = 0;
                                  i < snapshot1.data!.products.length;
                                  i++) {
                                final itemCart = snapshot1.data!.products[i];

                                total += itemCart.quantity *
                                    snapshot2.data!.variations[indexCart].price
                                        .special;
                              }
                              totalAmount = total;

                              final priceProduct = product.quantity *
                                  snapshot2.data!.variations[indexCart].price
                                      .special;
                              final variationIndex = snapshot2.data!.variations
                                  .indexWhere((variation) =>
                                      variation.skuId == product.skuId);

                              return Dismissible(
                                  key: Key(product.productId),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    deleteCart(indexCart);
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    child: const Center(
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                      width: 400,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 240, 239, 239),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         ProductDetail(
                                                  //             productDetail:
                                                  //                 itemProduct),
                                                  //   ),
                                                  // );
                                                },
                                                child: SizedBox(
                                                  height: 120,
                                                  width: 120,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: snapshot2
                                                        .data!.images.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final image = snapshot2
                                                          .data!.images[index];
                                                      if (image.isThumbnail ==
                                                          true) {
                                                        return Image(
                                                          image: NetworkImage(
                                                              image.url),
                                                        );
                                                      } else if (index == 0) {
                                                        return Image.asset(
                                                            'assets/images/galaxy-z-fold-5-xanh-1.png');
                                                      }
                                                      return Container();
                                                    },
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 220,
                                                    child: Text(
                                                      snapshot2
                                                          .data!.productName,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      const Text('Phân loại:'),
                                                      SizedBox(
                                                        height:
                                                            15, // Adjust the height as needed
                                                        width: 150,
                                                        child: Row(
                                                          children: snapshot2
                                                              .data!
                                                              .variations[
                                                                  variationIndex]
                                                              .attributes
                                                              .map((attribute) =>
                                                                  Text(
                                                                      '${attribute.value} ${attribute.unit}'))
                                                              .toList(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        formatCurrency.format(
                                                            priceProduct),
                                                        style: const TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        '-',
                                                        style: TextStyle(
                                                          color: Colors.grey
                                                              .withOpacity(1),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        formatCurrency.format(
                                                            snapshot2
                                                                .data!
                                                                .variations[
                                                                    variationIndex]
                                                                .price
                                                                .base),
                                                        style: TextStyle(
                                                          color: Colors.grey
                                                              .withOpacity(1),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          if (snapshot1
                                                                  .data!
                                                                  .products[
                                                                      indexCart]
                                                                  .quantity >=
                                                              1) {
                                                            deCrementQuantity(
                                                                indexCart);
                                                          } else {
                                                            null;
                                                          }
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: Colors
                                                                  .redAccent,
                                                              width: 0.5,
                                                            ),
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0),
                                                          ),
                                                          child: const Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        2),
                                                            child: Icon(
                                                              Icons.remove,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors
                                                                .redAccent,
                                                            width: 0.5,
                                                          ),
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical:
                                                                      2.5),
                                                          child: Text(
                                                            snapshot1
                                                                .data!
                                                                .products[
                                                                    indexCart]
                                                                .quantity
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          inCrementQuantity(
                                                              indexCart);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: Colors
                                                                  .redAccent,
                                                              width: 0.5,
                                                            ),
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0),
                                                          ),
                                                          child: const Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        2),
                                                            child: Icon(
                                                              Icons.add,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ])));
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: _buildTotalAmountAndPayment(),
          );
        },
      ),
    );
  }

  Widget _buildTotalAmountAndPayment() {
    return SizedBox(
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.all(15),
              child: ButtonSendrequest(
                text: 'Mua hàng',
                submit: () {
                  print('all');
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => OpenDialogAddreess(
                      productCart: productSend,
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}
