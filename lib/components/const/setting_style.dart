import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SettingStyle {
  static const Color MAIN_COLOR = Color(0xFF75A8E4);
  static const Color PRIMARY_COLOR = Color(0xFF75a8e4);
  static const Color BODY_TEXT_COLOR = Color(0xFF868686);
  static const Color INPUT_BG_COLOR = Color(0xFFFBFBFB);
  static const Color INPUT_BORDER_COLOR = Color(0xFFF3F2F2);
  static const Color GREY_COLOR = Color(0xFFf5f6fa);

  static const TextStyle NORMAL_TEXT_STYLE = TextStyle(
      color: Colors.black, fontSize: 15);

  static const TextStyle SMALL_TEXT_STYLE = TextStyle(
      color: Colors.black, fontSize: 12);

  static TextStyle SUB_GREY_TEXT = TextStyle(
      color: HexColor("#aaaaaa"), fontSize: 11, fontWeight: FontWeight.w500);

  static const TextStyle SUB_TITLE_STYLE = TextStyle(
      color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500);

  static const TextStyle TITLE_STYLE = TextStyle(
      color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);



  static const InputDecoration INPUT_STYLE = InputDecoration(
    fillColor: INPUT_BG_COLOR,
    filled: true,
    // fillColor에 배경색이 있을 경우 색상반영, false 미적용
    // 기본보더
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1.0,
      ),
    ),
    // 선택되지 않은상태에서 활성화 되어있는 필드
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1.0,
      ),
    ),
    // 포커스보더
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: PRIMARY_COLOR,
        width: 1.0,
      ),
    ),
    contentPadding: EdgeInsets.all(12.0),
  );

  static final ButtonStyle BUTTON_STYLE = ElevatedButton.styleFrom(
    backgroundColor: Color(0xFFf5f6fa),
    foregroundColor: Color(0xFFf5f6fa),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}
