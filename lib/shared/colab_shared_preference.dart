import 'package:shared_preferences/shared_preferences.dart';

Future<String> getColabSharedPreference(String key) async {
  var sharedPreference = await SharedPreferences.getInstance();
  return sharedPreference.getString(key) ?? "";
}

Future<void> setColabSharedPreference(String key,String value) async {
  var sharedPreference = await SharedPreferences.getInstance();
  sharedPreference.setString(key, value);
}

Future<String> getColabUserName() async {
  var sharedPreference = await SharedPreferences.getInstance();
  return sharedPreference.getString('userName') ?? "";
}
