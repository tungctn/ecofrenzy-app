import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('$api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{'email': email, 'password': password},
      ),
    );

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      // prefs.setString("token", jsonResponse["token"]);
      prefs.setString("userId", jsonResponse["user"]["_id"]);
      print(jsonResponse["user"]);
      jsonResponse["errors"] = false;
      return jsonResponse;
    } else {
      // throw Exception('Failed to login.');
      print(jsonResponse["message"]);
      jsonResponse["errors"] = true;
      return jsonResponse;
    }
  }

  Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$api/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password, 'name': name}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse["user"]);
      jsonResponse["errors"] = false;
      return jsonResponse;
    } else {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      jsonResponse["errors"] = true;
      return jsonResponse;
    }
  }

  Future<dynamic> getUser(String userId) async {
    final response = await http.get(Uri.parse('$api/user/$userId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse["user"]);
      return jsonResponse["user"];
    } else {
      throw Exception('Failed to load user');
    }
  }
}
