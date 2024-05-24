// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SelectButton extends StatefulWidget {
  final Function(String) onTypeSelected;
  List<bool> selectedTypeAddress;
  SelectButton({
    super.key,
    required this.onTypeSelected,
    required this.selectedTypeAddress,
  });

  @override
  State<SelectButton> createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  bool vertical = false;
  String type = '';
  List<Widget> typeAddress = [
    const Text('Nhà'),
    const Text('Cơ quan'),
  ];
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      direction: vertical ? Axis.vertical : Axis.horizontal,
      onPressed: (int index) {
        setState(() {
          List<bool> updatedList = List.from(widget.selectedTypeAddress);
          for (int i = 0; i < widget.selectedTypeAddress.length; i++) {
            updatedList[i] = i == index;
          }
          print(widget.onTypeSelected(
              widget.selectedTypeAddress[index] ? 'Cơ quan' : 'Nhà'));
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
      isSelected: widget.selectedTypeAddress,
      children: typeAddress,
    );
  }
}
