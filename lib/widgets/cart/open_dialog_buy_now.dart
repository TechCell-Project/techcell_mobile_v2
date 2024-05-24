// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:single_project/Providers/user_provider.dart';
import 'package:single_project/api/api_order.dart';
import 'package:single_project/models/address_model.dart';
import 'package:single_project/page/tabs/profile_user/address_user/add_address_user.dart';
import 'package:single_project/page/tabs/profile_user/address_user/change_address_user.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/widgets/button/button_send_requrest.dart';

class OpenDialogAddreessBuyNow extends StatefulWidget {
  String skuId;
  OpenDialogAddreessBuyNow({
    super.key,
    required this.skuId,
  });

  @override
  State<OpenDialogAddreessBuyNow> createState() =>
      _OpenDialogAddreessBuyNowState();
}

class _OpenDialogAddreessBuyNowState extends State<OpenDialogAddreessBuyNow> {
  int valueChecked = 0;

  void getReviewOrder() {
    ApiOrder().preViewOrderBuyNow(
      context,
      valueChecked,
      widget.skuId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Địa chỉ của tôi',
                  style: TextStyle(
                    color: primaryColors,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          _buildMyAddress(),
          _buildNewAddress(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ButtonSendrequest(
              text: "Xác nhận",
              submit: getReviewOrder,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyAddress() {
    List<AddressModel> addressUser =
        Provider.of<UserProvider>(context, listen: false).user.address;

    return Expanded(
      child: ListView.builder(
        itemCount: addressUser.length,
        itemBuilder: (context, index) {
          final userAndAddress = addressUser[index];
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Radio(
                      activeColor: primaryColors,
                      value: index,
                      groupValue: valueChecked,
                      onChanged: (val) {
                        setState(
                          () {
                            valueChecked = val!;
                          },
                        );
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              userAndAddress.customerName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              '|',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              userAndAddress.phoneNumbers,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          userAndAddress.detail,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              '${userAndAddress.wardLevel.wardName}, ',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${userAndAddress.districtLevel.districtName}, ',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${userAndAddress.provinceLevel.provinceName}',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ChangeAdressUser(
                                    addressUser: userAndAddress,
                                    index: index,
                                  ))),
                        );
                      },
                      child: const Text(
                        'Sửa',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: primaryColors,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNewAddress() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddAdressUser()));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.add_circled,
              size: 30,
              color: primaryColors,
            ),
            SizedBox(width: 10),
            Text(
              'Thêm Địa Chỉ Mới',
              style: TextStyle(
                color: primaryColors,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
