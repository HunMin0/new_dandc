import 'package:DealConnect/pages/auth/login/email.dart';
import 'package:DealConnect/pages/auth/login/index.dart';
import 'package:DealConnect/pages/home/index.dart';
import 'package:DealConnect/pages/intro.dart';
import 'package:DealConnect/pages/root.dart';
import 'package:flutter/material.dart';
import 'package:DealConnect/components/const/setting_themes.dart';
import 'package:DealConnect/components/custom/custom_text_form_field.dart';
import 'package:DealConnect/components/const/setting_themes.dart';
import 'package:DealConnect/pages/home_index.dart';
import 'package:DealConnect/pages/view/splash_screen.dart';
import 'package:DealConnect/pages/auth/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Deal&Connect', // 디바이스의 작업줄에 표시역할
        theme: SettingThemes.lightTheme,
        debugShowCheckedModeBanner: true,
        //home: const SplashScreen(),
        //home: const HomeIndex(),
        //home: LoginScreen(),

        /*
      // 기기설정 폰트 사이즈에 의존하지 않을 경우 주석해제
      builder: (context, child) => MediaQuery(
        child: child!,
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      ),
      */

        /*
      기존 bu셋팅 */

        initialRoute: '/',
        routes: {
          '/': (context) => RootPage(),
          '/home': (context) => HomeIndex(),
          '/intro': (context) => IntroPage(),
          '/login': (context) => LoginIndex(),
          '/login/email': (context) => EmailLoginPage(),
        }


    );
  }
}
