import 'package:flutter/material.dart';
import 'package:DealConnect/components/const/setting_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    required this.onChanged,
    this.autofocus = false, // 기본값 false로 설정
    this.obscureText = false, // 기본값 false로 설정
    this.hintText,
    this.errorText,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1.0,
      ),
    );

    return TextFormField(
      cursorColor: PRIMARY_COLOR, // 커서 색상
      // 비밀번호 입력할경우 *** 처리
      obscureText: obscureText,
      // 화면에 들어올경우 포커스를 걸어놓을지 설정 true
      autofocus: autofocus,
      // 값이 바뀔경우 콜백
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20.0), // 필드 패딩
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14.0,
        ),
        fillColor: INPUT_BG_COLOR,
        filled: true, // fillColor에 배경색이 있을 경우 색상반영, false 미적용
        // 기본보더
        border: baseBorder,
        // 선택되지 않은상태에서 활성화 되어있는 필드
        enabledBorder: baseBorder,
        // 포커스보더
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          ),
        ),
      ),
    );
  }
}
