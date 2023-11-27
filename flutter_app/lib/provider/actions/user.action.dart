import 'package:flutter_app/services/user.service.dart';

class UserActions {
  static Future<void> updateUser( dynamic body) async {
    try {
      await UserService().updateUser(body);
    } catch (error) {
      rethrow;
    }
  }
}
