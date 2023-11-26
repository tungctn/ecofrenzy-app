import 'package:flutter/foundation.dart';
import 'package:flutter_app/models/challenge.dart';

class ChallengeNotifier extends ChangeNotifier {
  List<Challenge> challenges = [];
  bool isPicked = false;

  void setChallenges(List<Challenge> newChallenges) {
    challenges = newChallenges;
    notifyListeners();
  }

  void setIsPicked() {
    isPicked = true;
    notifyListeners();
  }
}
