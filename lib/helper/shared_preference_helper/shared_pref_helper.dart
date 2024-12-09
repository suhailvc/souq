import 'dart:convert';

import 'package:atobuy_vendor_flutter/data/response_models/auth/user_model.dart';
import 'package:atobuy_vendor_flutter/utils/pref_keys.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  final SharedPreferences _sharedPreference = Get.find<SharedPreferences>();

  // General Methods: ----------------------------------------------------------
  Future<void> saveIsRememberMe(final bool isRememberMe) async {
    await _sharedPreference.setBool(PrefKeys.isRememberMe, isRememberMe);
  }

  bool? get isRememberMe {
    return _sharedPreference.getBool(PrefKeys.isRememberMe);
  }

  Future<void> saveAuthToken(final String authToken) async {
    await _sharedPreference.setString(PrefKeys.authToken, authToken);
  }

  String get authToken {
    return _sharedPreference.getString(PrefKeys.authToken) ?? '';
  }

  Future<void> saveUser(final UserModel user) async {
    await _sharedPreference.setString(PrefKeys.user, jsonEncode(user.toJson()));
  }

  UserModel? get user {
    final String? userPref = _sharedPreference.getString(PrefKeys.user);
    if (userPref != null && userPref.isNotEmpty) {
      return UserModel.fromJson(jsonDecode(userPref));
    }
    return null;
  }

  Future<void> saveFcmToken(final String fcmToken) async {
    await _sharedPreference.setString(PrefKeys.fcmToken, fcmToken);
  }

  String? get fcmToken {
    return _sharedPreference.getString(PrefKeys.fcmToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(PrefKeys.authToken);
  }

  Future<void> setIsFirstTime(final bool isFirstTime) async {
    await _sharedPreference.setBool(PrefKeys.isFirstTime, isFirstTime);
  }

  bool get getIsFirstTime {
    return _sharedPreference.getBool(PrefKeys.isFirstTime) ?? true;
  }

  // Login:---------------------------------------------------------------------
  Future<void> saveIsLoggedIn(final bool value) async {
    await _sharedPreference.setBool(PrefKeys.isLoggedIn, value);
  }

  bool get isLoggedIn {
    return _sharedPreference.getBool(PrefKeys.isLoggedIn) ?? false;
  }

  Future<void> saveEmail(final String email) async {
    await _sharedPreference.setString(PrefKeys.rememberEmail, email);
  }

  String get email {
    return _sharedPreference.getString(PrefKeys.rememberEmail) ?? '';
  }

  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(PrefKeys.isDarkMode) ?? false;
  }

  Future<void> changeBrightnessToDark(final bool value) async {
    await _sharedPreference.setBool(PrefKeys.isDarkMode, value);
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference.getString(PrefKeys.currentLanguage) ?? 'en';
  }

  Future<void> changeLanguage(final String language) async {
    await _sharedPreference.setString(PrefKeys.currentLanguage, language);
  }

  String? get getInitialRoute {
    return _sharedPreference.getString(PrefKeys.initialRoute);
  }

  Future<void> setInitialRoute(final String initialRoute) async {
    await _sharedPreference.setString(PrefKeys.initialRoute, initialRoute);
  }

  String get getUserPassword {
    return _sharedPreference.getString(PrefKeys.rememberPassword) ?? '';
  }

  Future<void> setUserPassword(final String value) async {
    await _sharedPreference.setString(PrefKeys.rememberPassword, value);
  }

  Future<void> clear() async {
    final List<String> arrKeysToKeep = <String>[
      PrefKeys.isRememberMe,
      PrefKeys.rememberEmail,
      PrefKeys.rememberPassword,
      PrefKeys.languageCode,
      PrefKeys.currentLanguage
    ];

    final Set<String>? keys = _sharedPreference.getKeys();
    if (keys != null) {
      for (String key in keys.toList()) {
        if (!arrKeysToKeep.contains(key)) {
          _sharedPreference.remove(key);
        }
      }
    }
  }

  Future<void> setCurrency(final String value) async {
    await _sharedPreference.setString(PrefKeys.currency, value);
  }

  String getCurrency() {
    return _sharedPreference.getString(PrefKeys.currency) ?? 'SR';
  }

  //Language Code
  Future<void> setLanguageCode(final String value) async {
    await _sharedPreference.setString(PrefKeys.languageCode, value);
  }

  String get getLanguageCode {
    return _sharedPreference.getString(PrefKeys.languageCode) ?? 'en';
  }

  Future<void> setCountryCode(final String value) async {
    await _sharedPreference.setString(PrefKeys.countryCode, value);
  }

  String get getCountryCode {
    return _sharedPreference.getString(PrefKeys.countryCode) ?? 'US';
  }

  Future<void> setKYCToken(final String value) async {
    await _sharedPreference.setString(PrefKeys.kycToken, value);
  }

  String getKYCToken() {
    return _sharedPreference.getString(PrefKeys.kycToken) ?? '';
  }

  Future<void> saveIsKycVerify(final bool isKycVerify) async {
    await _sharedPreference.setBool(PrefKeys.isKycVerify, isKycVerify);
  }

  bool? get isKycVerify {
    return _sharedPreference.getBool(PrefKeys.isKycVerify);
  }

  Future<void> saveSelectedStore(final int storeId) async {
    await _sharedPreference.setInt(PrefKeys.storeId, storeId);
  }

  int? get selectedStoreId {
    return _sharedPreference.getInt(PrefKeys.storeId);
  }
}
