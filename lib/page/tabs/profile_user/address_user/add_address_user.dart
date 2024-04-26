import 'package:flutter/material.dart';
import 'package:single_project/api/api_address.dart';
import 'package:single_project/models/address_model.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/util/validator.dart';
import 'package:single_project/widgets/button/button_send_requrest.dart';
import 'package:single_project/widgets/text_fields/text_field_address.dart';
import 'package:single_project/widgets/user_widgets/defaul_address.dart';
import 'package:single_project/widgets/user_widgets/select_button.dart';

class AddAdressUser extends StatefulWidget {
  const AddAdressUser({super.key});

  @override
  State<AddAdressUser> createState() => _AddAdressUserState();
}

class _AddAdressUserState extends State<AddAdressUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final TextEditingController addressTypeController = TextEditingController();
  String typeAddress = '';
  ApiAddress address = ApiAddress();
  List<ProvinceLevel> provinceLevel = [];
  List<DistrictLevel> districtsLevel = [];
  List<WardLevel> wardLevel = [];

  //set values sau khi chọn
  ProvinceLevel? selectedProvince;
  DistrictLevel? selecttedDistricts;
  WardLevel? selectedWards;

//giúp hiện các widget sau khi chọn ở trên
  bool isProvinceSelected = false;
  bool isDistrictSelected = false;
  bool isDefaul = false;

  String textAddressLevel = 'Chưa chọn thành phố nào';
  @override
  void initState() {
    super.initState();
    address.getProvince().then((data) {
      setState(() {
        provinceLevel = data;
      });
    });
  }

  void addAddress() {
    if (_formKey.currentState!.validate()) {
      address.addAdressUser(
        context,
        AddressModel(
          type: typeAddress,
          customerName: fullNameController.text,
          phoneNumbers: phoneNumberController.text,
          provinceLevel: ProvinceLevel(
            provinceId: selectedProvince!.provinceId,
          ),
          districtLevel: DistrictLevel(
            districtId: selecttedDistricts!.districtId,
          ),
          wardLevel: WardLevel(wardCode: selectedWards!.wardCode),
          detail: detailController.text,
          isDefault: isDefaul,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Địa chỉ mới',
          style: TextStyle(color: Colors.black),
        ),
        foregroundColor: primaryColors,
        elevation: 0,
        backgroundColor: Colors.white,
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
                keyboard: TextInputType.phone,
                controller: phoneNumberController,
                hint: 'Số điện thoại',
                validate: (value) => Validator.validatePhoneNumber(value ?? ''),
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
                      left: 10, right: 10, bottom: 5, top: 5),
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
                            isProvinceSelected = true;
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
              if (isProvinceSelected)
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
                            isDistrictSelected = true;
                            selectedWards = null;
                            address
                                .getWards(newValue!.districtId)
                                .then((value) {
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
                )
              else
                Container(),
              if (isDistrictSelected)
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
                )
              else
                Container(),
              TextformAddress(
                controller: detailController,
                hint: 'Tên đường, Tòa nhà, Số Nhà',
                validate: (value) => Validator.validateText(value ?? ''),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Loại địa chỉ',
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
                      selectedTypeAddress: const [false, false],
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
                    border: Border(
                      top: BorderSide(width: 0.4),
                    )),
                child: Row(
                  children: [
                    const Text('Chọn làm mặc định'),
                    const Spacer(),
                    SwitchDefaulAddAddress(
                      light: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ButtonSendrequest(
                  text: 'Thêm địa chỉ mới',
                  submit: () {
                    addAddress();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
