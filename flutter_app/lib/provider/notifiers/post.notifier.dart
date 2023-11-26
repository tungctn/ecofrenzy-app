import 'package:flutter/material.dart';
import 'package:flutter_app/models/post.dart';

class PostNotifier extends ChangeNotifier {
  // bool get hasPost => post != null;
  List<dynamic> posts = [];

  void setPosts(List<dynamic> newPosts) {
    posts = newPosts;
    notifyListeners();
  }
}
