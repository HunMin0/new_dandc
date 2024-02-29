import 'dart:async';
import 'package:Deal_Connect/api/auth.dart';
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

    _checkLoginStatus();

    super.initState();
  }

  void _cancelIntroTimer() {
    if (_introTimer != null) {
      _introTimer!.cancel();
    }
  }

  Future<void> _checkLoginStatus() async {
    SharedPrefUtils.getUser().then((user) {
      if (user != null) {
        refreshFcmToken().then((value) {});
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

        ),
      ),
    );
  }
}