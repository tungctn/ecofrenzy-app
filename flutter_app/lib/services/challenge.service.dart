import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/challenge.dart';
import '../utils/constants.dart';

class ChallengeService {
  Future<List<Challenge>> fetchChallenges() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('userId') == null) {
      // prefs.setString('userId', '6560277efc2c90955e95abb6');
      print('user chua dang nhap');
    }
    final response = await http.get(
        Uri.parse('$api/user/${prefs.getString('userId')}/getTodayChallenge'));
    print('$api/user/${prefs.getString('userId')}/getTodayChallenge');
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse["challenges"]);
      final List challengesJson = jsonResponse['challenges'];
      return challengesJson.map((json) => Challenge.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  Future<List<Challenge>> pickChallenge(String challengeId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.patch(
      Uri.parse(
          '$api/user/${prefs.getString('userId')}/challenge/$challengeId/pick'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse["challenges"]);
      final List challengesJson = jsonResponse['challenges'];
      return challengesJson.map((json) => Challenge.fromJson(json)).toList();
    } else {
      throw Exception('Failed to pick challenge');
    }
  }

  Future<List<Challenge>> doneChallenge(String challengeId, String url) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.patch(
      Uri.parse(
          '$api/user/${prefs.getString('userId')}/challenge/$challengeId/done'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"url": url}),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse["challenges"]);
      final List challengesJson = jsonResponse['challenges'];
      return challengesJson.map((json) => Challenge.fromJson(json)).toList();
    } else {
      throw Exception('Failed to complete challenge');
    }
  }
}
