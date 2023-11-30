import 'package:flutter_app/provider/notifiers/auth.notifier.dart';
import 'package:flutter_app/services/auth.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthActions {
  static Future<Map<String, dynamic>> login(
      AuthNotifier notifier, String email, String password) async {
    try {
      Map<String, dynamic> response =
          await AuthService().login(email, password);

      if (response["errors"]) {
        return response;
      } else {
        Map<String, dynamic> user = response["user"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("userId", user["_id"]);
        notifier.setUser(user);
        notifier.isLogged = true;
        return response;
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> register(
      AuthNotifier notifier, String name, String email, String password) async {
    try {
      // Map<String, dynamic> user =
      return await AuthService().register(name, email, password);
      // notifier.setUser(user);
      // notifier.isLogged = true;
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> logout(AuthNotifier notifier) async {
    try {
      notifier.setUser({});
      notifier.isLogged = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("userId");
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> checkAuth(AuthNotifier notifier) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString("userId") != null) {
        Map<String, dynamic> user =
            await AuthService().getUser(prefs.getString("userId")!);
        notifier.setUser(user);
        notifier.isLogged = true;
      } else {
        notifier.setUser({});
        notifier.isLogged = false;
      }
    } catch (error) {
      rethrow;
    }
  }
}
