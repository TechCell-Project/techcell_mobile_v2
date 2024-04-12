import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_project/Providers/user_provider.dart';
import 'package:single_project/api/api_login.dart';
import 'package:single_project/page/tabs/profile_user/address_user/address_user.dart';
import 'package:single_project/page/tabs/profile_user/change_password_user.dart';
import 'package:single_project/page/tabs/profile_user/information_user.dart';
import 'package:single_project/page/tabs/profile_user/order_user.dart';
import 'package:single_project/widgets/button/button_send_requrest.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<UserProvider>(context).getUserFromStorage(),
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
              var user = snapshot.data!.user;
              String avatarLetter = user.firstName[0].toUpperCase();
              String avatarLetterLasName = user.lastName[0].toUpperCase();
              return Scaffold(
                body: SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 35),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              if (user.avatar.url.isEmpty)
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 198, 198, 198),
                                  ),
                                  child: Center(
                                    child: Text(
                                      avatarLetterLasName + avatarLetter,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 24),
                                    ),
                                  ),
                                )
                              else
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                  ),
                                  child: Image(
                                    image: NetworkImage(user.avatar.url),
                                  ),
                                ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        user.lastName,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        user.firstName,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text(user.email),
                                ],
                              ),
                            ],
                          ),
                        ),
                        divider(),
                        colorTitles(),
                        divider(),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ButtonSendrequest(
                            text: 'Đăng xuất',
                            submit: () {
                              ApiLogin().logout(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }

  Widget divider() {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Divider(
        thickness: 0.5,
      ),
    );
  }

  Widget colorTitles() {
    return Column(
      children: [
        colorTitle(Icons.person_outline, Colors.deepPurple, 'Hồ sơ ',
            () => const InformationUserTab()),
        colorTitle(Icons.location_on, Colors.blue, 'Địa chỉ',
            () => const AddreesUserTab()),
        colorTitle(Icons.shopping_cart_checkout_outlined, Colors.pink,
            'Đơn hàng', () => const OrderUserTab()),
        colorTitle(Icons.settings, Colors.orange, 'Đổi Mật khẩu',
            () => const ChangePasswordTab()),
      ],
    );
  }

  Widget colorTitle(IconData icon, Color color, String text, Function() fun) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => fun()));
      },
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        title: Text(text),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
          size: 20,
        ),
      ),
    );
  }
}
