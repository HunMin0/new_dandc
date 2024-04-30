import 'dart:convert';

import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/model/login_response_data.dart';
import 'package:Deal_Connect/pages/auth/terms/privacy_terms.dart';
import 'package:Deal_Connect/pages/auth/terms/terms_of_use.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SnsJoin extends StatefulWidget {
  const SnsJoin({super.key});

  @override
  State<SnsJoin> createState() => _SnsJoinState();
}

class _SnsJoinState extends State<SnsJoin> {
  String userId = '';
  String snsId = '';
  String site = '';
  String accessToken = '';
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  var args;

  bool? _isRecommendCodeValid = null;
  bool isAllAgree = false;
  bool isAgreeService = false;
  bool isAgreePersonal = false;
  bool isAgreeMarketing = false;
  bool isAgreeAppNotification = false;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  //추천인코드 유효성체크
  Future<bool> checkRecommendCode() async {
    Map checkMapData = {
      'recommend_code': _codeController.text,
    };
    final value = await postCheckRecommendCode(checkMapData);
    if (value.status == 'success') {
      return value.data;
    } else {
      CustomDialog.showServerValidatorErrorMsg(value);
      return false;
    }
  }

  void _initData() async {
    final widgetsBinding = WidgetsBinding.instance;
    widgetsBinding?.addPostFrameCallback((callback) async {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        setState(() {
          args = ModalRoute.of(context)?.settings.arguments;
        });

        if (args != null) {
          setState(() {
            accessToken = args['token'];
            site = args['site'];

            snsId = args['id'].toString();
            userId = args['id'].toString();
            _emailController.text = args['email'];
            _nameController.text = args['name'];
            _phoneController.text =
                args['user']['response']['mobile'].replaceAll('-', '');
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final snsData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(snsData.toString());

    return DefaultLogoLayout(
        //titleName: '회원가입',
        child: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '회원가입을 위해\n아래 정보를 입력해주세요.',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 15.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "이름",
                  style: SettingStyle.SUB_GREY_TEXT,
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: SettingStyle.INPUT_STYLE,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return '이름을 입력해주세요.';
                    }
                    return null; // 유효한 경우 null 반환
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "전화번호",
                  style: SettingStyle.SUB_GREY_TEXT,
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: SettingStyle.INPUT_STYLE,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return '전화번호를 입력해주세요.';
                    }
                    return null; // 유효한 경우 null 반환
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "이메일",
                  style: SettingStyle.SUB_GREY_TEXT,
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: SettingStyle.INPUT_STYLE,
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
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "추천인코드",
                  style: SettingStyle.SUB_GREY_TEXT,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _codeController,
                        keyboardType: TextInputType.text,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) {
                          setState(() {
                            _isRecommendCodeValid = null;
                          });
                        },
                        decoration: SettingStyle.INPUT_STYLE.copyWith(
                            errorText: _codeController.text == ''
                                ? null
                                : _isRecommendCodeValid == null
                                    ? '추천인 코드 조회를 해주세요.'
                                    : !_isRecommendCodeValid!
                                        ? '존재하지 않는 코드입니다.'
                                        : null,
                            helperText: _codeController.text == ''
                                ? '추천인 코드를 입력해주세요.'
                                : _isRecommendCodeValid == true
                                    ? '사용가능한 코드입니다.'
                                    : null),
                        maxLength: 6,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 80.0,
                      height: 50.0,
                      constraints: BoxConstraints(
                        maxHeight: double.infinity,
                      ),
                      child: TextButton(
                        onPressed: () async {
                          Future<bool> isExists = checkRecommendCode();
                          if (await isExists) {
                            setState(() {
                              _isRecommendCodeValid =
                                  true; // 중복된 경우 _isIDValid를 false로 설정하여 errorText를 표시
                            });
                          } else {
                            setState(() {
                              _isRecommendCodeValid =
                                  false; // 중복되지 않은 경우 _isIDValid를 true로 설정하여 errorText를 숨김
                            });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              // 라운드 처리
                              side: BorderSide(
                                color: SettingStyle.INPUT_BORDER_COLOR,
                                width: 1.0,
                              ), // 보더 색상
                            ),
                          ),
                        ),
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
                  height: 40,
                ),
                Text(
                  "이용 동의",
                  style: SettingStyle.SUB_GREY_TEXT,
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAgreeService = !isAgreeService;
                      checkNextButtonState(); // 변경된 상태를 확인하여 버튼 갱신
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TermsOfUse()));
                          },
                          child: Text(
                            '[필수] 서비스 이용 약관',
                            style: TextStyle(
                                fontSize: 14.0,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: isAgreeService
                                    ? SettingStyle.MAIN_COLOR
                                    : Color(0xFFDDDDDD),
                                width: 2.0),
                            color: isAgreeService
                                ? SettingStyle.MAIN_COLOR
                                : Colors.transparent, // 클릭 시 배경색 변경
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent, // 이 부분 수정
                            child: Icon(
                              Icons.check,
                              size: 12.0,
                              color: isAgreeService
                                  ? Colors.white
                                  : Color(0xFFDDDDDD),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAgreePersonal = !isAgreePersonal;
                      checkNextButtonState(); // 변경된 상태를 확인하여 버튼 갱신
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PrivacyTerms()));
                          },
                          child: Text(
                            '[필수] 개인정보 처리 방침',
                            style: TextStyle(
                                fontSize: 14.0,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: isAgreePersonal
                                    ? SettingStyle.MAIN_COLOR
                                    : Color(0xFFDDDDDD),
                                width: 2.0),
                            color: isAgreePersonal
                                ? SettingStyle.MAIN_COLOR
                                : Colors.transparent, // 클릭 시 배경색 변경
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent, // 이 부분 수정
                            child: Icon(
                              Icons.check,
                              size: 12.0,
                              color: isAgreePersonal
                                  ? Colors.white
                                  : Color(0xFFDDDDDD),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAgreeAppNotification = !isAgreeAppNotification;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '[선택] 푸시 알림 동의',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: isAgreeAppNotification
                                    ? SettingStyle.MAIN_COLOR
                                    : Color(0xFFDDDDDD),
                                width: 2.0),
                            color: isAgreeAppNotification
                                ? SettingStyle.MAIN_COLOR
                                : Colors.transparent, // 클릭 시 배경색 변경
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent, // 이 부분 수정
                            child: Icon(
                              Icons.check,
                              size: 12.0,
                              color: isAgreeAppNotification
                                  ? Colors.white
                                  : Color(0xFFDDDDDD),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAgreeMarketing = !isAgreeMarketing;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '[선택] 이벤트 및 마케팅 활용 알림 동의',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: isAgreeMarketing
                                    ? SettingStyle.MAIN_COLOR
                                    : Color(0xFFDDDDDD),
                                width: 2.0),
                            color: isAgreeMarketing
                                ? SettingStyle.MAIN_COLOR
                                : Colors.transparent, // 클릭 시 배경색 변경
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent, // 이 부분 수정
                            child: Icon(
                              Icons.check,
                              size: 12.0,
                              color: isAgreeMarketing
                                  ? Colors.white
                                  : Color(0xFFDDDDDD),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAllAgree = !isAllAgree;
                      isAgreeService = isAllAgree;
                      isAgreePersonal = isAllAgree;
                      isAgreeMarketing = isAllAgree;
                      isAgreeAppNotification = isAllAgree;
                      checkNextButtonState(); // 변경된 상태를 확인하여 버튼 갱신
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '전체동의',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: SettingStyle.MAIN_COLOR,
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: isAllAgree
                                    ? SettingStyle.MAIN_COLOR
                                    : Color(0xFFDDDDDD),
                                width: 2.0),
                            color: isAllAgree
                                ? SettingStyle.MAIN_COLOR
                                : Colors.transparent, // 클릭 시 배경색 변경
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent, // 이 부분 수정
                            child: Icon(
                              Icons.check,
                              size: 12.0,
                              color:
                                  isAllAgree ? Colors.white : Color(0xFFDDDDDD),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            TextButton(
              onPressed: () {
                Map userMapData = {
                  'site': site,
                  'token': accessToken,
                  'sns_id': snsId,
                  'user_id': userId,
                  'name': _nameController.text,
                  'email': _emailController.text,
                  'phone': _phoneController.text,
                  'recommend_code': _codeController.text,
                  'is_agree_marketing': isAgreeMarketing,
                  'is_agree_app_notification': isAgreeAppNotification,
                  'is_agree_marketing': isAgreeMarketing,
                };
                postSnsRegister(userMapData).then((response) {
                  if (response.status == 'success') {
                    LoginResponseData loginResponseData = LoginResponseData.fromJSON(
                        response.data);

                    CustomDialog.showProgressDialog(context);
                    initLoginUserData(
                        loginResponseData.user,
                        loginResponseData.tokenType,
                        loginResponseData.accessToken
                    ).then((result) {
                      CustomDialog.dismissProgressDialog();
                      Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
                    });
                  } else {
                    CustomDialog.showServerValidatorErrorMsg(response);
                  }
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: SettingStyle.MAIN_COLOR,
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                side: BorderSide(color: SettingStyle.MAIN_COLOR),
              ),
              child: Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      '가입하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    ));
  }

  void checkNextButtonState() {
    // (필수) 약관들이 모두 동의되었는지 확인하여 버튼 상태 갱신
    setState(() {
      isAllAgree = isAgreeService && isAgreePersonal;
    });
  }
}
