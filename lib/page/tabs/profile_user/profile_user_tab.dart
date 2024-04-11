import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_project/api/api_login.dart';
import 'package:single_project/models/user_model.dart';
import 'package:single_project/widgets/button/button_send_requrest.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  Future<AuthModel?> getUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      return AuthModel.fromJson(userJson);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getUserFromStorage(),
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
              return Scaffold(
                body: Center(
                  child: Column(
                    children: [
                      Text(snapshot.data!.user.firstName),
                      ButtonSendrequest(
                        text: 'Đăng xuất',
                        submit: () {
                          ApiLogin().logout(context,
                              token: snapshot.data!.accessToken);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
// ButtonSendrequest(
//             text: 'Đăng xuất',
//             submit: () {
//               ApiLogin().logout(context);
//             },
//           ),