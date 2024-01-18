import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/custom/join_text_form_field.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:flutter/material.dart';

class CompanyAddStepThree extends StatefulWidget {
  const CompanyAddStepThree({super.key});

  @override
  State<CompanyAddStepThree> createState() => _CompanyAddStepThreeState();
}

class _CompanyAddStepThreeState extends State<CompanyAddStepThree> {
  bool isProcessable = true;
  final GlobalKey<FormState> _companyFormKey = GlobalKey<FormState>();
  List<String> keywords = List.filled(3, '');
  bool isHomepage = false;
  String homepageData = '';

  @override
  Widget build(BuildContext context) {
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

            _showCompleteDialog(context);
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
                      Text(
                        '키워드를 등록해주세요.\n키워드는 최대 3개까지 가능합니다.',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      _buildKeyWords(keywords: keywords),
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
                homepageData = value;
              }),
      ],
    );
  }
}

class _buildKeyWords extends StatelessWidget {
  const _buildKeyWords({
    super.key,
    required this.keywords,
  });

  final List<String> keywords;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '키워드',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: 4.0,
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
        SizedBox(
          height: 12.0,
        ),
        for (int i = 0; i < 3; i++)
          BasicJoinTextFormField(
            hintText: '여기를 눌러 키워드 입력',
            onChanged: (String value) {
              keywords[i] = value;
            },
          ),
      ],
    );
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
                style: TextStyle(color: Color(0xFFABABAB), fontSize: 13.0, fontWeight: FontWeight.w700,),
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
                    SizedBox(height: 25.0,),
                    Text('청년 한다발 서초점'),
                    SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildKeyText(text: '#서초구'),
                        SizedBox(width: 5.0,),
                        _buildKeyText(text: '#당일배달'),
                        SizedBox(width: 5.0,),
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
