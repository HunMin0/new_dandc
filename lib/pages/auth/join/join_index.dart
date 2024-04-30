import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/custom/join_text_form_field.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/model/login_response_data.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class JoinIndex extends StatefulWidget {
  const JoinIndex({Key? key,}) : super(key: key);

  @override
  State<JoinIndex> createState() => _JoinIndexState();
}

class _JoinIndexState extends State<JoinIndex> {
  bool isAgreeMarketing = false;
  bool isAgreeAppNotification = false;
  bool isAgreeAppMarketing = false;

  String? name = '';
  String? userId = '';
  String? password;
  String? passwordConfirm;
  String? email;
  String? phone;
  String? recommendCode = '';

  var args;

  final _formKey = GlobalKey<FormState>();

  bool? _isIDValid; // 아이디 유효성 검사 결과 저장
  bool? _isRecommendCodeValid; // 추천인코드 유효성 검사 결과 저장
  bool _isButtonDisabled = true; // 중복검사 버튼 활성화여부

  //중복체크
  Future<bool> checkDuplicate() async {
    Map checkMapData = {
      'user_id': userId,
    };
    final value = await postCheckId(checkMapData); // await를 사용하여 비동기 호출 결과를 기다립니다.
    if (value.status == 'success') {
      return value.data; // 성공 시 value.data를 반환하거나, data가 null일 경우 false 반환
    } else {
      CustomDialog.showServerValidatorErrorMsg(value);
      return false; // 실패 시 false 반환
    }
  }

  //추천인코드 유효성체크
  Future<bool> checkRecommendCode() async {
    Map checkMapData = {
      'recommend_code': recommendCode,
    };
    final value = await postCheckRecommendCode(checkMapData);
    if (value.status == 'success') {
      return value.data;
    } else {
      CustomDialog.showServerValidatorErrorMsg(value);
      return false;
    }
  }


  @override
  void initState() {
    super.initState();

    final widgetsBinding = WidgetsBinding.instance;
    widgetsBinding?.addPostFrameCallback((callback) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        args = ModalRoute.of(context)?.settings.arguments;

        if (args != null) {
          setState(() {
            isAgreeMarketing = args['isAgreeMarketing'];
            isAgreeAppNotification = args['isAgreeAppNotification'];
            isAgreeAppMarketing = args['isAgreeAppMarketing'];
          });
        }
      }
    });
  }

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

    final buttonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        // 4자 이상인 경우 파란색, 아닌 경우 흰색
        userId!.length  >= 4 ? Colors.blue : Colors.white,
      ),
      foregroundColor: MaterialStateProperty.all<Color>(
        userId!.length >= 4 ? Colors.white : Colors.black,
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // 라운드 처리
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
            Text(
              '회원가입을 위해\n아래 정보를 입력해주세요.',
              style: SettingStyle.TITLE_STYLE,
            ),
            SizedBox(
              height: 15.0,
            ),
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
                        child: TextButton(
                          onPressed: _isButtonDisabled ? null : () async {
                            Future<bool> isDuplicate = checkDuplicate();
                            if (await isDuplicate) {
                              print('중복된 아이디입니다.');
                              setState(() {
                                _isIDValid =  false; // 중복된 경우 _isIDValid를 false로 설정하여 errorText를 표시
                              });
                            } else {
                              print('사용 가능한 아이디입니다.');
                              setState(() {
                                _isIDValid = true; // 중복되지 않은 경우 _isIDValid를 true로 설정하여 errorText를 숨김
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
                  _UserFieldPhone(),
                  SizedBox(
                    height: 8.0,
                  ),
                  _UserFieldEmail(),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _UserFieldRecommend(),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: 80.0,
                        height: 50.0,
                        margin: EdgeInsets.only(top: 15.0),
                        constraints: BoxConstraints(
                          maxHeight: double.infinity,
                        ),
                        child: TextButton(
                          onPressed: () async {
                            Future<bool> isExists = checkRecommendCode();
                            if (await isExists) {
                              setState(() {
                                _isRecommendCodeValid =  true; // 중복된 경우 _isIDValid를 false로 설정하여 errorText를 표시
                              });
                            } else {
                              setState(() {
                                _isRecommendCodeValid = false; // 중복되지 않은 경우 _isIDValid를 true로 설정하여 errorText를 숨김
                              });
                            }
                          },
                          style: buttonStyle,
                          child: Text(
                            '조회',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Map userMapData = {
                        'user_id': userId,
                        'name': name,
                        'email': email,
                        'password': password,
                        'password_confirmation': passwordConfirm,
                        'phone': phone,
                        'recommend_code': recommendCode,
                        'is_agree_marketing': isAgreeMarketing,
                        'is_agree_app_notification': isAgreeAppNotification,
                        'is_agree_app_marketing': isAgreeAppMarketing,
                      };
                      _formKey.currentState!.validate();
                      postRegister(userMapData).then((value) {
                        if (value.status == 'success') {


                          postLogin({
                            'user_id': userId,
                            'password': password
                          }).then((value) {
                            CustomDialog.dismissProgressDialog();

                            if (value.status == 'success') {
                              LoginResponseData loginResponseData = LoginResponseData.fromJSON(value.data);

                              initLoginUserData(
                                  loginResponseData.user,
                                  loginResponseData.tokenType,
                                  loginResponseData.accessToken
                              ).then((result) {
                                if (!(loginResponseData.user.is_active)) {
                                  Navigator.pushNamedAndRemoveUntil(context, '/auth/withdraw', (r) => false);
                                } else {
                                  refreshFcmToken().then((value) {});
                                  if (loginResponseData.user.is_agree_app_notification) {
                                    FirebaseMessaging.instance.subscribeToTopic('all')
                                        .then((_) {
                                      print('사용자가 all 토픽을 구독하였습니다.');
                                    });
                                  }
                                  if (loginResponseData.user.is_agree_marketing) {
                                    FirebaseMessaging.instance.subscribeToTopic('marketing')
                                        .then((_) {
                                      print('사용자가 marketing 토픽을 구독하였습니다.');
                                    });
                                  }
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/home', (r) => false);
                                }
                              });
                            } else {
                              CustomDialog.showServerValidatorErrorMsg(value);
                            }
                          });
                        } else {
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
                  ),
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
          ? '아이디를 입력하고, 중복체크를 해주세요.'
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
          userId = value;
          _isIDValid = null;
          if (value.length >= 4) {
            _isButtonDisabled = false;
          }
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

        password = value; // 비밀번호 저장
        return null;
      },
      onChanged: (String value) {
        setState(() {
          password = value;
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
        if (value != password) {
          return '비밀번호를 다시 확인 해주세요.';
        }

        return null; // 유효한 경우 null 반환
      },
      onChanged: (String value) {
        setState(() {
          passwordConfirm = value;
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
        name = value;
      },
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
        phone = value;
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
        email = value;
      },
    );
  }


  JoinTextFormField _UserFieldRecommend() {
    return JoinTextFormField(
      label: '추천인코드',
      hintText: '추천인코드를 입력해주세요.',
      helperText: recommendCode == '' ? '추천인코드 6자리를 입력해주세요.'
          : _isRecommendCodeValid!
          ? '사용 가능한 코드입니다.' : null,
      errorText: recommendCode == '' ? null :
        _isRecommendCodeValid == null
          ? '추천인 코드 조회를 해주세요.'
          : !_isRecommendCodeValid!
          ? '존재하지 않는 코드입니다.'
          : null,
      maxLength: 6,
      onChanged: (String value) {
        recommendCode = value;
        _isRecommendCodeValid = null;
      },
    );
  }

}
