import 'package:flutter/foundation.dart';
import 'package:flutter_app/models/profile.dart';

class ProfileNotifier extends ChangeNotifier {
  dynamic profile = {};

  void setProfile(Profile newProfile) {
    profile = newProfile;
    notifyListeners();
  }
}
