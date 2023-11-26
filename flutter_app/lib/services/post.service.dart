import 'package:flutter_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/post.dart';

class PostService {
  Future<Post> createPost(String challengeId, String image) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('userId'));
    final userId = prefs.getString('userId').toString();
    final response = await http.post(
      Uri.parse('$api/post'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'image': image,
          'challengeId': challengeId,
          'userId': userId
        },
      ),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse["post"]);
      return Post.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to create post.');
    }
  }

  Future<List<dynamic>> fetchPosts() async {
    final response = await http.get(Uri.parse('$api/post'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse["posts"]);
      final List postsJson = jsonResponse['posts'];
      return postsJson;
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
