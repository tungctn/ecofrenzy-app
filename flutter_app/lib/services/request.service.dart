import 'package:flutter_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RequestService {
  Future<dynamic> createRequest(String recipientId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('userId'));
    final userId = prefs.getString('userId').toString();
    final response = await http.post(
      Uri.parse('$api/request'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}',
      },
      body: jsonEncode(
        <String, String>{
          "recipientId": recipientId,
        },
      ),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse["post"]);
    } else {
      throw Exception('Failed to create post.');
    }
  }

  Future<dynamic> updateRequest(String requestId, String status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.put(
      Uri.parse('$api/request/$requestId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}',
      },
      body: jsonEncode(
        <String, String>{
          "status": status,
        },
      ),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);
    } else {
      throw Exception('Failed to create post.');
    }
  }

  Future<List<dynamic>> fetchRequestsPendingByUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await http.get(Uri.parse('$api/request/getRequestPendingByUser'), headers: <String, String>{
      'Authorization': 'Bearer ${prefs.getString('token')}',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse["listRequests"]);
      final List requestsJson = jsonResponse['listRequests'];
      return requestsJson;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  // Future<dynamic> fetchAllRequest () async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final response =
  //       await http.get(Uri.parse('$api/request/getAllRequestExcept'), headers: <String, String>{
  //     'Authorization': 'Bearer ${prefs.getString('token')}',
  //   });
  // }
}
