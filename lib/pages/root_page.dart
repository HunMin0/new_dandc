import 'dart:async';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
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
    SharedPrefUtils.getUser().then((user) {
      print(user);
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/intro');
      }
    });
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