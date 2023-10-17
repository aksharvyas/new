import 'dart:convert';
import 'dart:developer';


import 'package:fitness_ble_app/src/app/screen/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;
  static Future<LocalStorageService?> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  static onLogout() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    shared_User.remove(PREF_USER);
    shared_User.remove(PREF_TOKEN);
    shared_User.remove(SearchPostCode);
    shared_User.clear();
    SharedPref sharedPref = SharedPref();
    sharedPref.remove(exploreScreenCategory);
  }

  static final String name = "defaultName";
  static final String PREF_USER = "user";
  static final String PREF_TOKEN = "token";
  static final String PREF_PHOTO_URL = "token";
  static final String PREF_IS_FIRST_TIME = "isFirstTime";



  static final String SearchPostCode = "searchPostcode";
  static final String exploreScreenCategory = "exploreScreenCategory";






  static Future<bool> setUser(Map<String, dynamic> jsonString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(" useer   ${jsonEncode(jsonString)}");
    String user = jsonEncode(LoginUserData.fromJson(jsonString));
    return prefs.setString(PREF_USER, user);
  }

  static Future<LoginUserData?> getUser() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    String userStr = shared_User.getString(PREF_USER).toString();
    if (userStr != null) {
      Map<String, dynamic> userMap = (await jsonDecode(shared_User.getString(PREF_USER)!));
      LoginUserData user = LoginUserData.fromJson(userMap);
      return user;
    } else {
      return null;
    }
  }

  /// ----------------------------------------------------------
  /// Method that saves the user language code
  /// ----------------------------------------------------------
  static Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    log("token value set value :- $value");
    return prefs.setString(PREF_TOKEN, value);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(PREF_TOKEN) ?? null;
  }
  static Future<bool> setPhotoUrl(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(PREF_PHOTO_URL, value);
  }

  static Future<String?> getPhotoUrl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PREF_PHOTO_URL) ?? null;
  }

  static Future<bool> setIsFirstTime(bool isFirstTime) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(PREF_IS_FIRST_TIME, isFirstTime);
  }

  static Future<bool?> getIsFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PREF_IS_FIRST_TIME);
  }


/// ----------------------------------------------------------
/// Method that use for firebase chat messaging (inboxScreen)
/// ----------------------------------------------------------

  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserIDKey = "USERIDKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";

  /// saving data to sharedpreference
  static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserIDKey, userName);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  /// fetching data from sharedpreference

  static Future<bool?> getUserLoggedInSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String?> getUserNameSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserIDKey);
  }

  static Future<String?> getUserEmailSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserEmailKey);
  }

  static final String lastScreenName = "LastScreenName";
  static Future<bool> setLastScreen(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(lastScreenName, value);
  }

  static Future<String?> getLastScreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(lastScreenName) ?? null;
  }


}

///https://medium.com/better-programming/flutter-how-to-save-objects-in-sharedpreferences-b7880d0ee2e4

/// save filter category and object value explore category and search selection tab

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key)!);
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint("save key $key value $value");
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}