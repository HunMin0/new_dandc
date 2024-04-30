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
    // _backgroundDynamicLink(context);
    _checkLoginStatus();
    super.initState();
  }

  void _cancelIntroTimer() {
    if (_introTimer != null) {
      _introTimer!.cancel();
    }
  }

  void _onRouter(BuildContext context, Uri? path) {
    if (path != null) {
      String _deeplinkPath = path.path;
      if (_deeplinkPath.isNotEmpty) {
        Map<String, String> _deeplinkQueryParams = path.queryParameters;
        Map<String, String> arguments = {};

        if (path.queryParameters.isNotEmpty) {
          _deeplinkQueryParams.forEach((key, value) {
            arguments[key] = value;
          });
        }
        SharedPrefUtils.getUser().then((user) {
          if (user != null) {
            Navigator.pushNamed(context, _deeplinkPath, arguments: arguments);
          } else {
            Navigator.pushReplacementNamed(context, '/intro');
          }
        });
      } else {
        _checkLoginStatus();
      }
    } else {
      _checkLoginStatus();
    }
  }


  // void _backgroundDynamicLink(BuildContext context) {
  //   FirebaseDynamicLinks.instance.onLink.listen((event) {
  //     _onRouter(context, event.link);
  //   });
  // }

  // Future<void> initialDynamicLink(BuildContext context) async {
  //   PendingDynamicLinkData? _data =
  //   await FirebaseDynamicLinks.instance.getInitialLink();
  //   if (_data != null) {
  //     _onRouter(context, _data.link.path as Uri?);
  //   }
  // }

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