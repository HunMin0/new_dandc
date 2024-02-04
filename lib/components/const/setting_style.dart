import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SettingStyle {
  static const Color MAIN_COLOR = Color(0xFF75A8E4);
  static const Color PRIMARY_COLOR = Color(0xFF75a8e4);
  static const Color BODY_TEXT_COLOR = Color(0xFF868686);
  static const Color INPUT_BG_COLOR = Color(0xFFFBFBFB);
  static const Color INPUT_BORDER_COLOR = Color(0xFFF3F2F2);

  static TextStyle SUB_GREY_TEXT = TextStyle(
      color: HexColor("#aaaaaa"), fontSize: 12, fontWeight: FontWeight.w500);

  static const TextStyle SUB_TITLE_STYLE = TextStyle(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);

  static const TextStyle TITLE_STYLE = TextStyle(
      color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);

}
