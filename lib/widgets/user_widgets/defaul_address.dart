import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:single_project/Providers/user_provider.dart';
import 'package:single_project/models/address_model.dart';

// ignore: must_be_immutable
class SwitchDefaulAddAddress extends StatefulWidget {
  bool light;
  SwitchDefaulAddAddress({super.key, required this.light});

  @override
  State<SwitchDefaulAddAddress> createState() => _SwitchDefaulAddAddressState();
}

class _SwitchDefaulAddAddressState extends State<SwitchDefaulAddAddress> {
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
        setState(() {
          widget.light = value;
        });
      },
    );
  }
}
