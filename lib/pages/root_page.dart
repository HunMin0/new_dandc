import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootPage extends StatefulWidget {
  @override
  RootPageState createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  Timer? _introTimer;

  @override
  void initState() {
    // refreshFcmToken().then((value) {});

    _startIntroTimer();

    super.initState();
  }

  void _startIntroTimer() {
    _cancelIntroTimer();
    _introTimer = Timer(const Duration(seconds: 3), () {
      _checkLoginStatus();
    });
  }

  void _cancelIntroTimer() {
    if (_introTimer != null) {
      _introTimer!.cancel();
    }
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // 이미 로그인된 경우 홈 화면으로 이동
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // 로그인되어 있지 않은 경우 로그인 화면으로 이동
      Navigator.pushReplacementNamed(context, '/intro');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#75a8e4'),
      body: SafeArea(
        child: SizedBox(
          /*
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GifView.asset(
            'assets/images/intro.gif',
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.height,
            frameRate: 15,
            loop: false,
          ),
          */
        ),
      ),
    );
  }
}