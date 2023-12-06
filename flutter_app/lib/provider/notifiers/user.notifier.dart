import 'package:flutter/material.dart';

class UserNotifier extends ChangeNotifier {
  // User _user;
  dynamic suggestFriends;
  dynamic friends;
  dynamic topThreeUsers;
  dynamic requests;

  void setSuggestFriends(dynamic friends) {
    suggestFriends = friends;
    notifyListeners();
  }

  void setFriends(dynamic friends) {
    this.friends = friends;
    notifyListeners();
  }

  void setTopThreeUsers(dynamic users) {
    topThreeUsers = users;
    notifyListeners();
  }

  void setRequests(dynamic requests) {
    this.requests = requests;
    notifyListeners();
  }

  void sendRequest(String recipientId) {
    // RequestService().createRequest(recipientId);
    suggestFriends = suggestFriends.map((friend) {
      if (friend['_id'] == recipientId) {
        friend['isAdd'] = true;
      }
      return friend;
    }).toList();
    notifyListeners();
  }
}
