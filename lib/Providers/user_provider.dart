import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_project/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    email: '',
    emailVerified: true,
    provider: '',
    socialId: '',
    firstName: '',
    lastName: '',
    role: '',
    avatar: Avatar(publicId: '', url: ''),
    address: [],
    createdAt: '',
    updatedAt: '',
  );
  User get user => _user;
  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  Future<AuthModel?> getUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      return AuthModel.fromJson(userJson);
    }
    return null;
  }
}
