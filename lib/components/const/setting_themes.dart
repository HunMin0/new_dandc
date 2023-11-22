import 'package:flutter/material.dart';
import 'package:DealConnect/components/const/setting_colors.dart';

// light 테마
class SettingThemes {
  static ThemeData get lightTheme => ThemeData(
      fontFamily: 'GmarketSansTTF',
      primarySwatch: SettingColors.primaryMeterialColor, // AppBar와 플롯액션버튼 프라이머리 컬러 지정
      scaffoldBackgroundColor: Colors.white,
      // splashColor: Colors.pink, // 픗롯액션버튼 클릭시 색상
      textTheme: _textTheme,
      brightness: Brightness.light // 디폴트는 light , dark 테마
  );

  // dark 테마
  static ThemeData get darkTheme => ThemeData(
      fontFamily: 'GmarketSansTTF',
      primarySwatch: SettingColors.primaryMeterialColor, // AppBar와 플롯액션버튼 프라이머리 컬러 지정
      // scaffoldBackgroundColor: Colors.white,
      // splashColor: Colors.pink, // 픗롯액션버튼 클릭시 색상
      textTheme: _textTheme,
      brightness: Brightness.dark // 디폴트는 dark  , light 테마
  );

  static const TextTheme _textTheme = TextTheme(
    headline4: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    subtitle2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyText1: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w300,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
    button: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
    ),
  );
}

/*
  내부폰트 기준
  headline1, headline2, headline3, headline4, headline5, headline6
  subtitle1, subtitle2, bodyText1, bodyText2, button, caption, overline
  https://api.flutter.dev/flutter/material/TextTheme-class.html
 */