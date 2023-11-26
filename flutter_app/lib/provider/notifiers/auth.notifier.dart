import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthNotifier extends ChangeNotifier {
  bool isLogged = false;
  dynamic user = {};

  void setUser(dynamic newUser) {
    user = newUser;
    notifyListeners();
  }

  Future<dynamic> checkAuth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('userId') != null) {
      isLogged = true;
    } else {
      isLogged = false;
    }
    notifyListeners();
  }
}
