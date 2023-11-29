import 'package:flutter/material.dart';

class UserNotifier extends ChangeNotifier {
  // User _user;
  dynamic suggestFriends;
  dynamic friends;

  void setSuggestFriends(dynamic friends) {
    suggestFriends = friends;
    notifyListeners();
  }

  void setFriends(dynamic friends) {
    this.friends = friends;
    notifyListeners();
  }
}
