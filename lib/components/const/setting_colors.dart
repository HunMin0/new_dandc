import 'package:flutter/material.dart';

// 주색상
const PRIMARY_COLOR = Color(0xFF75a8e4);
// 글자색상
const BODY_TEXT_COLOR = Color(0xFF868686);
// 텍스트필드 배경 색상
const INPUT_BG_COLOR = Color(0xFFFBFBFB);
// 텍스트필드 테두리색상
const INPUT_BORDER_COLOR = Color(0xFFF3F2F2);


// 단일컬러 설정
class SettingColors {
  static const int _primaryColorValue = 0xFFFFFFFF;
  static const primaryColor = Color(_primaryColorValue);

  static const MaterialColor primaryMeterialColor = MaterialColor(
      _primaryColorValue,
      <int, Color>{
        50: Color(_primaryColorValue),
        100: Color(_primaryColorValue),
        200: Color(_primaryColorValue),
        300: Color(_primaryColorValue),
        400: Color(_primaryColorValue),
        500: Color(_primaryColorValue),
        600: Color(_primaryColorValue),
        700: Color(_primaryColorValue),
        800: Color(_primaryColorValue),
        900: Color(_primaryColorValue),
      }
  );
}


/*
<int, Color>{
       50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(_bluePrimaryValue),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
 */