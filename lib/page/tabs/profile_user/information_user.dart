// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_project/Providers/user_provider.dart';
import 'package:single_project/api/api_profile_user.dart';
import 'package:single_project/models/user_model.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/widgets/user_widgets/text_in_avatar.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: primaryColors,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Thông tin người dùng',
          style: TextStyle(color: Colors.black),
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
          } else {
            var userProvider =
                Provider.of<UserProvider>(context, listen: false).user;
            String avatarLetter = userProvider.firstName[0].toUpperCase();
            String avatarLetterLasName = userProvider.lastName[0].toUpperCase();
            return Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 245, 245, 245)),
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: GestureDetector(
                child: Column(
                  children: [
                    if (userProvider.avatar.url.isNotEmpty)
                      avatarUser(
                        CircleAvatar(
                          child: Image(
                            image: NetworkImage(userProvider.avatar.url),
                          ),
                        ),
                      )
                    else
                      avatarUser(
                        CircleAvatar(
                          child: TextInAvatar(
                            textAvatar: avatarLetterLasName + avatarLetter,
                            width: 140,
                            height: 140,
                            fontSized: 50,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget avatarUser(Widget avatar) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              border: Border.all(
                width: 4,
                color: Colors.white,
              ),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
              shape: BoxShape.circle,
            ),
            child: avatar,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                // showModalBottomSheet(
                //     context: context,
                //     builder: ((context) => bottomSheet(context)));
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: Colors.white,
                  ),
                  color: primaryColors,
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
