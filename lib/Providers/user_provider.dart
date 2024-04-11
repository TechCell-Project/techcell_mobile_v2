import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  void setUser(AuthModel user) {
    _user = user;
    notifyListeners();
  }

  static Future<AuthModel?> getUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      return AuthModel.fromJson(userJson);
    }
    return null;
  }
}
