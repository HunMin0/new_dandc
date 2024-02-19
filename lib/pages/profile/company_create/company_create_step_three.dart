import 'dart:convert';
import 'dart:io';

import 'package:Deal_Connect/Utils/custom_dialog.dart';
import 'package:Deal_Connect/api/business.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/components/custom/join_text_form_field.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';

import 'package:Deal_Connect/model/user_business.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:flutter/material.dart';

class CompanyCreateStepThree extends StatefulWidget {
  const CompanyCreateStepThree({super.key});

  @override
  State<CompanyCreateStepThree> createState() => _CompanyCreateStepThreeState();
}

class _CompanyCreateStepThreeState extends State<CompanyCreateStepThree> {
  int userBusinessCategoryId = 0;
  File? imageFile;
  String name = '';
  String phone = '';
  String address1 = '';
  String address2 = '';
  bool hasHoliday = false;
  bool hasWeekend = true;
  String workTime = '';
  String holiday = '';
  String weekend = '';

  bool isProcessable = true;
  final GlobalKey<FormState> _companyFormKey = GlobalKey<FormState>();
  bool isHomepage = false;
  String website = '';

  final List<String> keywords = [];
  final TextEditingController _controller = TextEditingController();

  void _addKeyword() {
    final text = _controller.text;
    if (text.isNotEmpty && keywords.length < 10) {
      setState(() {
        keywords.add(text);
        _controller.clear();
      });
    }
  }

  void _removeKeyword(String keyword) {
    setState(() {
      keywords.remove(keyword);
    });
  }


  var args;

  @override
  void initState() {
    super.initState();

    final widgetsBinding = WidgetsBinding.instance;
    widgetsBinding?.addPostFrameCallback((callback) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        args = ModalRoute.of(context)?.settings.arguments;
        if (args != null) {
          setState(() {
            userBusinessCategoryId = args['userBusinessCategoryId'];
            imageFile = args['imageFile'];
            name = args['name'];
            phone = args['phone'];
            address1 = args['address1'];
            address2 = args['address2'];
            hasHoliday = args['hasHoliday'];
            hasWeekend = args['hasWeekend'];
            workTime = args['workTime'];
            holiday = args['holiday'];
            weekend = args['weekend'];
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1.0,
      ),
    );

    final bottomTextStyle = TextStyle(
      color: Color(0xFF232323),
      fontSize: 14.0,
      //fontWeight: FontWeight.w600
    );


    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: DefaultNextLayout(
        titleName: '업체등록',
        isProcessable: isProcessable,
        bottomBar: true,
        isCancel: false,
        prevTitle: '취소',
        nextTitle: '등록 완료하기',
        prevOnPressed: () {},
        nextOnPressed: () {
          if (_companyFormKey.currentState!.validate()) {
            // 유효한 경우 실행할 코드 추가
            _submit();
            //_showCompleteDialog(context);
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _companyFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  '검색 키워드',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.0,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _showKeyWordsDialog(context);
                                  },
                                  child: CircleAvatar(
                                    child: Icon(
                                      Icons.question_mark,
                                      size: 10.0,
                                      color: Colors.white,
                                    ),
                                    radius: 8.0,
                                    backgroundColor: Color(0xFF75A8E4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              fillColor: INPUT_BG_COLOR,
                              filled: true,
                              // fillColor에 배경색이 있을 경우 색상반영, false 미적용
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
                              contentPadding: EdgeInsets.all(12.0),
                              // 필드 패딩
                              labelText: '키워드 추가',
                              suffixIcon: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: _addKeyword,
                              ),
                            ),
                            onSubmitted: (value) => _addKeyword(),
                          ),
                          SizedBox(height: 10),
                          Wrap(
                            spacing: 8.0, // 각 Chip의 간격
                            children: keywords
                                .map((keyword) => Chip(
                              label: Text(keyword),
                              onDeleted: () => _removeKeyword(keyword),
                            ))
                                .toList(),
                          ),
                        ],
                      ),
                      _buildHomePage(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _submit() async {
    CustomDialog.showProgressDialog(context);

    storeUserBusiness({
      'user_business_category_id': userBusinessCategoryId,
      'name': name,
      'phone': phone,
      'address1': address1,
      'address2': address2,
      'has_holiday': hasHoliday,
      'has_weekend': hasWeekend,
      'work_time': workTime,
      'holiday': holiday,
      'weekend': weekend,
      'website': website,
      'keywords': jsonEncode(keywords),
    }, imageFile).then((response) async {
      CustomDialog.dismissProgressDialog();

      if (response.status == 'success') {
        UserBusiness userBusiness = UserBusiness.fromJSON(response.data);

        if (userBusiness.has_owner != null) {
          await SharedPrefUtils.setUser(userBusiness.has_owner!);
        }
        _showCompleteDialog(context);
      } else {
        CustomDialog.showServerValidatorErrorMsg(response);
      }
    });
  }

  void _showCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowCompleteDialog(
          messageTitle: '업체등록완료',
          messageText: '등록이 완료되었습니다.',
          buttonText: '확인',
          onConfirmed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        );
      },
    );
  }

