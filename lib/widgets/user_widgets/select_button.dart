// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SelectButton extends StatefulWidget {
  final Function(String) onTypeSelected;
  const SelectButton({super.key, required this.onTypeSelected});

  @override
  State<SelectButton> createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  bool vertical = false;
  String type = '';
  List<Widget> typeAddress = [
    const Text('Nhà'),
    const Text('Công ty'),
  ];
  final List<bool> _selectedTypeAddress = <bool>[false, false];
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      direction: vertical ? Axis.vertical : Axis.horizontal,
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < _selectedTypeAddress.length; i++) {
            _selectedTypeAddress[i] = i == index;
          }
          if (_selectedTypeAddress[0]) {
            type = 'Nhà';
          }
          if (_selectedTypeAddress[1]) {
            type = 'Công ty';
          }
          widget.onTypeSelected(type);
        });
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedBorderColor: Colors.red[700],
      selectedColor: Colors.white,
      fillColor: Colors.red[200],
      color: Colors.red[400],
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 80.0,
      ),
      isSelected: _selectedTypeAddress,
      children: typeAddress,
    );
  }
}
