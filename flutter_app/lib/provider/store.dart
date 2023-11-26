import 'package:flutter_app/provider/notifiers/auth.notifier.dart';
import 'package:flutter_app/provider/notifiers/challenge.notifier.dart';
import 'package:flutter_app/provider/notifiers/post.notifier.dart';
import 'package:flutter_app/provider/notifiers/profile.notifier.dart';

class Store {
  final ChallengeNotifier challengeNotifier;
  final PostNotifier postNotifier;
  final AuthNotifier authNotifier;
  final ProfileNotifier profileNotifier;

  Store()
      : challengeNotifier = ChallengeNotifier(),
        postNotifier = PostNotifier(),
        profileNotifier = ProfileNotifier(),
        authNotifier = AuthNotifier();
}
