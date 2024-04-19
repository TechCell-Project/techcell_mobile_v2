import 'dart:io';

import 'package:flutter/material.dart';
import 'package:single_project/api/api_image.dart';
import 'package:single_project/api/api_profile_user.dart';
import 'package:single_project/util/constants.dart';
import 'package:single_project/widgets/text_fields/text_field.dart';

class UserWidget {
  Widget avatarUser(
    BuildContext context,
    Widget avatar,
    Widget bottomSheet,
  ) {
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
                  color: primaryColors.withOpacity(0.3),
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
                showModalBottomSheet(
                    context: context, builder: ((context) => bottomSheet));
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

  Widget infoUser(String text, String texinfo) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                text,
                style: const TextStyle(color: Colors.grey),
              ),
              const Spacer(),
              Text(
                texinfo,
                style: primaryText,
              ),
            ],
          ),
          divider(),
        ],
      ),
    );
  }

  void openDialog(
    BuildContext context,
    TextEditingController firstNameController,
    TextEditingController lastNameController,
    bool check,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Chỉnh sửa thông tin '),
          content: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 100,
              minWidth: double.infinity,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFieldWidget(
                    controller: firstNameController,
                    labelText: 'Họ',
                  ),
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    controller: lastNameController,
                    labelText: 'Tên',
                  )
                ],
              ),
            ),
          ),
          actions: [
            if (check == true)
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: primaryColors),
                  child: const Text(
                    'Hoàn thành',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    ApiUser().changeProfileUser(context,
                        firstNameController.text, lastNameController.text);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text(
                    'Hoàn thành',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget buttonChangeAvatar(BuildContext context, File file) {
    return Center(
      child: InkWell(
        onTap: () {
          AvatarApi().postImage(context: context, image: file);
        },
        child: Container(
          height: 40,
          width: 100,
          decoration: BoxDecoration(
              color: primaryColors, borderRadius: BorderRadius.circular(10)),
          child: const Padding(
            padding: EdgeInsets.all(3.0),
            child: Row(
              children: [
                Text(
                  'Thay đổi ',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(Icons.image, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

 Widget isDefault() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        top: 5,
        bottom: 5,
      ),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: primaryColors),
        ),
        child: const Text(
          'Mặc định',
          style: TextStyle(
            color: primaryColors,
          ),
        ),
      ),
    );
  }

  Widget textInfo(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
