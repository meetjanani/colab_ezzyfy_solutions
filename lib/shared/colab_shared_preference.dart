import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model_supabase.dart';
import '../resource/session_string.dart';

Future<UserModelSupabase> getUserModel() async {
  var sharedPreference = await SharedPreferences.getInstance();
  var user = UserModelSupabase(
    id: sharedPreference.getInt(userIdSessionStorage) ?? 0,
    name: sharedPreference.getString(userNameSessionStorage) ?? '',
    mobileNumber: sharedPreference.getString(userMobileNumberSessionStorage) ?? '',
    emailAddress: sharedPreference.getString(userEmailSessionStorage) ?? '',
  );
  user.createAt = sharedPreference.getString(userCreatedAtSessionStorage) ?? '';
  user.isAdmin = sharedPreference.getBool(userIsAdminSessionStorage) ?? false;
  user.profilePictureUrl = sharedPreference.getString(userProfilePictureSessionStorage) ?? '';
  return await user;
}

Future<void> setUserModel(UserModelSupabase userModelSupabase) async {
  var sharedPreference = await SharedPreferences.getInstance();
  sharedPreference.setInt(userIdSessionStorage, userModelSupabase.id);
  sharedPreference.setString(userNameSessionStorage, userModelSupabase.name);
  sharedPreference.setString(userEmailSessionStorage, userModelSupabase.emailAddress);
  sharedPreference.setString(userCreatedAtSessionStorage, userModelSupabase.createAt);
  sharedPreference.setString(userMobileNumberSessionStorage, userModelSupabase.mobileNumber);
  sharedPreference.setBool(userIsAdminSessionStorage, userModelSupabase.isAdmin);
  sharedPreference.setString(userProfilePictureSessionStorage, userModelSupabase.profilePictureUrl);
}

Future<String> getColabUserName() async {
  var sharedPreference = await SharedPreferences.getInstance();
  return sharedPreference.getString('userName') ?? "";
}

Future<String> getColabKey(String key) async {
  var sharedPreference = await SharedPreferences.getInstance();
  return await sharedPreference.getString(key) ?? '';
}

Future<void> setColabKey(String key, String value) async {
  var sharedPreference = await SharedPreferences.getInstance();
  sharedPreference.setString(key, value);
}
