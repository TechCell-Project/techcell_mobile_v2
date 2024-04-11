import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:single_project/page/screens/cart_screen.dart';
import 'package:single_project/page/screens/home_screen.dart';
import 'package:single_project/page/screens/notification_screen.dart';
import 'package:single_project/page/screens/setting_screen.dart';
import 'package:single_project/util/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const CartScreen(),
    const NotificationScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: GNav(
            gap: 4,
            backgroundColor: Colors.white,
            color: Colors.grey,
            activeColor: Colors.white,
            tabBackgroundColor: primaryColors,
            padding: const EdgeInsets.all(16),
            iconSize: 25,
            onTabChange: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Trang chủ',
              ),
              GButton(
                icon: Icons.shopping_bag,
                text: 'Giỏ hàng',
              ),
              GButton(
                icon: Icons.notifications,
                text: 'Thông báo',
              ),
              GButton(
                icon: Icons.account_circle_sharp,
                text: 'Tôi',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
