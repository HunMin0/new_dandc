import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoLogin {
  void _getUserInfo() async {
    try {
      User user = await UserApi.instance.me();
      print(user.toString());
      print(
          '사용자 정보 요청 성공: 회원번호: ${user.id}, 닉네임: ${user.kakaoAccount?.profile
              ?.nickname}');
    } catch (error) {
      print('사용자 정보 요청 실패: $error');
    }
  }

  Future<String?> signInWithKakao() async {
    if (await AuthApi.instance.hasToken()) {
      try {
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
        print('토큰 유효성 체크 성공: ${tokenInfo.id} ${tokenInfo.expiresIn}');
        _getUserInfo();
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          print('토큰 만료: $error');
        } else {
          print('토큰 정보 조회 실패: $error');
        }

        await loginWithKakaoAccount();
      }
    } else {
      print('발급된 토큰 없음');
      await loginWithKakaoAccount();
    }
  }

  Future<void> loginWithKakaoAccount() async {
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공: ${token.accessToken}');

        _getUserInfo();
      } catch (error) {
        print('카카오톡으로 로그인 실패: $error');

        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        await _loginWithKakaoAccountFallback();
      }
    } else {
      await _loginWithKakaoAccountFallback();
    }
  }

  static Future<String?> _loginWithKakaoAccountFallback() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공: ${token.accessToken}');
      return token.accessToken;
    } catch (error) {
      print('카카오계정으로 로그인 실패: $error');
      return null;
    }
  }


  static Future<String?> loginWithKakaoAccountReturnToken() async {
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공: ${token.accessToken}');

        return token.accessToken;
        // _getUserInfo();
      } catch (error) {
        print('카카오톡으로 로그인 실패: $error');


        // if (error is PlatformException && error.code == 'CANCELED') {
        //   return;
        // }
        return await _loginWithKakaoAccountFallback();
      }
    } else {
      return await _loginWithKakaoAccountFallback();
    }
  }
}