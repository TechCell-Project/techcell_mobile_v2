import 'package:flutter/material.dart';
import 'package:single_project/api/api_address.dart';
import 'package:single_project/models/address_model.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/util/validator.dart';
import 'package:single_project/widgets/button/button_send_requrest.dart';
import 'package:single_project/widgets/text_fields/text_field_address.dart';

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
  final TextEditingController addressNameController = TextEditingController();
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
                height: 50,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  ),
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: () {
                    ApiAddress().getProvince();
                  },
                  child: const Padding(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Text('Chọn thành phố: '),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ButtonSendrequest(
                  text: 'Thêm địa chỉ mới',
                  submit: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
