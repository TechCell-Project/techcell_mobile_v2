import 'package:flutter/material.dart';
import 'package:single_project/util/constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Thông báo',
          style: primaryText,
        )),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
