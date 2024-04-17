// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:single_project/models/address_model.dart';

class ChangeAdressUser extends StatefulWidget {
  AddressModel addressUser;
  int index;
  ChangeAdressUser({super.key, required this.addressUser, required this.index});

  @override
  State<ChangeAdressUser> createState() => _ChangeAdressUserState();
}

class _ChangeAdressUserState extends State<ChangeAdressUser> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
