import 'package:flutter/material.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';

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
    Key? key})
    : super(key: key);


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

class LoginTextFormField extends StatelessWidget {
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final IconData? icon;
  final bool isPassword;

  const LoginTextFormField({
    this.labelText,
    this.icon,
    bool? isPassword,
    required this.onChanged,
    Key? key,
  })  : isPassword = isPassword ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        contentPadding: EdgeInsets.only(bottom: 14.0),
        prefixIconConstraints: BoxConstraints(minWidth: 10, maxHeight: 25),
        prefixIcon: icon != null
            ? Padding(
                padding: EdgeInsets.only(left: 5, right: 5, bottom: 0),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              )
            : null,
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
    );
  }
}

class JoinTextFormField extends StatelessWidget {
  final String label;
  final String? hintText;
  final String? errorText;
  final String? helperText;
  final bool obscureText;
  final bool autofocus;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const JoinTextFormField({
    required this.label,
    required this.onChanged,
    this.maxLength,
    this.autofocus = false, // 기본값 false로 설정
    this.obscureText = false, // 기본값 false로 설정
    this.hintText,
    this.helperText,
    this.errorText,
    this.validator,

    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1.0,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(label,
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),),
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          cursorColor: PRIMARY_COLOR, // 커서 색상
          // 비밀번호 입력할경우 *** 처리
          obscureText: obscureText,
          // 화면에 들어올경우 포커스를 걸어놓을지 설정 true
          autofocus: autofocus,
          // 값이 바뀔경우 콜백
          maxLength: maxLength,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12.0), // 필드 패딩
            hintText: hintText,
            errorText: errorText,
            helperText : helperText,

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


