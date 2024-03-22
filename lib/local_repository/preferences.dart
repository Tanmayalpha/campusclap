import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {

  static final LocalRepository _sharedPre = LocalRepository._internal();

  factory LocalRepository() {
    return _sharedPre;
  }

  LocalRepository._internal();

  //shared keys
  static const isLogin = 'isLogin';
  static const token = 'token';
  static const userData = 'userData';
  static const userEmail = 'userEmail';
  static const userName = 'userName';
  static const userId = 'userId';
  static const userPlaneActiveStatus = 'isPlaneActive';
  static const userProfile = 'userProfile';
  static const language = 'language';
  static const cartListLength = 'cartListLength';
  static const selectedBrand = 'selectedBrand';
  static const selectedCustomer = 'selectedCustomer';
  static const selectedCustomer2 = 'selectedCustomer2';
  static const  offlineCartList = 'offlineCartList';

 static Future<void> setPrefrence(String key, String value) async{
   SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setString(key, value);
  }

  static Future<String?> getPrefrence(String key) async {
   SharedPreferences preference = await SharedPreferences.getInstance();

   return preference.getString(key);
  }

  static Future<void> setPrefrenceBool(String key, bool value) async {
   SharedPreferences preference = await SharedPreferences.getInstance();

   preference.setBool(key, value);
  }

  // setPrefrenceList(String key, String query) async {
  //   List<String> valueList = await getPrefrenceList(key);
  //   if (!valueList.contains(query)) {
  //     if (valueList.length > 4) valueList.removeAt(0);
  //     valueList.add(query);
  //
  //     _sharedPreferences.setStringList(key, valueList);
  //   }
  // }

  // Future<List<String>> getPrefrenceList(String key) async {
  //   return _sharedPreferences.getStringList(key) ?? [];
  // }

  static Future<bool> getPrefrenceBool(String key) async {
   SharedPreferences preference = await SharedPreferences.getInstance();

   return preference.getBool(key) ?? false;
  }

  static Future<void> clearUserSession(BuildContext context) async {
   SharedPreferences preference = await SharedPreferences.getInstance();

   await preference.clear();
  }
}

