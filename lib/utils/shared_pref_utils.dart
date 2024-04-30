import 'dart:convert';

import 'package:Deal_Connect/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  static String prefKeyAccessToken = 'access_token';
  static String prefKeyUser = 'user';
  static String prefKeyUserType = 'user_type';
  static String prefKeyFcmToken = 'fcm_token';
  static String prefKeySearchKeyword = 'search_keyword';
  static String prefKeySearchPartner = 'search_partner';
  static String prefKeyDivider = '|xXx|';

  static String userTypeNormal = '일반회원';

  static Future<bool> setAccessToken(String tokenType, String accessToken) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(prefKeyAccessToken, tokenType + ' ' + accessToken);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String?> getAccessToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(prefKeyAccessToken);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> clearAccessToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(prefKeyAccessToken);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // print("setUser @@@@@@@@@@@ " + jsonEncode(user));
      prefs.setString(prefKeyUser, jsonEncode(user));
      return true;
    } catch (e) {
      print('setUserError@@@' + e.toString());
      return false;
    }
  }

  static Future<bool> clearUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(prefKeyUser);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<User?> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? userStr = prefs.getString(prefKeyUser);
      // print("getUser@@@@@@@@@@@@@@" + jsonDecode(userStr!));
      return userStr != null ? User.fromJSON(jsonDecode(userStr)) : null;
    } catch (e) {
      print('getUserError@@@' + e.toString());
      return null;
    }
  }

  static Future<bool> setUserType(String userType) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(prefKeyUserType, userType);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String> getUserType() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userType = prefs.getString(prefKeyUserType);
      return userType ?? userTypeNormal;
    } catch (e) {
      return userTypeNormal;
    }
  }


  static Future<bool> addSearchKeyword(String searchKeyword) async {
    try {
      await removeSearchKeyword(searchKeyword);

      final prefs = await SharedPreferences.getInstance();
      final savedStr = prefs.getString(prefKeySearchKeyword);
      String saveStr = searchKeyword;
      if (savedStr != null && savedStr.isNotEmpty) {
        saveStr += prefKeyDivider + savedStr;
      }
      prefs.setString(prefKeySearchKeyword, saveStr);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<String>> getSearchKeyword() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedStr = prefs.getString(prefKeySearchKeyword);
      List<String> resultList = [];
      if (savedStr != null) {
        resultList.addAll(savedStr.split(prefKeyDivider));
      }
      return resultList;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> removeSearchKeyword(String keyword) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> savedKeywords = await getSearchKeyword();

      String saveStr = '';
      for (var value in savedKeywords) {
        if (value != keyword) {
          if (saveStr.isNotEmpty) {
            saveStr += prefKeyDivider;
          }
          saveStr += value;
        }
      }
      prefs.setString(prefKeySearchKeyword, saveStr);

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> clearSearchKeyword() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(prefKeySearchKeyword);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> addSearchPartner(String partnerId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedStr = prefs.getString(prefKeySearchPartner);
      List<String> partnerIds = savedStr != null ? savedStr.split(prefKeyDivider) : [];
      partnerIds.remove(partnerId);
      partnerIds.insert(0, partnerId);
      if (partnerIds.length > 10) {
        partnerIds = partnerIds.take(10).toList();
      }
      // 저장
      prefs.setString(prefKeySearchPartner, partnerIds.join(prefKeyDivider));
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<String>> getSearchPartner() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedStr = prefs.getString(prefKeySearchPartner);
      List<String> resultList = [];
      if (savedStr != null) {
        resultList.addAll(savedStr.split(prefKeyDivider));
      }
      return resultList;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> removeSearchPartner(String keyword) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> savedPartners = await getSearchPartner();

      String saveStr = '';
      for (var value in savedPartners) {
        if (value != keyword) {
          if (saveStr.isNotEmpty) {
            saveStr += prefKeyDivider;
          }
          saveStr += value;
        }
      }
      prefs.setString(prefKeySearchPartner, saveStr);

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> clearSearchPartner() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(prefKeySearchPartner);
      return true;
    } catch (e) {
      return false;
    }
  }

}
