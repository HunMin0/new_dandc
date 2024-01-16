import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JoinTextFormField extends StatefulWidget {
  final String label;
  final String? hintText;
  final String? errorText;
  final String? helperText;
  final bool obscureText;
  final bool autofocus;
  final bool isNumber; // true 숫자 , false 문자포함
  final int? maxLength;
  final bool? enabled;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const JoinTextFormField({
    required this.label,
    required this.onChanged,
    this.maxLength,
    this.autofocus = false, // 기본값 false로 설정
    this.obscureText = false, // 기본값 false로 설정
    this.isNumber = false,
    this.enabled,
    this.hintText,
    this.helperText,
    this.errorText,
    this.validator,
    Key? key}) : super(key: key);

  @override
  _JoinTextFormFieldState createState() => _JoinTextFormFieldState();
}

class _JoinTextFormFieldState extends State<JoinTextFormField> {
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
          enabled: widget.enabled,
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

// label 없는 텍스트필드
class BasicJoinTextFormField extends StatefulWidget {
  final String? hintText;
  final String? errorText;
  final String? helperText;
  final bool obscureText;
  final bool autofocus;
  final bool isNumber; // true 숫자 , false 문자포함
  final int? maxLength;
  final bool? enabled;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const BasicJoinTextFormField({
    required this.onChanged,
    this.maxLength,
    this.autofocus = false, // 기본값 false로 설정
    this.obscureText = false, // 기본값 false로 설정
    this.isNumber = false,
    this.enabled,
    this.hintText,
    this.helperText,
    this.errorText,
    this.validator,
    super.key});

  @override
  State<BasicJoinTextFormField> createState() => _BasicJoinTextFormFieldState();
}

class _BasicJoinTextFormFieldState extends State<BasicJoinTextFormField> {
  final baseBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: INPUT_BORDER_COLOR,
      width: 1.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        enabled: widget.enabled,
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
    );
  }
}


// 셀렉티드 박스 커스텀
class JoinDropFormField extends StatefulWidget {
  final String label;
  String? selectedTelecom; // 추가: 외부에서 받아올 선택된 통신사 값
  final List<String> telecomList; // 추가: 외부에서 받아올 통신사 목록

  JoinDropFormField({
    required this.label,
    required this.selectedTelecom,
    required this.telecomList,

    Key? key}) : super(key: key);

  @override
  State<JoinDropFormField> createState() => _JoinDropFormFieldState();
}

class _JoinDropFormFieldState extends State<JoinDropFormField> {
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
          child: Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13.0,
            ),
          ),
        ),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12.0), // 필드 패딩
            fillColor: INPUT_BG_COLOR,
            filled: true, // fillColor에 배경색이 있을 경우 색상반영, false 미적용
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
          value: widget.selectedTelecom, // 수정: 외부에서 받아온 값 사용
          onChanged: (String? newValue) {
            setState(() {
              // onChanged에서 외부에서 전달받은 값으로 업데이트
              widget.selectedTelecom = newValue;
            });
          },
          items: widget.telecomList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(fontSize: 14.0),),
            );
          }).toList(),
        )
      ],
    );
  }
}
