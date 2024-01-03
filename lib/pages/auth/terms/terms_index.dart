import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/pages/auth/join/join_index.dart';
import 'package:Deal_Connect/pages/auth/terms/privacy_terms.dart';
import 'package:Deal_Connect/pages/auth/terms/terms_of_use.dart';
import 'package:flutter/material.dart';

class TermsIndex extends StatefulWidget {
  const TermsIndex({Key? key}) : super(key: key);

  @override
  _TermsIndexState createState() => _TermsIndexState();
}

class _TermsIndexState extends State<TermsIndex> {
  bool allAgreed = false;
  bool termAgreed = false;
  bool privacyAgreed = false;
  bool ageVerification = false;

  @override
  Widget build(BuildContext context) {
    return DefaultLogoLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              children: [
                TextSpan(
                  text: '서비스가 처음이시군요\n',
                ),
                TextSpan(
                  text: '약관내용에 동의',
                  style: TextStyle(color: PRIMARY_COLOR), // 파란색으로 처리
                ),
                TextSpan(
                  text: '해주세요',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Expanded(
            child: Column(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    setState(() {
                      allAgreed = !allAgreed;
                      termAgreed = allAgreed;
                      privacyAgreed = allAgreed;
                      ageVerification = allAgreed;
                      checkNextButtonState(); // 변경된 상태를 확인하여 버튼 갱신
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 18.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFf8f9fb),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '전체동의',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: PRIMARY_COLOR,
                          ),
                        ),
                        Container(
                          width: 26,
                          height: 26,
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: allAgreed ? PRIMARY_COLOR : Color(0xFFDDDDDD),
                                width: 2.0),
                            color: allAgreed
                                ? PRIMARY_COLOR
                                : Colors.transparent, // 클릭 시 배경색 변경
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent, // 이 부분 수정
                            child: Icon(
                              Icons.check,
                              size: 16.0,
                              color:
                                  allAgreed ? Colors.white : Color(0xFFDDDDDD),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 14.0),
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
                        child: _termsText(
                          underText: '이용약관',
                          subText: ' (필수)',
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(20.0),
                        onTap: () {
                          setState(() {
                            termAgreed = !termAgreed;
                            if (!termAgreed) {
                              allAgreed = false;
                            }
                            checkNextButtonState(); // 변경된 상태를 확인하여 버튼 갱신
                          });
                        },
                        child: _checkType(termAgreed: termAgreed),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 14.0),
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
                        child: _termsText(
                          underText: '개인정보 수집 이용',
                          subText: ' (필수)',
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(20.0),
                        onTap: () {
                          setState(() {
                            privacyAgreed = !privacyAgreed;
                            if (!privacyAgreed) {
                              allAgreed = false;
                            }
                            checkNextButtonState(); // 변경된 상태를 확인하여 버튼 갱신
                          });
                        },
                        child: _checkType(termAgreed: privacyAgreed),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _termsText(
                          underText: '만 14세 이상 확인',
                          subText: ' (필수)',
                          showUnderline: false,
                        ),
                      InkWell(
                        borderRadius: BorderRadius.circular(20.0),
                        onTap: () {
                          setState(() {
                            ageVerification = !ageVerification;
                            if (!ageVerification) {
                              allAgreed = false;
                            }
                            checkNextButtonState(); // 변경된 상태를 확인하여 버튼 갱신
                          });
                        },
                        child: _checkType(termAgreed: ageVerification),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          TextButton(
            onPressed: allAgreed
                ? () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            JoinIndex(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                              position: offsetAnimation, child: child);
                        },
                      ),
                    );
                  }
                : null,
            style: TextButton.styleFrom(
              backgroundColor: allAgreed
                  ? PRIMARY_COLOR
                  : Colors.grey[300], // 버튼 상태에 따라 색상 조정
              padding: EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Container(
              width: double.infinity,
              child: Center(
                child: Text(
                  '다음',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkNextButtonState() {
    // (필수) 약관들이 모두 동의되었는지 확인하여 버튼 상태 갱신
    setState(() {
      allAgreed = termAgreed && privacyAgreed && ageVerification;
    });
  }
}

class _termsText extends StatelessWidget {
  final String underText;
  final String subText;
  final bool showUnderline;

  const _termsText({
    this.showUnderline = true,
    required this.underText,
    required this.subText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
          children: [
            TextSpan(
              text: underText,
              style: TextStyle(
                decoration:
                showUnderline
                ? TextDecoration.underline
                : TextDecoration.none,
                decorationThickness: 2.0,
              ),
            ),
            TextSpan(
              text: subText,
            ),
          ]),
    );
  }
}

class _checkType extends StatelessWidget {
  const _checkType({
    Key? key,
    required this.termAgreed,
  }) : super(key: key);

  final bool termAgreed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: termAgreed ? PRIMARY_COLOR : Color(0xFFDDDDDD), width: 2.0),
        color: termAgreed ? PRIMARY_COLOR : Colors.transparent, // 클릭 시 배경색 변경
      ),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.check,
          size: 16.0,
          color: termAgreed ? Colors.white : Color(0xFFDDDDDD),
        ),
      ),
    );
  }
}
