import 'package:flutter_app/provider/notifiers/activity.notifier.dart';
import 'package:flutter_app/services/activity.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityActions {
  static Future<void> getActivities(ActivityNotifier notifier) async {
    try {
      final activities = await ActivityService().getActivities();
      notifier.setActivity(activities);
    } catch (error) {
      rethrow;
    }
  }
}
