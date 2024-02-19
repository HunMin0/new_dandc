import 'package:Deal_Connect/Utils/custom_dialog.dart';
import 'package:Deal_Connect/Utils/shared_pref_utils.dart';
import 'package:Deal_Connect/pages/auth/terms/terms_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class IntroIndex extends StatelessWidget {
  const IntroIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/sample/sample_intro.jpg"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.7),
        body: SafeArea(
          child: Stack(
            children: [
              _IntroLogo(context),
              _IntroText(context),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _IntroLogo(BuildContext context) {
    return Positioned(
      left: 20,
      top: 50,
      child: Image.asset(
        'assets/images/logow.png',
        width: MediaQuery.of(context).size.width / 2,
      ),
    );
  }

  Container _IntroText(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 30.0,
      color: Colors.white,
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '함께 공유하고',
            style: textStyle,
          ),
          Text(
            '함께 나누며',
            style: textStyle,
          ),
          Text(
            '소통과 협업을 하는',
            style: textStyle,
          ),
          Container(
            margin: EdgeInsets.only(top: 25, bottom: 50),
            child: Text(
              '여기는 Deal+Connect',
              style: textStyle.copyWith(
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF75a8e4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    )),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/register/terms');
                },
                child: Text(
                  '시작하기',
                  style: textStyle.copyWith(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '이미 사용중이신가요?',
                  style: textStyle.copyWith(
                    color: HexColor('#c3c3c3'),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    },
                    child: Text(
                      '로그인',
                      style: textStyle.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
          SizedBox(height: 80,)
        ],
      ),
    );
  }
}
