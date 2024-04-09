import 'package:flutter/material.dart';
import 'package:single_project/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  AuthModel _user = AuthModel(
    accessToken: '',
    accessTokenExpires: 0,
    refreshToken: '',
    user: User(
        email: '',
        emailVerified: true,
        provider: '',
        socialId: '',
        firstName: '',
        lastName: '',
        role: '',
        avatar: Avatar(publicId: '', url: '')),
    address: [],
    block: Block(false, []),
  );
  AuthModel get user => _user;
  void setUser(dynamic user) {
    _user = AuthModel.fromJson(user);
    notifyListeners();
  }
}
