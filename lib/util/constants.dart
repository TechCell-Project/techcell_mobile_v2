import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const primaryColors = Color(0xFFEE4949);
const primaryText = TextStyle(fontSize: 16, color: Colors.black);

String uriAuth = 'https://api.techcell.cloud/api/auth';
String uriAddress = 'https://api.techcell.cloud/api/address';
Widget divider() {
  return const Padding(
    padding: EdgeInsets.all(8),
    child: Divider(
      thickness: 0.5,
    ),
  );
}

String formatTimestamp(String timestamp) {
  // Parse the input timestamp
  DateTime dateTime = DateTime.parse(timestamp);

  // Format the date and time
  String formattedDate =
      DateFormat('hh:mm - dd \'Tháng\' M, y').format(dateTime);

  return formattedDate;
}
