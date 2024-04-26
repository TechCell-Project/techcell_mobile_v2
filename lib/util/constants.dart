import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const primaryColors = Color(0xFFEE4949);
const primaryText = TextStyle(fontSize: 16, color: Colors.black);

String uriAuth = 'https://api.techcell.cloud/api/auth';
String uriAddress = 'https://api.techcell.cloud/api/address';
String uriCart = 'https://api.techcell.cloud/api/carts';
String uriOrder = 'https://api.techcell.cloud/api/orders';
Widget divider() {
  return const Padding(
    padding: EdgeInsets.all(8),
    child: Divider(
      thickness: 0.5,
    ),
  );
}

final formatCurrency =
    NumberFormat.currency(locale: 'id', decimalDigits: 0, name: 'đ');

String formatTimestamp(String timestamp) {
  // Parse the input timestamp
  DateTime dateTime = DateTime.parse(timestamp);

  // Format the date and time
  String formattedDate =
      DateFormat('hh:mm - dd \'Tháng\' M, y').format(dateTime);

  return formattedDate;
}

extension MyExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}';
  }
}
