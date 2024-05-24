// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:single_project/api/api_order.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/widgets/button/button_send_requrest.dart';

class ReaSonCancelledOrder extends StatefulWidget {
  String orderId;
  ReaSonCancelledOrder({super.key, required this.orderId});

  @override
  State<ReaSonCancelledOrder> createState() => _ReaSonCancelledOrderState();
}

class _ReaSonCancelledOrderState extends State<ReaSonCancelledOrder> {
  String? currentOption; // Declare currentOption at the class level
  final TextEditingController reaSonCancelledController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> reaSonCancelled = [
    'Đặt nhầm sản phẩm',
    'Phí vận chuyển cao',
    'Đơn trùng',
    'Không muốn mua nữa',
    'Lý do khác'
  ];

  String sendReaSonStringtToSever = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lý do hủy đơn hàng',
          style: TextStyle(color: Colors.black),
        ),
        foregroundColor: primaryColors,
        elevation: 0,
      ),
      body: Column(
        children: [
          RadioListTile(
            title: Text(reaSonCancelled[0]),
            groupValue: currentOption,
            value: reaSonCancelled[0],
            onChanged: (newValue) {
              setState(() {
                currentOption = newValue.toString();
              });
            },
            activeColor: primaryColors,
          ),
          RadioListTile(
            title: Text(reaSonCancelled[1]),
            value: reaSonCancelled[1],
            groupValue: currentOption,
            onChanged: (newValue) {
              setState(() {
                currentOption = newValue.toString();
              });
            },
            activeColor: primaryColors,
          ),
          RadioListTile(
            groupValue: currentOption,
            title: Text(reaSonCancelled[2]),
            value: reaSonCancelled[2],
            onChanged: (newValue) {
              setState(() {
                currentOption = newValue.toString();
              });
            },
            activeColor: primaryColors,
          ),
          RadioListTile(
            groupValue: currentOption,
            title: Text(reaSonCancelled[3]),
            value: reaSonCancelled[3],
            onChanged: (newValue) {
              setState(() {
                currentOption = newValue.toString();
              });
            },
            activeColor: primaryColors,
          ),
          RadioListTile(
            groupValue: currentOption,
            title: Text(reaSonCancelled[4]),
            value: reaSonCancelled[4],
            onChanged: (newValue) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Lý do hủy đơn'),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                              'Cho chúng tôi biết lý do bạn muốn hủy đơn để có thể cải thiện chất lượng dịch vụ'),
                          const SizedBox(height: 10),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 5),
                              child: TextFormField(
                                controller: reaSonCancelledController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập lý do hủy đơn';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    currentOption = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColors),
                          child: const Text(
                            'Hoàn thành',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
              setState(() {
                currentOption = newValue.toString();
              });
            },
            activeColor: primaryColors,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              if (currentOption == null)
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Lỗi'),
                          content:
                              const Text('Vui lòng chọn lý do hủy đơn hàng.'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(55),
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Hủy đơn hàng',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                )
              else
                ButtonSendrequest(
                    text: 'Hủy đơn hàng',
                    submit: () {
                      ApiOrder().cancellOrder(
                          context, widget.orderId, currentOption!);
                    })
            ]),
          )
        ],
      ),
    );
  }
}
