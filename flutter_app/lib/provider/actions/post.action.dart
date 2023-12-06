import 'package:flutter_app/provider/notifiers/post.notifier.dart';
import 'package:flutter_app/services/post.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostActions {
  // PostActions(PostNotifier read, postId, String text);

  static Future<void> fetchPost(PostNotifier notifier) async {
    try {
      List<dynamic> fetchPosts = await PostService().fetchPosts();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final posts = fetchPosts.map((post) {
        post["reacts"] = post["reacts"].map((react) {
          return react["user"];
        }).toList();
        if (post['reacts'].contains(prefs.getString('userId'))) {
          post['liked'] = true;
        } else {
          post['liked'] = false;
        }
        return post;
      }).toList();

      notifier.setPosts(posts);
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> createPost(
      PostNotifier notifier, String image, String challengeId) async {
    try {
      await PostService().createPost(challengeId, image);
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> likePost(PostNotifier notifier, String postId) async {
    try {
      // await PostService().likePost(postId);
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> commentPost(
      PostNotifier notifier, String postId, String comment) async {
    try {
      await PostService().commentPost(postId, comment);
    } catch (error) {
      rethrow;
    }
  }
}
