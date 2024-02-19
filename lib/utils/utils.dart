import 'package:Deal_Connect/api/server_config.dart';
import 'package:Deal_Connect/model/file.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as IMG;
import 'dart:io' as IO;

class Utils {

// 로그인 정보 초기화 후 '/intro'로 리다이렉션하는 함수
  Future<void> logoutAndRedirectToIntro(BuildContext context) async {
    // 토큰 초기화
    bool tokenCleared = await SharedPrefUtils.clearAccessToken();
    // 사용자 정보 초기화
    bool userCleared = await SharedPrefUtils.clearUser();

    if (tokenCleared && userCleared) {
      // 초기화 성공 시, '/intro'로 리다이렉션
      Navigator.of(context).pushNamedAndRemoveUntil('/intro', (Route<dynamic> route) => false);
    } else {
      // 초기화 실패 시, 오류 메시지 표시
      Fluttertoast.showToast(msg: "로그아웃 실패. 다시 시도해주세요.");
    }
  }

  static String parsePrice(int price) {
    String resultStr = '';
    if (price >= 10000) {
      resultStr += NumberFormat('###,###,###.##').format(price / 10000) + '만원';
    } else {
      resultStr += NumberFormat('###,###,###').format(price) + '원';
    }

    return resultStr;
  }

  static String moneyGenerator(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 10000).toStringAsFixed(1)}만원";
    } else if (num > 999999 && num < 9999999) {
      return "${(num / 1000000).toStringAsFixed(0)}백만원";
    } else if (num > 9999999 && num < 99999999) {
      return "${(num / 10000000).toStringAsFixed(1)}천만원";
    } else if (num >= 99999999) {
      return "${(num / 100000000).toStringAsFixed(1)}억원";
    } else {
      return "$num원";
    }
  }

  static void unFocus(BuildContext context) {
    var currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static String daysToYearGenerator(int days) {
    int tempDays = days % 30;
    int month = (days / 30).floor();
    int tempMonth = month % 12;
    int year = (month / 12).floor();

    String result = '';
    if (year > 0) {
      result += '$year년';
    }
    if (tempMonth > 0) {
      if (result.isNotEmpty) {
        result += ' ';
      }
      result += '$tempMonth개월';
    }
    if (tempDays > 0) {
      if (result.isNotEmpty) {
        result += ' ';
      }
      result += '$tempDays일';
    }

    return result;
  }

  static String getImageFilePath(File file) {
    String? mobilePath;
    if (file.mobile_hash_name != null) {
      mobilePath = ServerConfig.SERVER_MOBILE_STORAGE_URL + file.mobile_hash_name!;
    } else {
      mobilePath = ServerConfig.SERVER_STORAGE_URL + file.hash_name;
    }

    return mobilePath;
  }

  static List<int> encodeResizedImage(String path, {int resizeMaxWidth = 600}) {
    IMG.Image tempImage = IMG.decodeImage(IO.File(path).readAsBytesSync())!;
    IMG.Image resizedTempImage = IMG.copyResize(
      tempImage,
      width: 600,
    );
    return IMG.encodeJpg(resizedTempImage);
  }
}