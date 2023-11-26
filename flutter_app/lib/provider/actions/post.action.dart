import 'package:flutter_app/provider/notifiers/post.notifier.dart';
import 'package:flutter_app/services/post.service.dart';

class PostActions {
  static Future<void> fetchChallenges(PostNotifier notifier) async {
    try {
      List<dynamic> posts = await PostService().fetchPosts();
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
}
