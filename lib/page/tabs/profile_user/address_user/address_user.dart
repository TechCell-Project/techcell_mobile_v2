import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_project/Providers/user_provider.dart';
import 'package:single_project/api/api_profile_user.dart';
import 'package:single_project/models/address_model.dart';
import 'package:single_project/page/tabs/profile_user/address_user/add_address_user.dart';
import 'package:single_project/page/tabs/profile_user/address_user/change_address_user.dart';
import 'package:single_project/util/constants.dart';

class AddreesUserTab extends StatefulWidget {
  const AddreesUserTab({super.key});

  @override
  State<AddreesUserTab> createState() => _AddreesUserTabState();
}

class _AddreesUserTabState extends State<AddreesUserTab> {
  List<AddressModel> addressUser = [];

  @override
  Widget build(BuildContext context) {
    List<AddressModel> addressUser =
        Provider.of<UserProvider>(context, listen: false).user.address;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: primaryColors,
        title: const Text(
          'Địa chỉ giao hàng',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder(
          future: ApiUser().getProfileUser(context),
          builder: (context, snapshoot) {
            if (snapshoot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Địa chỉ đã lưu',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: addressUser.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => ChangeAdressUser(
                                      addressUser: addressUser[index],
                                      index: index,
                                    )),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, bottom: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5),
                                        child: Text(
                                          addressUser[index].customerName,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const SizedBox(
                                        height: 18,
                                        child: VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1,
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: MediaQuery.of(context).size.width * 0.3,
                                      //   child: Text(
                                      //     addressUser[index].phoneNumbers,
                                      //     style: const TextStyle(
                                      //       color: Colors.grey,
                                      //       fontSize: 16,
                                      //       fontWeight: FontWeight.w500,
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 5, bottom: 5),
                                      child:
                                          textInfo(addressUser[index].detail),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    children: [
                                      textInfo(
                                          '${addressUser[index].wardLevel.wardId}, '),
                                      textInfo(
                                          '${addressUser[index].provinceLevel.provinceId}, '),
                                      textInfo(
                                          '${addressUser[index].districtLevel.districtId}, '),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                if (addressUser[index].isDefault == true)
                                  isDefault()
                                else
                                  Container(),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddAdressUser(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.add_circled,
                              size: 30,
                              color: primaryColors,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Thêm Địa Chỉ Mới',
                              style: TextStyle(
                                color: primaryColors,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
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
