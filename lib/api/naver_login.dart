import 'package:flutter/cupertino.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';

class NaverLogin {
  static Future<String?> login() async {
    try {
      print('네이버 로그인 시도 시작');
      NaverLoginResult res = await FlutterNaverLogin.logIn();
      print('네이버 로그인 시도 완료');

      if (res.status == NaverLoginStatus.loggedIn) {
        NaverAccessToken responseNaver = await FlutterNaverLogin.currentAccessToken;
        print('로그인 성공(NaverAccessToken)= ${responseNaver.accessToken}');
        NaverAccountResult account = res.account;
        print('로그인 성공(account.id)= ' + account.id);

        return responseNaver.accessToken;
      } else {
        print('로그인 실패=' + res.errorMessage);
      }
    } catch (e) {
      print('login Error=' + e.toString());
    }

    return null;
  }

  void logout() async {
    NaverLoginResult res = await FlutterNaverLogin.logOut();
    if (res.status != NaverLoginStatus.loggedIn) {
      print('로그인 아웃= ' + res.status.toString());
    }
  }

  static Future<void> getUserPressed() async {
    FlutterNaverLogin.currentAccount().then((value) {
      if (value.name != null) print('name= ' + value.name);
    }).catchError((e) {
      print('getUserPressed 에러 = ' + e.toString());
    });
  }
}