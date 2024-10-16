import 'package:flutter/material.dart';
import 'package:flutter_lab1/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  String? accesToken;
  String? refreshToken;
  User get user => _user!;
  String get accessToken => accesToken!;
  String get RefreshToken => refreshToken!;

  void onLogin(UserModel userModel) {
    _user = userModel.user;
    accesToken = userModel.accessToken;
    refreshToken = userModel.refreshToken;
    notifyListeners();
  }

  void onLogout() {
    _user = null;
    accesToken = null;
    refreshToken = null;
    notifyListeners();
  }

  void updadateAccessToken(String token) {
    accesToken = token;
    if (RefreshToken != null) {
      refreshToken = RefreshToken;
    }
    notifyListeners();
  }
}
