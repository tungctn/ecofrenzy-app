import 'package:flutter/material.dart';
import 'package:flutter_app/models/challenge.dart';
import 'package:flutter_app/provider/actions/challenge.action.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app/utils/constants.dart';

class ImageService {
  Future<void> uploadImageToServer(
      String filePath, String challengeId, Challenge challenge) async {
    var uri = Uri.parse("http://34.142.196.144:4000/api/images");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll({'Authorization': 'Bearer $token'})
      ..files.add(await http.MultipartFile.fromPath(
        'image',
        filePath,
        contentType: MediaType('image', 'jpg'),
      ));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      print("Response body: ${response.body}");
      print(jsonDecode(response.body.toString())['data']['image']['url']);
      Fluttertoast.showToast(
          msg: "Upload successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          textColor: Colors.white,
          backgroundColor: Colors.green,
          fontSize: 16.0);
      final post = {
        "image": jsonDecode(response.body.toString())['data']['image']['url'],
        "challengeId": challenge.id.toString(),
      };
      print(post['image']);
      print(post['challengeId']);
      // ChallengeActions.doneChallenge(
      //     challengeNotifier, challengeId, postNotifier);
      // PostActions.createPost(postNotifier, post['image'], post['challengeId']);
    } else {
      print("Upload failed with status code: ${response.statusCode}");
      print("Response body: ${response.body}");
    }
  }

  Future<dynamic> predictImage(String url, Challenge challenge) async {
    final response = await http.post(
      Uri.parse('http://34.134.18.179:5000/predict'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{'url': url, "question": challenge.verification},
      ),
    );
    return jsonDecode(response.body);
  }
}
