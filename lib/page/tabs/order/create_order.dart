// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:single_project/api/api_order.dart';
import 'package:single_project/models/order_model.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/widgets/button/button_send_requrest.dart';

class CreateOrder extends StatefulWidget {
  OrderModel orderResponse;
  int indexAdreess;

  CreateOrder({
    super.key,
    required this.orderResponse,
    required this.indexAdreess,
  });

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  int valueMethodPayment = 1;
  String? paymentMethod = 'COD';

  int getCartTotal() {
    int total =
        widget.orderResponse.totalPrice + widget.orderResponse.shipping.fee;
    formatCurrency.format(total);
    return total;
  }

  int getQuantity() {
    int total = 0;
    for (int i = 0; i < widget.orderResponse.products.length; i++) {
      total += widget.orderResponse.products.length;
    }
    return total;
  }

  // void createOder() {
  //   ApiOrder().createOrder(
  //     context: context,
  //     paymentMethod: paymentMethod!,
  //     addressSelected: widget.orderResponse.addressSelected,
  //     product: widget.orderResponse.product,
  //   );

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => MainScreen(),
  //     ),
  //   );
  //   showSnackBarSuccess(context, 'Đặt hàng thành công');
  // }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thanh toán",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColors,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShippingAddress(),
                const Divider(thickness: 1, color: Colors.black54),
                _buildPaymentProduct(),
                const Divider(thickness: 1, color: Colors.black54),
                _buildPaymentMethods(),
                const Divider(thickness: 1, color: Colors.black54),
                _buildBill(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildShippingAddress() {
    final infor = widget.orderResponse.customer.address;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(
                Icons.location_on,
                color: primaryColors,
              ),
              SizedBox(width: 5),
              Text(
                "Địa chỉ nhận hàng",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          infor.customerName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                          child: VerticalDivider(
                            color: Colors.black54,
                            thickness: 1,
                          ),
                        ),
                        Text(
                          infor.phoneNumbers,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          infor.detail,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              '${infor.wardLevel.wardName}, ',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${infor.districtLevel.districtName},  ',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${infor.provinceLevel.provinceName}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.orderResponse.products.length,
            itemBuilder: (context, index) {
              final productOrder = widget.orderResponse.products[index];
              return Container(
                width: 400,
                padding: const EdgeInsets.symmetric(vertical: 10),
                margin: const EdgeInsets.symmetric(vertical: 5),
                // decoration: BoxDecoration(
                //   color: Color.fromARGB(255, 240, 239, 239),
                //   borderRadius: BorderRadius.circular(10),
                // ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          if (productOrder.image.url != '')
                            SizedBox(
                              height: 120,
                              width: 120,
                              child: Image(
                                image: NetworkImage(
                                  productOrder.image.url,
                                ),
                              ),
                            )
                          else
                            SizedBox(
                                height: 120,
                                width: 120,
                                child: Image.asset(
                                    'assets/images/galaxy-z-fold-5-xanh-1.png')),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 220,
                                child: Text(
                                  productOrder.productName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text(
                                    'Phân loại:',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                    width: 150,
                                    child: Text(
                                      widget.orderResponse.products[index]
                                          .productType,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    formatCurrency
                                        .format(productOrder.unitPrice.special),
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '-',
                                    style: TextStyle(
                                      color: Colors.grey.withOpacity(1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    formatCurrency
                                        .format(productOrder.unitPrice.base),
                                    style: TextStyle(
                                      color: Colors.grey.withOpacity(1),
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Số lượng: ${productOrder.quantity}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Container(
      padding: const EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(10),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Color(0xFF475269).withOpacity(0.3),
      //       spreadRadius: 1,
      //       blurRadius: 5,
      //     ),
      //   ],
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Phương thức thanh toán',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                'Thanh toán khi nhận hàng',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Radio(
                activeColor: primaryColors,
                value: 1,
                groupValue: valueMethodPayment,
                onChanged: (check) {
                  setState(() {
                    valueMethodPayment = check!;
                    paymentMethod = 'COD';
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBill() {
    return Container(
      padding: const EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(10),
      //   boxShadow: [
      //     BoxShadow(
      //       color: const Color(0xFF475269).withOpacity(0.3),
      //       spreadRadius: 1,
      //       blurRadius: 5,
      //     ),
      //   ],
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Chi tiết hóa đơn",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Tổng số lượng",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                getQuantity().toString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Tổng tiền hàng",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                formatCurrency.format(widget.orderResponse.totalPrice),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Phí vận chuyển",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                formatCurrency.format(widget.orderResponse.shipping.fee),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Tổng thanh toán",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                formatCurrency.format(getCartTotal()),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColors,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ButtonSendrequest(
        text: 'Đặt hàng',
        submit: createOrder,
      ),
    );
  }

  void createOrder() {
    ApiOrder().createOrder(
      context,
      widget.orderResponse.products,
      widget.indexAdreess,
    );
  }
}
