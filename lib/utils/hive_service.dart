import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scanguard/models/auth_model.dart';

class HiveService {
  HiveService._providerConstructor();
  static final HiveService instance = HiveService._providerConstructor();

  Future<Box> get box async {
    return await Hive.openBox('UserSession');
  }

  static Future<void> saveUserInfo(AuthModel user) async {
    Box box = await instance.box;
    String userJson = jsonEncode(user.toJson()); // Convert user to JSON string
    box.put('userDetails', userJson);
    if (kDebugMode) {
      print("Saved: $userJson");
    }
  }

  static Future getUserProfile() async {
    Box box = await instance.box;
    var userprofile = await box.get('userDetails');
    if (userprofile == null) {
      return null; // Return null if there is no user data
    }

    Map<String, dynamic> userMap = jsonDecode(userprofile);
    AuthModel user = AuthModel.fromJson(userMap);
    return user.user;
  }

  Future<void> saveLanguageToHive(String languageCode, String languageValue,
      String fullLanguageName) async {
    Box box = await instance.box;
    await box.put('language_code', languageCode);
    await box.put('language_value', languageValue);
    await box.put('language_Name', fullLanguageName);
    if (kDebugMode) {
      print('Language saved $languageCode $languageValue');
    }
  }

//verification
  static Future<String> checkVerificationStatus() async {
    Box box = await instance.box;
    var userJson = box.get('userDetails');
    if (userJson == null) return '';
    Map<String, dynamic> userMap = jsonDecode(userJson);
    AuthModel user = AuthModel.fromJson(userMap);
    if (user.user!.email!.isNotEmpty) {
      return 'verified';
    } else {
      return '';
    }
  }

//Sign Out
  static Future signOut() async {
    Box box = await instance.box;
    box.delete('userDetails');
    if (kDebugMode) {
      print("check ${await box.get('userDetails')}");
    }
  }
}
