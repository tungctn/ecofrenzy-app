import 'package:flutter/material.dart';

class PostNotifier extends ChangeNotifier {
  // bool get hasPost => post != null;
  List<dynamic> posts = [];

  void setPosts(List<dynamic> newPosts) {
    posts = newPosts;
    notifyListeners();
  }
}
