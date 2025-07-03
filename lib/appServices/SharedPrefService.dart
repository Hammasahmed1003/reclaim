import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const _keyId = "user_id";
  static const _keyEmail = "user_email";
  static const _keyToken = "auth_token";
  static const _keyDeviceToken = "device_token";
  static const _keyName = "profile_name";
  static const _keyGender = "profile_gender";
  static const _keyImage = "profile_image";

  static Future<void> saveUserData(
      {required String id,
      required String email,
      required String deviceToken,
      required String token,
      required String Name,
      required String image,
      required String gender}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyId, id);
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyDeviceToken, deviceToken);
    await prefs.setString(_keyToken, token);
    await prefs.setString(_keyName, Name);
    await prefs.setString(_keyGender, gender);
    await prefs.setString(_keyImage, image);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyId);
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyName);
  }

  static Future<String?> getUserImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyImage);
  }

  static Future<String?> getUserGender() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyGender);
  }

  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  static Future<String?> getDeviceToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyDeviceToken);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  //for updates the Value(),

  static Future<void> updateUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
  }

  static Future<void> updateUserGender(String gender) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyGender, gender);
  }

  static Future<void> updateUserImage(String image) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyImage, image);
  }

  // for evening reclaim button

 static Future<void> saveLastRecollectDate(String date) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('lastRecollectDate', date);
}

static Future<String?> getLastRecollectDate() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('lastRecollectDate');
}
  
}
