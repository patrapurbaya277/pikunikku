import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final String auth_token = "token";

//set data into shared preferences like this
  Future<void> setAuthToken(String authToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.auth_token, authToken);
  }

//get value from shared preferences
  Future<String> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String authToken;
    authToken = (pref.getString(this.auth_token) ?? null)!;
    return authToken;
  }

  Future<void> reset() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}