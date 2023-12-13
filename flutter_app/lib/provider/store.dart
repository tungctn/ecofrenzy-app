import 'package:flutter_app/provider/notifiers/activity.notifier.dart';
import 'package:flutter_app/provider/notifiers/auth.notifier.dart';
import 'package:flutter_app/provider/notifiers/challenge.notifier.dart';
import 'package:flutter_app/provider/notifiers/post.notifier.dart';
import 'package:flutter_app/provider/notifiers/profile.notifier.dart';
import 'package:flutter_app/provider/notifiers/user.notifier.dart';
import 'package:flutter_app/provider/notifiers/voucher.notifier.dart';

class Store {
  final ChallengeNotifier challengeNotifier;
  final PostNotifier postNotifier;
  final AuthNotifier authNotifier;
  final ProfileNotifier profileNotifier;
  final ActivityNotifier activityNotifier;
  final UserNotifier userNotifier;
  final VoucherNotifier voucherNotifier;

  Store()
      : challengeNotifier = ChallengeNotifier(),
        postNotifier = PostNotifier(),
        profileNotifier = ProfileNotifier(),
        authNotifier = AuthNotifier(),
        activityNotifier = ActivityNotifier(),
        voucherNotifier = VoucherNotifier(),
        userNotifier = UserNotifier();
}
