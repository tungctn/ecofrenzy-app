import 'package:flutter/material.dart';

class PostNotifier extends ChangeNotifier {
  // bool get hasPost => post != null;
  List<dynamic> posts = [];

  void setPosts(List<dynamic> newPosts) {
    posts = newPosts;
    notifyListeners();
  }

  void likePost(String postId) {
    posts = posts.map((post) {
      if (post['_id'] == postId) {
        post['liked'] = !post['liked'];
      }
      return post;
    }).toList();
    notifyListeners();
  }
}
