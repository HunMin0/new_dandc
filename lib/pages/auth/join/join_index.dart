import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/components/custom/join_text_form_field.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:flutter/material.dart';

class JoinIndex extends StatefulWidget {
  const JoinIndex({Key? key}) : super(key: key);

  @override
  State<JoinIndex> createState() => _JoinIndexState();
}

class _JoinIndexState extends State<JoinIndex> {
  final _formKey = GlobalKey<FormState>();

  bool? _isIDValid; // 아이디 유효성 검사 결과 저장

  /* 중복체크 버그 수정 해야함.
    입력후 기존 데이터를 갖고 있어 두번 눌어야 처리됨
    입력후 문자 지우면 승인문구 그대로 출력

  */

  Future<bool> checkDuplicate(String value) async {
    await Future.delayed(Duration(seconds: 2));
    return value == 'kimkk';
  }

  String? selectedTelecom; // 선택된 통신사
  List<String> telecomList = ['선택', 'KT', 'SKT', 'LGT']; // 통신사 목록

  Map joinFormData = {
    'userName': '',
    'userID': '',
    'userpassword': '',
    'userEmail': '',
    'userPhone': '',
  };

  @override
  void initState() {
    super.initState();
    selectedTelecom = telecomList[0];
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
      backgroundColor:
      MaterialStateProperty.all<Color>(
        // 4자 이상인 경우 파란색, 아닌 경우 흰색
        joinFormData['userID'].length >= 4
            ? Colors.blue
            : Colors.white,
      ),
      foregroundColor:
      MaterialStateProperty.all<Color>(
        joinFormData['userID'].length >= 4
            ? Colors.white
            : Colors.black,
      ),
      shape:
      MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(8.0), // 라운드 처리
          side: BorderSide(
            color: INPUT_BORDER_COLOR,
            width: 1.0,
          ), // 보더 색상
        ),
      ),
    );

    return DefaultLogoLayout(
      //titleName: '회원가입',
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: [
            Text('회원가입을 위해\n아래 정보를 입력해주세요.', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),),
            SizedBox(height: 15.0,),
            Form(
              key: _formKey,
              //autovalidateMode: AutovalidateMode.onUserInteraction, // 실시간 유효성 검사 모드 설정
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _UserFieldId(),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Container(
                        width: 80.0,
                        height: 50.0,
                        margin: EdgeInsets.only(top: 15.0),
                        constraints: BoxConstraints(
                          maxHeight: double.infinity,
                        ),
                        child: FutureBuilder<bool>(
                          future: checkDuplicate(joinFormData['userID']), // 비동기 중복 체크 함수 호출
                          builder: (context, snapshot) {
                            return TextButton(
                              onPressed: () async {
                                bool isDuplicate = await checkDuplicate(joinFormData['userID']);
                                // 여기에서 중복 체크 결과를 사용하여 필요한 작업 수행
                                if (isDuplicate) {
                                  // 중복된 경우의 처리
                                  print('중복된 아이디입니다.');
                                  setState(() {
                                    _isIDValid =
                                        false; // 중복된 경우 _isIDValid를 false로 설정하여 errorText를 표시
                                  });
                                } else {
                                  // 중복되지 않은 경우의 처리
                                  print('사용 가능한 아이디입니다.');
                                  setState(() {
                                    _isIDValid =
                                        true; // 중복되지 않은 경우 _isIDValid를 true로 설정하여 errorText를 숨김
                                  });
                                }
                              },
                              style: buttonStyle,
                              child: Text(
                                '중복확인',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  _UserFieldPassword(),
                  _UserFieldRePassword(),
                  SizedBox(
                    height: 8.0,
                  ),
                  _UserFieldName(),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: _UserFieldTelecom(),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        flex: 3,
                        child: _UserFieldPhone(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  _UserFieldEmail(),
                  SizedBox(
                    height: 30.0,
                  ),
                  _formSubmit(formKey: _formKey, formData: joinFormData),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  JoinTextFormField _UserFieldId() {
    return JoinTextFormField(
      label: '아이디',
      hintText: '아이디를 입력해주세요.',
      helperText: _isIDValid == null
          ? '영문/숫자 4자 이상을 입력해 주세요.'
          : _isIDValid!
              ? '사용가능한 아이디 입니다.'
              : '영문/숫자 4자 이상을 입력해 주세요.',
      errorText: _isIDValid == null
          ? null
          : _isIDValid!
              ? null
              : '아이디가 중복 입니다',
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return '아이디를 입력하세요.';
        }
        if (value.length < 4) {
          return '아이디는 4자 이상이어야 합니다.';
        }
        if (!RegExp(r'^[a-zA-Z0-9_\-]+$').hasMatch(value)) {
          return '아이디는 영문자, 숫자, -, _ 문자만 사용 가능합니다.';
        }
        return null; // 유효한 경우 null 반환
      },
      onChanged: (String value) {
        setState(() {
          joinFormData['userID'] = value;
          _isIDValid = false;
        });
      },
    );
  }

  JoinTextFormField _UserFieldPassword() {
    return JoinTextFormField(
      label: '비밀번호',
      hintText: '비밀번호를 입력해주세요.',
      helperText: '8자 이상의 영문 대/소문자, 숫자, 특수문자를 사용하세요.',
      obscureText: true,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return '비밀번호를 입력해주세요.';
        }
        String error = '8자 이상, 영문 대/소문자, 숫자, 특수문자로 조합해주세요.';

        // 소문자, 숫자, 특수문자 중 하나라도 없는 경우 에러 메시지 추가
        if (!RegExp(r'[a-zA-Z]').hasMatch(value) ||
            !RegExp(r'\d').hasMatch(value) ||
            !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
          return error;
        }

        // 8자 이상이 아닌 경우 에러 메시지 추가
        if (value.length < 8) {
          return error;
        }

        // 반복되는 숫자, 문자, 특수문자가 4개 이상인 경우 에러 메시지 추가
        if (RegExp(r'(.)\1{3,}').hasMatch(value)) {
          return '연속되거나 동일한 문자(4개 이상)의 입력을 제한합니다.';
        }

        joinFormData['userpassword'] = value; // 비밀번호 저장
        return null;
      },
      onChanged: (String value) {
        setState(() {
          joinFormData['userpassword'] = value;
        });
      },
    );
  }

  JoinTextFormField _UserFieldRePassword() {
    return JoinTextFormField(
      label: '비밀번호 재확인',
      hintText: '비밀번호를 다시 입력해주세요.',
      obscureText: true,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return '비밀번호를 입력해주세요.';
        }

        // 비밀번호와 일치하지 않는 경우 에러 메시지 추가
        if (value != joinFormData['userpassword']) {
          return '비밀번호를 다시 확인 해주세요.';
        }

        return null; // 유효한 경우 null 반환
      },
      onChanged: (String value) {
        setState(() {
          joinFormData['userpassword'] = value;
        });
      },
    );
  }

  JoinTextFormField _UserFieldName() {
    return JoinTextFormField(
      label: '이름',
      hintText: '이름을 입력해주세요.',
      helperText: '20자이내로 입력해주세요.',
      maxLength: 20,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return '이름을 입력해주세요.';
        }

        return null; // 유효한 경우 null 반환
      },
      onChanged: (String value) {
        joinFormData['userName'] = value;
        print(joinFormData);
      },
    );
  }

  JoinDropFormField _UserFieldTelecom() {
    return JoinDropFormField(
      label: '통신사',
      selectedTelecom: selectedTelecom,
      telecomList: telecomList,
    );
  }

  JoinTextFormField _UserFieldPhone() {
    return JoinTextFormField(
      label: '전화번호',
      hintText: '"-" 구분 없이 입력',
      isNumber: true,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return '전화번호를 입력해주세요.';
        }

        return null; // 유효한 경우 null 반환
      },
      onChanged: (String value) {
        joinFormData['userPhone'] = value;
      },
    );
  }

  JoinTextFormField _UserFieldEmail() {
    return JoinTextFormField(
      label: '이메일 주소',
      hintText: '이메일 주소를 입력해주세요.',
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return '이메일을 입력해주세요.';
        }

        // 이메일 형식 검증
        if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
            .hasMatch(value)) {
          return '올바른 이메일 형식을 입력해주세요.';
        }

        return null; // 유효한 경우 null 반환
      },
      onChanged: (String value) {
        joinFormData['userEmail'] = value;

      },
    );
  }
}

class _formSubmit extends StatelessWidget {
  const _formSubmit({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.formData,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final Map<dynamic, dynamic> formData; // 새로운 필드 추가

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextButton.styleFrom(
      backgroundColor: PRIMARY_COLOR,
      padding: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      side: BorderSide(color: PRIMARY_COLOR),
    );
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    );

    return TextButton(
      onPressed: () {
        _formKey.currentState!.validate();
        postRegister(formData).then((value) {
          if (value.status == 'success') {
            Navigator.pushNamed(context, '/login');
          } else {
            print(value.message);
            CustomDialog.showServerValidatorErrorMsg(value);
          }
        });
      },
      style: baseStyle,
      child: Container(
          width: double.infinity,
          child: Center(
            child: Text(
              '가입하기',
              style: textStyle,
            ),
          )),
    );
  }
}
