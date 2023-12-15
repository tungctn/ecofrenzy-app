import 'package:flutter_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/post.dart';

class VoucherService {
  Future<List<dynamic>> fetchVouchers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse(
            'https://api.bloggiamgia.vn/api/b/Voucher/home-shopee?offer=shopee&page=1&pageSize=10'),
        headers: <String, String>{
          'Authorization': 'Bearer ${prefs.getString('token')}',
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List vouchersJson = jsonResponse['data'];
      return vouchersJson;
    } else {
      throw Exception('Failed to load vouchers');
    }
  }

  Future<List<dynamic>> fetchVouchersCategory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse(
            'https://api.bloggiamgia.vn/api/amusement/categories?isNotChildren=true&pageSize=999'),
        headers: <String, String>{
          'Authorization': 'Bearer ${prefs.getString('token')}',
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List vouchersCategoryJson = jsonResponse['data'];
      return vouchersCategoryJson;
    } else {
      throw Exception('Failed to load vouchers');
    }
  }
}
