// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:single_project/api/api_order.dart';
import 'package:single_project/models/order_model.dart';

import 'package:single_project/util/constants.dart';
import 'package:single_project/widgets/button/button_send_requrest.dart';

class OrderDetail extends StatefulWidget {
  OrderModel orderDetail;
  OrderDetail({super.key, required this.orderDetail});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  String reaSonCancelled = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Đơn hàng của bạn",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: const BackButton(),
        backgroundColor: Colors.white,
        foregroundColor: primaryColors,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              styleOderStatus(),
              const Divider(thickness: 0.5),
              _buildShippingAddressOrder(),
              const Divider(thickness: 0.5),
              _buildProductOrder(),
              const Divider(thickness: 0.5),
              __buildPaymentMethodAndSingleCode(),
              const Divider(thickness: 0.5),
              _buildOrdersInvoice(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildButtonNavigationBar(),
    );
  }

  Widget styleOderStatus() {
    if (widget.orderDetail.orderStatus == 'completed') {
      return Container(
        height: 100,
        width: MediaQuery.sizeOf(context).width,
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 0, 197, 154)),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Đơn hàng đã hoàn Thành',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Text(
                'Cảm ơn bạn đã mua hàng tại Techcell',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      );
    } else if (widget.orderDetail.orderStatus == 'pending') {
      return Container(
        height: 100,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(color: Colors.yellow[800]),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đơn hàng đang chờ xử lý',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text('Vui lòng chờ đợi',
                      style: TextStyle(color: Colors.white)),
                  Text('Cảm ơn bạn đã mua hàng tại Techcell',
                      style: TextStyle(color: Colors.white))
                ],
              ),
            ],
          ),
        ),
      );
    } else
      return Container(
        height: 100,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(color: Colors.yellow[400]),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Đơn hàng đang chờ xử lý',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Vui lòng chờ đợi',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Cảm ơn bạn đã mua hàng tại Techcell',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      );
  }

  Widget _buildShippingAddressOrder() {
    return Padding(
      padding: const EdgeInsets.all(10),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.orderDetail.customer.address.customerName,
                    ),
                    const SizedBox(
                      height: 18,
                      child: VerticalDivider(
                        color: Colors.black54,
                        thickness: 1,
                      ),
                    ),
                    Text(
                      widget.orderDetail.customer.address.phoneNumbers,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  widget.orderDetail.customer.address.detail,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      '${widget.orderDetail.customer.address.wardLevel.wardName}, ',
                    ),
                    Text(
                      '${widget.orderDetail.customer.address.districtLevel.districtName}, ',
                    ),
                    Text(
                      '${widget.orderDetail.customer.address.provinceLevel.provinceName}',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductOrder() {
    return Column(children: [
      const Padding(
        padding: EdgeInsets.only(top: 10, left: 10),
        child: Row(
          children: [
            Image(
              image: AssetImage(
                'assets/logos/favicon.ico',
              ),
              width: 20,
            ),
            SizedBox(width: 5),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                'TechCell',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
      const Divider(thickness: 0.5),
      ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.orderDetail.products.length,
          itemBuilder: (context, indexOrderDetail) {
            final orderProduct = widget.orderDetail.products[indexOrderDetail];
            return FutureBuilder<OrderModel>(
                future:
                    ApiOrder().getOrderDetail(context, widget.orderDetail.id),
                builder: (context, snapshot) {
                  if ((snapshot.hasError) || (!snapshot.hasData)) {
                    return const Padding(
                      padding: EdgeInsets.all(15),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        if (widget.orderDetail.products[indexOrderDetail].image
                            .url.isNotEmpty)
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: Image(
                                image: NetworkImage(widget.orderDetail
                                    .products[indexOrderDetail].image.url)),
                          )
                        else
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: Image.asset(
                                'assets/images/galaxy-z-fold-5-xanh-1.png'),
                          ),
                        const SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 250,
                              child: Text(
                                widget.orderDetail.products[indexOrderDetail]
                                    .productName,
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
                                const Text('Phân loại:'),
                                SizedBox(
                                  height: 15, // Adjust the height as needed
                                  width: 150,
                                  child: Text(
                                    widget.orderDetail
                                        .products[indexOrderDetail].productType,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  formatCurrency.format(widget
                                      .orderDetail
                                      .products[indexOrderDetail]
                                      .unitPrice
                                      .special),
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
                                  formatCurrency.format(widget
                                      .orderDetail
                                      .products[indexOrderDetail]
                                      .unitPrice
                                      .base),
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
                              'Số lượng: ${orderProduct.quantity}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          }),
    ]);
  }

  Widget __buildPaymentMethodAndSingleCode() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.payments_outlined,
                  color: primaryColors,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Phương thúc thanh toán',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    if (widget.orderDetail.payment.method == 'COD')
                      const Text(
                        'Thanh toán khi nhận hàng',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    else
                      Text(widget.orderDetail.payment.method)
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            child: Row(
              children: [
                const Icon(
                  Icons.code_outlined,
                  color: primaryColors,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Mã đơn hàng',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.orderDetail.shipping.orderShipCode,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          if (widget.orderDetail.orderStatus == 'completed')
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
              child: Row(
                children: [
                  const Text('Ngày nhận đơn'),
                  const Spacer(),
                  Text(
                    formatTimestamp(widget.orderDetail.updatedAt!),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }

  Widget _buildOrdersInvoice() {
    int totalPrice = widget.orderDetail.totalPrice;
    int shippingFee = widget.orderDetail.shipping.fee;

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Tạm tính',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                formatCurrency.format(totalPrice),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              const Text(
                'Phí vận chuyển',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                formatCurrency.format(shippingFee),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          const Row(
            children: [
              Text(
                'Giảm giá',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                '0',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          const Row(
            children: [
              Text(
                'Voucher từ shop',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                '0',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                const Text(
                  'Thành tiền',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  formatCurrency.format(totalPrice + shippingFee),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: primaryColors,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildButtonNavigationBar() {
    if (widget.orderDetail.orderStatus == 'completed') {
      return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ButtonSendrequest(text: 'Mua lại', submit: () {}));
    } else if (widget.orderDetail.orderStatus == 'pending') {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ButtonSendrequest(
            text: 'Hủy đơn hàng',
            submit: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: ((context) =>
              //         ReaSonCancelledOrder(orderId: widget.orderDetail.id)),
              //   ),
              // );
            }),
      );
    } else
      return null;
  }
}
