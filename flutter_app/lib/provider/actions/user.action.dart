import 'package:flutter_app/provider/notifiers/user.notifier.dart';
import 'package:flutter_app/services/request.service.dart';
import 'package:flutter_app/services/user.service.dart';
import 'package:http/http.dart';

class UserActions {
  static Future<void> updateUser(dynamic body) async {
    try {
      await UserService().updateUser(body);
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> fetchSuggestFriend(UserNotifier notifier) async {
    try {
      List<dynamic> friends = await UserService().getFriendSuggest();
      notifier.setSuggestFriends(friends);
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> fetchFriends(UserNotifier notifier) async {
    try {
      List<dynamic> friends = await UserService().getFriendList();
      notifier.setFriends(friends);
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> fetchTopThreeUsers(UserNotifier notifier) async {
    try {
      List<dynamic> users = await UserService().getTopThreeUser();
      notifier.setTopThreeUsers(users);
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> fetchRequestsPendingByUser(UserNotifier notifier) async {
    try {
      List<dynamic> requests = await RequestService().fetchRequestsPendingByUser();
      notifier.setRequests(requests);
    } catch (error) {
      rethrow;
    }
  }
}
