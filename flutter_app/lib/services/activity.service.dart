import 'dart:convert';
import 'package:flutter_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ActivityService {
  static Future<List<dynamic>> getActivities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("userId").toString();
    final response = await http.get('$api/activity/$userId' as Uri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse["activity"];
    } else {
      throw Exception('Failed to load activities');
    }
  }
}
