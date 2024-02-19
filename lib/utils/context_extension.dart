import 'package:Deal_Connect/Utils/shared_pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension ContextExtensions on BuildContext {
  Future<void> logoutAndRedirectToIntro() async {
    // 토큰 초기화
    bool tokenCleared = await SharedPrefUtils.clearAccessToken();
    // 사용자 정보 초기화
    bool userCleared = await SharedPrefUtils.clearUser();

    if (tokenCleared && userCleared) {
      // 초기화 성공 시, '/intro'로 리다이렉션
      Navigator.of(this).pushNamedAndRemoveUntil('/intro', (Route<dynamic> route) => false);
    } else {
      // 초기화 실패 시, 오류 메시지 표시
      Fluttertoast.showToast(msg: "로그아웃 실패. 다시 시도해주세요.");
    }
  }
}