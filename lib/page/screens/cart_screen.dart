import 'package:flutter/material.dart';
import 'package:single_project/api/api_login.dart';
import 'package:single_project/page/tabs/authentication_tab/login_tab.dart';
import 'package:single_project/page/tabs/cart/cart_tab.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: ApiLogin().checkSession(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                } else {
                  final bool isLoggedIn = snapshot.data ?? false;
                  if (isLoggedIn) {
                    return CartTab();
                  } else {
                    return const LoginTap();
                  }
                }
              }
            }));
  }
}
