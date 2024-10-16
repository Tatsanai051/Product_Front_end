import 'package:flutter/material.dart';
import 'package:flutter_lab1/variables.dart';
import 'package:flutter_lab1/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_lab1/providers/user_providers.dart';

class AuthService {
  Future<UserModel> login(String userName, String password) async {
    print(apiURL);

    final response = await http.post(Uri.parse("$apiURL/api/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": userName,
          "password": password,
        }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> register(
      String name, String userName, String password, String role) async {
    final response = await http.post(Uri.parse("$apiURL/api/auth/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "username": userName,
          "password": password,
          "role": role,
        }));
    print(response.statusCode);
    if (response.statusCode == 201) {
      print("Rsgistration Successful");
    } else {
      print("Rsgistration Failed");
      print("Response body: ${response.body}");
    }
  }

  Future<void> refreshToken(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final response = await http.post(
      Uri.parse("$apiURL/api/auth/refresh"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "token": userProvider.RefreshToken,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final accessToken = data['accessToken'];
      userProvider.updadateAccessToken(accessToken);
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    await prefs.clear();
    final response = await http.post(
      Uri.parse("$apiURL/api/auth/logout"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${userProvider.accessToken}",
      },
    );

    if (response.statusCode == 200) {
    } else {}
  }
}
