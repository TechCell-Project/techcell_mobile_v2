// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:single_project/api/api_order.dart';
import 'package:single_project/models/order_model.dart';
import 'package:single_project/page/tabs/order/order_detail.dart';

import 'package:single_project/util/constants.dart';

class OrderUserTap extends StatefulWidget {
  const OrderUserTap({super.key});

  @override
  State<OrderUserTap> createState() => _OrderUserTapState();
}

class _OrderUserTapState extends State<OrderUserTap>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ScrollController _scrollController = ScrollController();

  ListOrderModel listProductOrder =
      ListOrderModel(orders: [], hasNextPage: false);

  Future<void> fetchDataForOrders() async {
    ApiOrder().getOrder(context).then((value) {
      setState(() {
        listProductOrder = value;
      });
    });
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 5, initialIndex: 0, vsync: this);
    _tabController.addListener(_handleTabSelection);
    fetchDataForOrders();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Đơn hàng",
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
          bottom: TabBar(
            controller: _tabController,
            labelColor: primaryColors,
            unselectedLabelColor: Colors.black,
            labelStyle: const TextStyle(fontSize: 16),
            isScrollable: true,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 3, color: primaryColors),
            ),
            labelPadding: const EdgeInsets.symmetric(horizontal: 20),
            tabs: const [
              Tab(text: 'Chờ xác nhận'),
              Tab(text: 'Chờ lấy hàng'),
              Tab(text: 'Chờ giao hàng'),
              Tab(text: 'Đã giao'),
              Tab(text: 'Đã hủy'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            buildOrderWidget(listProductOrder),
            buildOrderWidget(listProductOrder),
            buildOrderWidget(listProductOrder),
            buildOrderWidget(listProductOrder),
            buildOrderWidget(listProductOrder),
          ],
        ),
      ),
    );
  }

  Widget buildOrderWidget(ListOrderModel? orders) {
    if (orders == null) {
      return const Center(child: Text('No orders found'));
    } else {
      return SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 240, 239, 239),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orders.orders.length,
                itemBuilder: (context, index) {
                  final order = orders.orders[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetail(
                            orderDetail: order,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 8),
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                      'assets/logos/favicon.ico',
                                    ),
                                    width: 20,
                                  ),
                                  SizedBox(width: 2),
                                  Text('Techcell'),
                                ],
                              ),
                              const Spacer(),
                              getOrderStatus(order.orderStatus,
                                  _getStatusText(order.orderStatus)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                if (order.products[0].image.url.isNotEmpty)
                                  SizedBox(
                                    height: 120,
                                    width: 120,
                                    child: Image(
                                        image: NetworkImage(
                                            order.products[0].image.url)),
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
                                        order.products[0].productName,
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
                                          height:
                                              15, // Adjust the height as needed
                                          width: 150,
                                          child: Text(
                                            order.products[0].productType,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          formatCurrency.format(order
                                              .products[0].unitPrice.special),
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
                                          formatCurrency.format(
                                              order.products[0].unitPrice.base),
                                          style: TextStyle(
                                            color: Colors.grey.withOpacity(1),
                                            fontWeight: FontWeight.w400,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(thickness: 1),
                          Row(
                            children: [
                              Text(
                                "${order.products.length.toString()} sản phẩm",
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const Spacer(),
                              const SizedBox(width: 5),
                              const Text('Thành tiền: '),
                              Text(
                                formatCurrency
                                    .format(orders.orders[index].totalPrice),
                                style: const TextStyle(
                                  color: primaryColors,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget styleOrderStatus(Color color, String text) {
    return Row(
      children: [
        Icon(Icons.local_shipping_outlined, color: color),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(fontSize: 15, color: color),
        ),
      ],
    );
  }

  Widget getOrderStatus(String status, String text) {
    Color statusColor;
    switch (status) {
      case 'pending':
        statusColor = Colors.yellow[800] ?? Colors.transparent;
        break;
      case 'completed':
        statusColor = Colors.green;
        break;
      case 'cancelled':
        statusColor = Colors.red;
      default:
        statusColor = Colors.transparent;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          styleOrderStatus(statusColor, _getStatusText(status)),
        ],
      ),
    );
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'Đang chờ xác nhận';
      case 'completed':
        return 'Đã hoàn thành';
      case 'cancelled':
        return 'Đơn hàng đã hủy';
      default:
        return 'Đang chờ xử lý';
    }
  }
}
