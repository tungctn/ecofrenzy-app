import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ActivityNotifier extends ChangeNotifier {
  dynamic activities = [];

  void setActivity(dynamic newActivity) {
    activities = newActivity;
  }
}
