import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final String tokenAuth = "token";

//set data into shared preferences like this
  setAuthToken(String authToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.tokenAuth, authToken);
  }

//get value from shared preferences
  Future<String> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String authToken;
    authToken = (pref.getString(this.tokenAuth) ?? null).toString();
    return authToken;
  }

  Future<void> reset() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}