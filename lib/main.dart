import 'package:Deal_Connect/components/const/setting_themes.dart';
import 'package:Deal_Connect/pages/auth/join/join_index.dart';
import 'package:Deal_Connect/pages/auth/login/login_index.dart';
import 'package:Deal_Connect/pages/auth/login/user_id_login.dart';
import 'package:Deal_Connect/pages/auth/terms/terms_index.dart';
import 'package:Deal_Connect/pages/default_page.dart';
import 'package:Deal_Connect/pages/intro/intro_index.dart';
import 'package:Deal_Connect/pages/root_page.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Deal&Connect', // 디바이스의 작업줄에 표시역할
        theme: SettingThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => RootPage(),
          '/home': (context) => DefaultPage(),
          '/intro': (context) => IntroIndex(),
          '/login': (context) => LoginIndex(),
          '/login/userId': (context) => UserIdLogin(),
          '/join': (context) => JoinIndex(),
          '/terms': (context) => TermsIndex(),
        }
    );
  }

}