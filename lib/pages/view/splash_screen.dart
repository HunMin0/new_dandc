import 'dart:async';

import 'package:flutter/material.dart';
import 'package:DealConnect/components/const/data.dart';
import 'package:DealConnect/components/layout/default_layout.dart';
import 'package:DealConnect/components/const/setting_colors.dart';
import 'package:DealConnect/pages/home_index.dart';
import 'package:DealConnect/pages/auth/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
/*  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2),(){
      //deleteToken();
      checkToken();
    });

  }


  void deleteToken() async {
    await storage.deleteAll();
  }

  void checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEN);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEN);

    // token 없다면 로그인
    if(refreshToken == null || accessToken == null){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => LoginScreen(),
          ),
              (route) => false);
    } else { // token이 유효한지도 체크해야함
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => HomeIndex(),
          ),
              (route) => false);
    }
  }


 */
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: SettingColors.primaryMeterialColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png',
              width: MediaQuery.of(context).size.width /2,),
            const SizedBox(height: 20.0,),
            Container(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Color(0xFF75a8e4),
                strokeWidth: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }


}


/*

  flutter_secure_storage 처리
  리플래시/액세스 토큰처리 후 별도처리
  백그라운드 이동후 반복적인 로그인 상태 처리

*/