  Column _buildHomePage() {
    final homePageButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: isHomepage == true ? Colors.white : Color(0xFFABABAB),
      backgroundColor: isHomepage == true ? Color(0xFF75A8E4) : Colors.white,
      side: BorderSide(
        color: isHomepage == true ? Color(0xFF75A8E4) : Color(0xFFD9D9D9),
        width: 1.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      fixedSize: Size.fromHeight(50.0),
      elevation: 0,
    );

    final noHomePageButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: isHomepage == false ? Colors.white : Color(0xFFABABAB),
      backgroundColor: isHomepage == false ? Color(0xFF75A8E4) : Colors.white,
      side: BorderSide(
        color: isHomepage == false ? Color(0xFF75A8E4) : Color(0xFFD9D9D9),
        width: 1.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      fixedSize: Size.fromHeight(50.0),
      elevation: 0,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15.0,
        ),
        Text(
          '웹사이트',
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    style: homePageButtonStyle,
                    onPressed: () {
                      setState(() {
                        isHomepage = true;
                      });
                    },
                    child: Text(
                      '웹사이트가 있어요',
                      style: TextStyle(fontSize: 13.0),
                    ))),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
                child: ElevatedButton(
                    style: noHomePageButtonStyle,
                    onPressed: () {
                      setState(() {
                        isHomepage = false;
                      });
                    },
                    child: Text(
                      '웹사이트가 없어요',
                      style: TextStyle(fontSize: 13.0),
                    ))),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        if (isHomepage)
          BasicJoinTextFormField(
              hintText: '여기를 눌러 웹사이트 입력',
              onChanged: (String value) {
                website = value;
              }),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

void _showKeyWordsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Colors.white,
        actionsPadding: EdgeInsets.all(14.0),
        contentPadding: EdgeInsets.all(14.0),
        title: Column(
          children: [
            CircleAvatar(
              child: Icon(
                Icons.question_mark,
                size: 16.0,
                color: Colors.white,
              ),
              radius: 13.0,
              backgroundColor: Color(0xFF75A8E4),
            ),
            SizedBox(
              height: 7.0,
            ),
            Text(
              '키워드란?',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Container(
          height: 415.0,
          child: Column(
            children: [
              Text(
                '업체 검색시에 사용되며 내 업체를 쉽게\n표현 할 수 있는 형식이예요!\n아래와 같이 표시가 되며 키워드 등록은\n필수 입니다!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '예) 서초구, 당일배달, 꽃배달',
                style: TextStyle(
                  color: Color(0xFFABABAB),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Container(
                width: 220.0,
                padding: EdgeInsets.symmetric(vertical: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: Color(0xffD9D9D9),
                  ),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      //overflow: Overflow.visible,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 170,
                          height: 170,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/sample/main_sample05.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        Positioned(
                          right: -8.0,
                          bottom: -20.0,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3.0,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 34.0,
                              backgroundImage: AssetImage(
                                  'assets/images/sample/main_sample_avater.jpg'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Text('청년 한다발 서초점'),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildKeyText(text: '#서초구'),
                        SizedBox(
                          width: 5.0,
                        ),
                        _buildKeyText(text: '#당일배달'),
                        SizedBox(
                          width: 5.0,
                        ),
                        _buildKeyText(text: '#꽃배달'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF75A8E4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  child: Text(
                    '확인',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}

class _buildKeyText extends StatelessWidget {
  final String text;

  const _buildKeyText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFf5f6fa),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 7.0),
        child: Text(
          text,
          style: TextStyle(
              color: Color(0xFF5f5f66),
              fontSize: 11.0,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
