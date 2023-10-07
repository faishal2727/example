import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepostory {
  Future<String> getToken() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    final result = prefs.get("token");

    if (result == null) {
      throw Exception("Token not found");
    }

    return result.toString();
  }

  Future<void> setToken(String token) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("token", token);
  }

  Future<void> removeToken() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("token");
  }

  Future<bool> isLoggedIn() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    final result = await prefs.get("token");
    debugPrint("adung 1 $result");

    if (result == null) {
      return false;
    }

    return true;
  }
}
