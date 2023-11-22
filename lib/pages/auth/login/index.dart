import 'dart:math';

import 'package:DealConnect/Utils/custom_dialog.dart';
import 'package:DealConnect/api/auth.dart';
import 'package:DealConnect/components/const/setting_colors.dart';
import 'package:DealConnect/model/login_response_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/foundation.dart' as foundation;

class LoginIndex extends StatefulWidget {
  @override
  LoginIndexState createState() => new LoginIndexState();
}

class LoginIndexState extends State<LoginIndex> {
  // bool _isKakaoTalkInstalled = false;

  @override
  void initState() {
    // KakaoLogin.initKakaoTalkInstalled().then((result) {
    //   setState(() {
    //     _isKakaoTalkInstalled = result;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding:
                EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 50),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/intro', (route) => false);
                            },
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: MediaQuery.of(context).size.width / 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Text(
                            '환영합니다',
                            style: TextStyle(
                                fontSize: 28.0, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(
                            '로그인 계정 방법을 선택하여 주세요.\n오늘도 좋은하루 보내세요.',
                            style: TextStyle(fontSize: 14.0,color: BODY_TEXT_COLOR,),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login/email');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 35),
                              decoration: BoxDecoration(
                                color: HexColor('#75a8e4'),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: Image.asset(
                                        'assets/images/icons/login_email_icon.png'),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '이메일로 로그인',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        height: 1,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        Container(
                          margin: EdgeInsets.only(top: 15, bottom: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: HexColor('#eeeeee'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  '또는 아래 SNS 로그인',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: HexColor('#777777')),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: HexColor('#eeeeee'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildSnsIcons(
                                imagePath: 'kakao_talk',
                                iconColor: HexColor('#ffe500'),
                                onTap: () {
                                  print('카카오톡');
                                  // if (_isKakaoTalkInstalled) {
                                  //   KakaoLogin.loginWithTalk().then((accessToken) {
                                  //     if (accessToken != null) {
                                  //       _snsLogin('kakao', accessToken);
                                  //     }
                                  //   });
                                  // } else {
                                  // KakaoLogin.loginWithKakao().then((accessToken) {
                                  //   if (accessToken != null) {
                                  //     _snsLogin('kakao', accessToken);
                                  //   }
                                  // });
                                  // }
                                },
                              ),
                              _buildSnsIcons(
                                imagePath: 'naver',
                                iconColor: HexColor('#2db400'),
                                onTap: () {
                                  print('네이버');
                                  // NaverLogin.login().then((accessToken) {
                                  //   if (accessToken != null) {
                                  //     _snsLogin('naver', accessToken);
                                  //   }
                                  // });
                                },
                              ),
                              _buildSnsIcons(
                                imagePath: 'google',
                                iconColor: HexColor('#e24939'),
                                onTap: () {
                                  print('구글');
                                  // GoogleLogin.login().then((accessToken) {
                                  //   if (accessToken != null) {
                                  //     _snsLogin('google', accessToken);
                                  //   }
                                  // });
                                },
                              ),
                              foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS ?
                              _buildSnsIcons(
                                imagePath: 'apple',
                                iconColor: HexColor('#000000'),
                                onTap: () {
                                  print('Apple로 로그인');
                                  // AppleLogin.login().then((accessToken) {
                                  //   print('apple login result accessToken: $accessToken');
                                  //
                                  //   if (accessToken != null) {
                                  //     _snsLogin('apple', accessToken);
                                  //   }
                                  // });
                                  // AppleLogin.signInWithApple().then((accessToken) {
                                  //   print('apple login result accessToken: $accessToken');
                                  //
                                  //   if (accessToken != null) {
                                  //     _snsLogin('apple', accessToken);
                                  //   }
                                  // });
                                },
                              ) : Container(),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () =>
                              ({Navigator.pushNamed(context, '/register')}),
                              child: Text(
                                '회원가입',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/find/pw/step01');
                                },
                                child: Text(
                                  '비밀번호 찾기',
                                  style: TextStyle(color: Colors.black),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/intro', (route) => false);

        return false;
      },
    );
  }

  GestureDetector _buildSnsIcons({
    required String imagePath,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: iconColor,
        ),
        child: Center(
          child: Image.asset(
            'assets/images/icons/login_${imagePath}_icon.png',
            scale: 2,
          ),
        ),
      ),
    );
  }
}
