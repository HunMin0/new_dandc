import 'package:Deal_Connect/components/const/setting_themes.dart';
import 'package:Deal_Connect/pages/auth/join/join_index.dart';
import 'package:Deal_Connect/pages/auth/login/login_index.dart';
import 'package:Deal_Connect/pages/auth/login/user_id_login.dart';
import 'package:Deal_Connect/pages/auth/terms/terms_index.dart';
import 'package:Deal_Connect/pages/default_page.dart';
import 'package:Deal_Connect/pages/group/group_index.dart';
import 'package:Deal_Connect/pages/group/group_view.dart';
import 'package:Deal_Connect/pages/intro/intro_index.dart';
import 'package:Deal_Connect/pages/profile/profile_group/profile_group_index.dart';
import 'package:Deal_Connect/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([ // 선호하는 화면 방향 설정
    DeviceOrientation.portraitUp, // 세로 방향 고정
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Deal&Connect', // 디바이스의 작업줄에 표시역할
        theme: SettingThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ko', 'KR'),
        ],
        initialRoute: '/',
        routes: {
          '/': (context) => RootPage(),
          '/home': (context) => DefaultPage(),
          '/intro': (context) => IntroIndex(),
          '/login': (context) => LoginIndex(),
          '/login/userId': (context) => UserIdLogin(),
          '/register': (context) => JoinIndex(),
          '/register/terms': (context) => TermsIndex(),
          '/profile/groups': (context) => ProfileGroupIndex(),
          '/group': (context) => GroupIndex(),
          '/group/info': (context) => GroupView(),
        }
    );
  }

}