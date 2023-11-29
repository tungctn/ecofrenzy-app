import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/constants.dart';

class UserService {
  Future<String> getUser() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'User';
  }

  Future<void> updateUser(dynamic body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('userId'));
    final userId = prefs.getString('userId').toString();
    final response = await http.patch(
      Uri.parse('$api/user/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse["user"]);
    } else {
      throw Exception('Failed to update user.');
    }
  }

  Future<void> addFriend(String friendId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId').toString();
    final response = await http.post(
      Uri.parse('$api/user/add-friend'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"userId": userId, "friendId": friendId}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);
    } else {
      throw Exception('Failed to add friend.');
    }
  }

  Future<dynamic> getFriendList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId').toString();
    final response = await http.get(
      Uri.parse('$api/user/$userId/friend-list'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse['friendList']);
      return jsonResponse['friendList'];
    } else {
      throw Exception('Failed to get friend list.');
    }
  }

  Future<dynamic> getFriendSuggest() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId').toString();
    final response = await http.get(
      Uri.parse('$api/user/$userId/friend-suggest'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse['users']);
      return jsonResponse['users'];
    } else {
      throw Exception('Failed to get friend request list.');
    }
  }
}
