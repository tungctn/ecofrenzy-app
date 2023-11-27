import 'dart:convert';
import 'package:flutter_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ActivityService {
  Future<List<dynamic>> getActivities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("userId").toString();
    final response = await http.get(Uri.parse('$api/activity/$userId'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse["activity"] != null) {
        return jsonResponse["activity"]['challenge'];
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load activities');
    }
  }
}
