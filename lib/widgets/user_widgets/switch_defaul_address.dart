import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:single_project/Providers/user_provider.dart';
import 'package:single_project/models/address_model.dart';

// ignore: must_be_immutable
class SwitchDefaulAddress extends StatefulWidget {
  bool light;
  int index;
  SwitchDefaulAddress({super.key, required this.light, required this.index});

  @override
  State<SwitchDefaulAddress> createState() => _SwitchDefaulAddressState();
}

class _SwitchDefaulAddressState extends State<SwitchDefaulAddress> {
  void _toggleDefaultAddress(int index) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    List<AddressModel> addressUser = userProvider.user.address;
    if (index >= 0 && index < addressUser.length) {
      setState(() {
        for (int i = 0; i < addressUser.length; i++) {
          addressUser[i].isDefault = i == index;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: widget.light,
      activeColor: Colors.red,
      onChanged: (bool value) {
        _toggleDefaultAddress(widget.index);
        setState(() {
          widget.light = value;
        });
      },
    );
  }
}
