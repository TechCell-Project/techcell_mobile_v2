// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_project/Providers/user_provider.dart';
import 'package:single_project/api/api_address.dart';
import 'package:single_project/models/address_model.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/util/validator.dart';
import 'package:single_project/widgets/button/button_send_requrest.dart';
import 'package:single_project/widgets/text_fields/text_field_address.dart';
import 'package:single_project/widgets/user_widgets/select_button.dart';
import 'package:single_project/widgets/user_widgets/switch_defaul_address.dart';

class ChangeAdressUser extends StatefulWidget {
  AddressModel addressUser;
  int index;
  ChangeAdressUser({
    super.key,
    required this.addressUser,
    required this.index,
  });

  @override
  State<ChangeAdressUser> createState() => _ChangeAdressUserState();
}

class _ChangeAdressUserState extends State<ChangeAdressUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final TextEditingController addressNameController = TextEditingController();

  String typeAddress = '';
  List<bool> type = [false, false];

  ApiAddress address = ApiAddress();
  List<ProvinceLevel> provinceLevel = [];
  List<DistrictLevel> districtsLevel = [];
  List<WardLevel> wardLevel = [];

  //set values sau khi chọn
  ProvinceLevel? selectedProvince;
  DistrictLevel? selecttedDistricts;
  WardLevel? selectedWards;
  deleteAddressUser(int index) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    List<AddressModel> addressUser = userProvider.user.address;
    if (index >= 0 && index < addressUser.length) {
      setState(() {
        addressUser.removeAt(index);
      });
    }
    await address.changeAdreesUser(context, addressUser);
  }

  List<bool> selected() {
    if (widget.addressUser.type == 'Nhà') {
      setState(() {
        type = [true, false];
      });
    } else if (widget.addressUser.type == 'Công ty') {
      setState(() {
        type = [false, true];
      });
    }
    return type;
  }

  updateAddressUser() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    List<AddressModel> addressUser = userProvider.user.address;
    address.updateAddress(
      addressUser,
      AddressModel(
        type: typeAddress,
        customerName: fullNameController.text,
        phoneNumbers: phoneNumberController.text,
        provinceLevel: ProvinceLevel(provinceId: selectedProvince!.provinceId),
        districtLevel:
            DistrictLevel(districtId: selecttedDistricts!.districtId),
        wardLevel: WardLevel(
          wardCode: selectedWards!.wardCode,
        ),
        detail: detailController.text,
        isDefault: widget.addressUser.isDefault,
      ),
      widget.index,
    );
    await address.changeAdreesUser(context, addressUser);
  }

  @override
  void initState() {
    super.initState();
    address.getProvince().then((data) {
      setState(() {
        provinceLevel = data;
        selectedProvince = data.isNotEmpty
            ? data.firstWhere(
                (province) =>
                    province.provinceId ==
                    widget.addressUser.provinceLevel.provinceId,
              )
            : null;
        if (selectedProvince != null) {
          address.getDistrict(selectedProvince!.provinceId).then((value) {
            setState(() {
              districtsLevel = value;
              selecttedDistricts = value.isNotEmpty
                  ? value.firstWhere(
                      (district) =>
                          district.districtId ==
                          widget.addressUser.districtLevel.districtId,
                    )
                  : null;
              if (selecttedDistricts != null) {
                address.getWards(selecttedDistricts!.districtId).then((value) {
                  setState(() {
                    wardLevel = value;
                    selectedWards = value.isNotEmpty
                        ? value.firstWhere((ward) =>
                            ward.wardCode ==
                            widget.addressUser.wardLevel.wardCode)
                        : null;
                  });
                });
              }
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    fullNameController.text = widget.addressUser.customerName;
    phoneNumberController.text = widget.addressUser.phoneNumbers;
    detailController.text = widget.addressUser.detail;
    addressNameController.text = widget.addressUser.type;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chỉnh sửa Thông tin nhận hàng',
          style: TextStyle(color: Colors.black),
        ),
        foregroundColor: primaryColors,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: primaryColors,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Liên hệ',
                  style: TextStyle(color: Color.fromARGB(255, 114, 114, 114)),
                ),
              ),
              TextformAddress(
                controller: fullNameController,
                hint: 'Họ và tên',
                validate: (value) => Validator.validateText(value ?? ''),
              ),
              TextformAddress(
                controller: phoneNumberController,
                hint: 'Số điện thoại',
                validate: (value) => Validator.validateText(value ?? ''),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Địa chỉ',
                  style: TextStyle(color: Color.fromARGB(255, 114, 114, 114)),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 5,
                    top: 5,
                  ),
                  child: Row(
                    children: [
                      const Text('Chọn thành phố: '),
                      const Spacer(),
                      DropdownButton<ProvinceLevel>(
                        hint: const Text(''),
                        value: selectedProvince,
                        onChanged: (newValue) {
                          setState(() {
                            selectedProvince = newValue;
                            selecttedDistricts = null;
                            selectedWards = null;
                            address
                                .getDistrict(newValue!.provinceId)
                                .then((data) {
                              setState(() {
                                districtsLevel = data;
                              });
                            });
                          });
                        },
                        items: provinceLevel.map((ProvinceLevel? item) {
                          return DropdownMenuItem<ProvinceLevel>(
                            value: item,
                            child: Text(item!.provinceName!),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 5, top: 5),
                  child: Row(children: [
                    const Text('Chọn Quận/Huyện: '),
                    const Spacer(),
                    DropdownButton<DistrictLevel>(
                      hint: const Text(''),
                      value: selecttedDistricts,
                      onChanged: (DistrictLevel? newValue) {
                        setState(() {
                          selecttedDistricts = newValue;
                          selectedWards = null;
                          address.getWards(newValue!.districtId).then((value) {
                            setState(() {
                              wardLevel = value;
                            });
                          });
                        });
                      },
                      items: districtsLevel.map((DistrictLevel? item) {
                        return DropdownMenuItem<DistrictLevel>(
                          value: item,
                          child: Text(item!.districtName!),
                        );
                      }).toList(),
                    ),
                  ]),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 5, top: 5),
                  child: Row(children: [
                    const Text('Chọn Xã/Phường: '),
                    const Spacer(),
                    DropdownButton<WardLevel>(
                      hint: const Text(''),
                      value: selectedWards,
                      onChanged: (newValue) {
                        setState(() {
                          selectedWards = newValue;
                        });
                      },
                      items: wardLevel.map((WardLevel? item) {
                        return DropdownMenuItem<WardLevel>(
                          value: item,
                          child: Text(item!.wardName!),
                        );
                      }).toList(),
                    ),
                  ]),
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: TextFormField(
                    controller: detailController,
                    validator: (value) => Validator.validateText(value ?? ''),
                    decoration: InputDecoration(
                      hintText: 'Tên đường, Tòa nhà, Số Nhà',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Cài đặt',
                  style: TextStyle(color: Color.fromARGB(255, 114, 114, 114)),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const Text('Loại địa chỉ'),
                    const Spacer(),
                    SelectButton(
                      selectedTypeAddress: selected(),
                      onTypeSelected: (type) {
                        setState(() {
                          typeAddress = type;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const Text('Chọn làm mặc định'),
                    const Spacer(),
                    SwitchDefaulAddress(
                      light: widget.addressUser.isDefault,
                      index: widget.index,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero),
                              side: BorderSide.none),
                          title: const Text(
                              'Bạn chắc chắn muốn xóa địa chỉ này chứ? '),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              child: const Text(
                                'Hủy',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                deleteAddressUser(widget.index);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColors),
                              child: const Text(
                                'Xác nhận',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(55),
                    backgroundColor: Colors.white,
                    shadowColor: Colors.white,
                  ),
                  child: const Text(
                    'Xóa địa chỉ',
                    style: TextStyle(
                      color: primaryColors,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ButtonSendrequest(
                    text: 'Hoàn thành', submit: updateAddressUser),
              )
            ],
          ),
        ),
      ),
    );
  }
}
