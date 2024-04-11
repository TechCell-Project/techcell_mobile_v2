import 'package:flutter/material.dart';
import 'package:single_project/api/api_login.dart';
import 'package:single_project/page/tabs/authentication_tab/login_tab.dart';
import 'package:single_project/page/tabs/profile_user/profile_user_tab.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
                return const ProfileUser();
              } else {
                return const LoginTap();
              }
            }
          }
        },
      ),
    );
  }
}
