import 'package:flutter_app/models/challenge.dart';
import 'package:flutter_app/provider/notifiers/challenge.notifier.dart';
import 'package:flutter_app/provider/notifiers/post.notifier.dart';
import 'package:flutter_app/services/challenge.service.dart';
import 'package:flutter_app/services/post.service.dart';

class ChallengeActions {
  static Future<void> fetchChallenges(ChallengeNotifier notifier) async {
    try {
      List<Challenge> challenges = await ChallengeService().fetchChallenges();
      notifier.setChallenges(challenges);
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> pickChallenge(
      ChallengeNotifier notifier, String challengeId) async {
    try {
      ChallengeService().pickChallenge(challengeId);
      List<Challenge> challenges =
          await ChallengeService().pickChallenge(challengeId);
      notifier.setIsPicked();
      notifier.setChallenges(challenges);
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> doneChallenge(ChallengeNotifier challengeNotifier,
      String challengeId, String url, PostNotifier postNotifier) async {
    try {
      ChallengeService().doneChallenge(challengeId, url);
      List<Challenge> challenges =
          await ChallengeService().doneChallenge(challengeId, url);
      List<dynamic> posts = await PostService().fetchPosts();
      challengeNotifier.setChallenges(challenges);
      postNotifier.setPosts(posts);
    } catch (error) {
      rethrow;
    }
  }
}
