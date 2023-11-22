import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:DealConnect/components/const/data.dart';
import 'package:DealConnect/components/custom/custom_text_form_field.dart';
import 'package:DealConnect/components/layout/default_layout.dart';
import 'package:DealConnect/components/const/setting_colors.dart';
import 'package:DealConnect/pages/home_index.dart';

/*
  참고용~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  추후 삭제~~~~~~~~~~~~~~~~~~~~~~~~~~
  참고용~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  추후 삭제~~~~~~~~~~~~~~~~~~~~~~~~~~
  참고용~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  추후 삭제~~~~~~~~~~~~~~~~~~~~~~~~~~
  참고용~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  추후 삭제~~~~~~~~~~~~~~~~~~~~~~~~~~
  참고용~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  추후 삭제~~~~~~~~~~~~~~~~~~~~~~~~~~
*/


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {

    final dio = Dio();

    // localhost
    final emulatorIp = '10.0.2.2:3000'; // 안드로이드 네트워크 기본ip
    final simulatorIp = '127.0.0.1:3000'; // ios 네트워크 기본ip

    final ip = Platform.isIOS ? simulatorIp : emulatorIp; // 플랫폼에 따라 ip변경

    return DefaultLayout(
      child: SingleChildScrollView( // 키보드판 가리는 영역제한으로 스크롤이 가능하도록 지정
        // manual(기본) / onDrag 스크롤시 사라지도록 처리
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Image.asset('assets/images/logo.png',
                    width: MediaQuery.of(context).size.width /2,
                  ),
                ),
                const SizedBox(height: 60.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Title(),
                    const SizedBox(height: 12.0,),
                    _SubTitle(),
                    const SizedBox(height: 26.0,),

                    CustomTextFormField(
                      hintText: '이메일을 입력해주세요',
                      onChanged: (String value) {
                        username = value;
                      },
                    ),
                    const SizedBox(height: 10.0,),
                    CustomTextFormField(
                      hintText: '비밀번호를 입력해주세요',
                      onChanged: (String value) {
                        password = value;
                      },
                      obscureText: true,
                    ),
                    const SizedBox(height: 16.0,),
                    ElevatedButton(
                      onPressed: () async{
                        // ID:비밀번호
                        final rawString = '$username:$password';

                        // Base64 ENCODE 처리/정의
                        Codec<String, String> stringToBase64 = utf8.fuse(base64);
                        // token으로 전환
                        String token = stringToBase64.encode(rawString);

                        final resp = await dio.post('http://$ip/auth/login',
                          options: Options(
                            headers: {
                              'authorization' : 'Basic $token',
                            },
                          ),
                        );

                        // Access Token, Refresh Token 참조하는 map
                        // resp.data;
                        final refreshToken = resp.data['refreshToken'];
                        final accessToken = resp.data['accessToken'];

                        //await storage.write(key: REFRESH_TOKEN_KEN, value: refreshToken);
                        //await storage.write(key: ACCESS_TOKEN_KEN, value: accessToken);

                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => HomeIndex(),),
                        );

                        /* refreshToken 발행처리
                          final refreshToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoicmVmcmVzaCIsImlhdCI6MTY5OTMzNTk5MywiZXhwIjoxNjk5NDIyMzkzfQ.VDMYZv-Ha5lGdnaMszwcFm7cFsK325IQf_e7utCYqQI';

                            final resp = await dio.post('http://$ip/auth/token',
                              options: Options(
                                headers: {
                                  'authorization' : 'Bearer $refreshToken',
                                },
                              ),
                            );
                           */

                      },
                      style: ElevatedButton.styleFrom(
                          primary: PRIMARY_COLOR,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 18.0)
                      ),
                      child: Text('로그인', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => HomeIndex(),),
                          );
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                        ),
                        child: Text('회원가입', style: TextStyle(fontWeight: FontWeight.w500))
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다!.',
      style: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 좋은하루되세요.',
      style: TextStyle(
        fontSize: 14.0,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
