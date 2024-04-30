import 'package:Deal_Connect/Utils/custom_dialog.dart';
import 'package:Deal_Connect/api/apple_login.dart';
import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/api/google_login.dart';
import 'package:Deal_Connect/api/kakao_login.dart';
import 'package:Deal_Connect/api/naver_login.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/model/login_response_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:shared_preferences/shared_preferences.dart';

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


  _snsLogin(String site, String accessToken) {
    CustomDialog.showProgressDialog(context);
    postSnsLogin({
      'site': site,
      'token': accessToken,
    }).then((response) {
      CustomDialog.dismissProgressDialog();
      if (response.status == 'success') {
        LoginResponseData loginResponseData = LoginResponseData.fromJSON(
            response.data);

        CustomDialog.showProgressDialog(context);
        initLoginUserData(
            loginResponseData.user,
            loginResponseData.tokenType,
            loginResponseData.accessToken
        ).then((result) {
          CustomDialog.dismissProgressDialog();
          Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
        });
      } else if (response.status == 'register') {
        Map<String, dynamic> updatedData = Map.from(response.data);
        updatedData['site'] = site;
        updatedData['token'] = accessToken;
        Navigator.pushNamed(context, '/sns_register', arguments: updatedData);
      } else {
        print(response.message);
        CustomDialog.showServerValidatorErrorMsg(response);
      }
    });
  }

  _setTempSnsLoginData(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('tempSnsLoginData', data.toString());
  }


  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: WillPopScope(
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
                                fontSize: 28.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'NotoSans'
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text(
                              '로그인 방법을 선택하여 주세요.',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: BODY_TEXT_COLOR,
                                fontFamily: 'NotoSans'
                              ),
                            ),
                          ),
                          _UserIdLogin(context),
                          SizedBox(
                            height: 15.0,
                          ),
                          _SnsLine(),
                          _SnsList(),
                          _JoinBtn(context),
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
      ),
    );
  }

  Row _JoinBtn(BuildContext context) {
    final textStyle = TextStyle(
      color: BODY_TEXT_COLOR,
      fontWeight: FontWeight.w400,
      fontSize: 13.0,
      fontFamily: 'NotoSans'
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register/terms');
          },
          child: Text(
            '회원가입',
            style: textStyle,
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/find');
            },
            child: Text(
              '비밀번호 찾기',
              style: textStyle,
            ))
      ],
    );
  }

  Padding _SnsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSnsIcons(
            imagePath: 'kakao_talk',
            iconColor: HexColor('#ffe500'),
            onTap: () async {
              print('카카오톡');
              KakaoLogin.loginWithKakaoAccountReturnToken().then((accessToken) {
                print('토큰'+ accessToken.toString());
                if (accessToken != null) {
                  _snsLogin('kakao', accessToken);
                }
              });
            },
          ),
          _buildSnsIcons(
            imagePath: 'naver',
            iconColor: HexColor('#2db400'),
            onTap: () {
              print('네이버');
              NaverLogin.login().then((accessToken) {
                if (accessToken != null) {
                  _snsLogin('naver', accessToken);
                }
              });
            },
          ),
          _buildSnsIcons(
            imagePath: 'google',
            iconColor: HexColor('#e24939'),
            onTap: () {
              print('구글');
              GoogleLogin.login().then((accessToken) {
                if (accessToken != null) {
                  _snsLogin('google', accessToken);
                }
              });
            },
          ),
          foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS
              ? _buildSnsIcons(
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
                    AppleLogin.signInWithApple().then((accessToken) {
                      print('apple login result accessToken: $accessToken');

                      if (accessToken != null) {
                        _snsLogin('apple', accessToken);
                      }
                    });
                  },
                )
              : Container(),
        ],
      ),
    );
  }

  Container _SnsLine() {
    return Container(
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
              '또는 아래 SNS 로그인/회원가입',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: HexColor('#777777'), fontWeight: FontWeight.w400, fontFamily: 'NotoSans'),
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
    );
  }

  Container _UserIdLogin(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/login/userId');
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 13,
            horizontal: 35,
          ),
          decoration: BoxDecoration(
            color: HexColor('#75a8e4'),
            borderRadius: BorderRadius.circular(5),
          ),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 25,
                height: 25,
                child: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Text(
                  '아이디 로그인',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'NotoSans'
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
