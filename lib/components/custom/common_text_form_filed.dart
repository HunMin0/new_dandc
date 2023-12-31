import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextFormField extends StatefulWidget {
  final String label;
  final String? hintText;
  final String? errorText;
  final String? helperText;
  final bool obscureText;
  final bool autofocus;
  final bool isNumber; // true 숫자 , false 문자포함
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const CommonTextFormField({
    required this.label,
    required this.onChanged,
    this.maxLength,
    this.autofocus = false, // 기본값 false로 설정
    this.obscureText = false, // 기본값 false로 설정
    this.isNumber = false,
    this.hintText,
    this.helperText,
    this.errorText,
    this.validator,
    Key? key}) : super(key: key);

  @override
  _CommonTextFormFieldState createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  final baseBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: INPUT_BORDER_COLOR,
      width: 1.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(widget.label,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13.0,
            ),),
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
          cursorColor: PRIMARY_COLOR, // 커서 색상
          // 비밀번호 입력할경우 *** 처리
          obscureText: widget.obscureText,
          // 화면에 들어올경우 포커스를 걸어놓을지 설정 true
          autofocus: widget.autofocus,
          // 값이 바뀔경우 콜백
          maxLength: widget.maxLength,
          keyboardType: widget.isNumber ? TextInputType.number : TextInputType.text,
          inputFormatters: widget.isNumber ? [
            FilteringTextInputFormatter.digitsOnly,
          ]:[],
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12.0), // 필드 패딩
            hintText: widget.hintText,
            errorText: widget.errorText,
            helperText : widget.helperText,
            helperStyle: TextStyle(
              color: PRIMARY_COLOR,
              fontWeight: FontWeight.w500,
            ),
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
        ),
      ],
    );
  }
}
