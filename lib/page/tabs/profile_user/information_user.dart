// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:single_project/Providers/user_provider.dart';
import 'package:single_project/api/api_profile_user.dart';
import 'package:single_project/models/user_model.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/widgets/button/button_send_requrest.dart';
import 'package:single_project/widgets/user_widgets/text_in_avatar.dart';
import 'package:single_project/widgets/user_widgets/widget_uer.dart';

class InformationUserTab extends StatefulWidget {
  User user;
  InformationUserTab({
    super.key,
    required this.user,
  });

  @override
  State<InformationUserTab> createState() => _InformationUserTabState();
}

class _InformationUserTabState extends State<InformationUserTab> {
  UserWidget userWidget = UserWidget();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  String avatarLetter = '';
  String avatarLetterLasName = '';
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: primaryColors,
        title: const Text(
          'Hồ sơ người dùng ',
          style: TextStyle(color: primaryColors),
        ),
      ),
      body: FutureBuilder<User>(
        future: ApiUser().getProfileUser(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return Container();
          } else if (snapshot.hasError || snapshot.data == null) {
            return Container();
          } else {
            var userProvider =
                Provider.of<UserProvider>(context, listen: false).user;

            if (userProvider.firstName.isNotEmpty &&
                userProvider.lastName.isNotEmpty) {
              avatarLetter = userProvider.firstName[0].toUpperCase();
              avatarLetterLasName = userProvider.lastName[0].toUpperCase();
            } else {
              return Container();
            }
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: GestureDetector(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (userProvider.avatar.url.isNotEmpty)
                        userWidget.avatarUser(
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(userProvider.avatar.url),
                          ),
                        )
                      else
                        userWidget.avatarUser(
                          CircleAvatar(
                            child: TextInAvatar(
                              textAvatar: avatarLetterLasName + avatarLetter,
                              width: 140,
                              height: 140,
                              fontSized: 50,
                            ),
                          ),
                        ),
                      const SizedBox(height: 50),
                      Column(
                        children: [
                          Center(
                            child: Container(
                              padding: const EdgeInsets.only(top: 10, right: 3),
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: primaryColors.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  userWidget.infoUser('Họ tên:',
                                      '${userProvider.lastName} ${userProvider.firstName}'),
                                  userWidget.infoUser(
                                      'email:', userProvider.email),
                                  userWidget.infoUser('Ngày tạo tài khoản:',
                                      formatTimestamp(userProvider.createdAt)),
                                  userWidget.infoUser('Cập nhật lúc:',
                                      formatTimestamp(userProvider.updatedAt)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ButtonSendrequest(
                                text: 'Câp nhật',
                                submit: () {
                                  lastNameController.text =
                                      userProvider.lastName;
                                  firstNameController.text =
                                      userProvider.firstName;
                                  userWidget.openDialog(
                                    context,
                                    firstNameController,
                                    lastNameController,
                                    check,
                                  );
                                }),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
