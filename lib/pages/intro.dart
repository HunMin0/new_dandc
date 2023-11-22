import 'package:DealConnect/Utils/custom_dialog.dart';
import 'package:DealConnect/Utils/shared_pref_utils.dart';
import 'package:DealConnect/api/auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class IntroPage extends StatefulWidget {
  @override
  IntroPageState createState() => IntroPageState();
}

class IntroPageState extends State<IntroPage> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/sample/sample_intro.jpg"),
            fit: BoxFit.cover
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.7),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                left: 20,
                top: 50,
                child: Image.asset('assets/images/logow.png',width: MediaQuery.of(context).size.width / 2,),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text('함께 공유하고', style: TextStyle(fontSize: 30, color: Colors.white),),
                    ),
                    Container(
                      child: Text('함께 나누며', style: TextStyle(fontSize: 30, color: Colors.white),),
                    ),
                    Container(
                      child: Text('소통과 협업을 하는', style: TextStyle(fontSize: 30, color: Colors.white),),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25, bottom: 50),
                      child: Text('여기는 Deal+Connect', style: TextStyle(fontSize: 15, color: Colors.white),),
                    ),
                    Container(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: HexColor('#75a8e4')
                          ),
                          onPressed: () {
                            CustomDialog.showProgressDialog(context);
                            SharedPrefUtils.clearAccessToken().then((value) {
                              SharedPrefUtils.clearUser().then((value) {
                                CustomDialog.dismissProgressDialog();
                                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                              });
                            });
                          },
                          child: Text('시작하기', style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('이미 사용중이신가요?', style: TextStyle(color: HexColor('#c3c3c3')), textAlign: TextAlign.center,),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                              },
                              child: Text('로그인', style: TextStyle(color: HexColor('#c3c3c3')), textAlign: TextAlign.center,)
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Text('계속 진행시, 서비스 이용약관 및 개인정보 취급방침에 동의하게 됩니다',
                        style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}