import 'package:Deal_Connect/Utils/custom_dialog.dart';
import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/custom/custom_text_form_field.dart';
import 'package:Deal_Connect/model/login_response_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class UserIdLogin extends StatefulWidget{
  @override
  UserIdLoginState createState() => new UserIdLoginState();
}

class UserIdLoginState extends State<UserIdLogin>{
  String? user_id;
  String? password;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        backgroundColor: HexColor('#75a8e4'),
        body: _UserIdLoginForm(context),
      ),
    );
  }

  SafeArea _UserIdLoginForm(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontFamily: 'NotoSans'
    );

    return SafeArea(
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 0, bottom: 20.0),
                    child: Text(
                      '로그인',
                      style: SettingStyle.NORMAL_TEXT_STYLE.copyWith(
                        fontSize: 30.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                  Text(
                    'Deal+Connect 서비스 이용을 위하여 회원님의\아이디를 입력 해주세요',
                    style: SettingStyle.NORMAL_TEXT_STYLE.copyWith(
                      color: Colors.white
                    ),
                  ),
                  SizedBox(height: 40.0,),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      child: LoginTextFormField(
                        icon: Icons.person_outline,
                        labelText: '아이디를 입력하세요',
                        onChanged: (val) {
                          setState(() {
                            user_id = val;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: LoginTextFormField(
                      icon: Icons.lock,
                      labelText: '비밀번호를 입력하세요',
                      isPassword: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    CustomDialog.showProgressDialog(context);

                    postLogin({
                      'user_id': user_id,
                      'password': password
                    }).then((value) {
                      CustomDialog.dismissProgressDialog();

                      if (value.status == 'success') {
                        LoginResponseData loginResponseData = LoginResponseData.fromJSON(value.data);

                        initLoginUserData(
                            loginResponseData.user,
                            loginResponseData.tokenType,
                            loginResponseData.accessToken
                        ).then((result) {
                          if (!(loginResponseData.user.is_active)) {
                            Navigator.pushNamedAndRemoveUntil(context, '/auth/withdraw', (r) => false);
                          } else {
                            refreshFcmToken().then((value) {});
                            if (loginResponseData.user.is_agree_app_notification) {
                              FirebaseMessaging.instance.subscribeToTopic('all')
                                  .then((_) {
                                print('사용자가 all 토픽을 구독하였습니다.');
                              });
                            }
                            if (loginResponseData.user.is_agree_app_marketing) {
                              FirebaseMessaging.instance.subscribeToTopic('marketing')
                                  .then((_) {
                                print('사용자가 marketing 토픽을 구독하였습니다.');
                              });
                            }
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/home', (r) => false);
                          }
                        });
                      } else {
                        CustomDialog.showServerValidatorErrorMsg(value);
                      }
                    });
                  },
                  child: const Text('로그인',style: SettingStyle.NORMAL_TEXT_STYLE,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}