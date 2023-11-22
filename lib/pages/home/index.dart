import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import 'home.dart';

/* BU 파일 */

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}


class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _backPressCnt = 0;
  int _selectedIndex = 0;
  Timer? _resetBackPressCntTimer;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    _widgetOptions = <Widget>[
      Home(onTab: _onTab),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        key: _scaffoldKey,
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == 0 ? 'assets/images/bottom-nav-1-active-icon.png' : 'assets/images/bottom-nav-1-inactive-icon.png',
                width: 30,
                height: 30,
              ),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == 1 ? 'assets/images/bottom-nav-2-active-icon.png' : 'assets/images/bottom-nav-2-inactive-icon.png',
                width: 30,
                height: 30,
              ),
              label: '공간찾기',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == 2 ? 'assets/images/bottom-nav-3-active-icon.png' : 'assets/images/bottom-nav-3-inactive-icon.png',
                width: 30,
                height: 30,
              ),
              label: '인테리어',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == 3 ? 'assets/images/bottom-nav-4-active-icon.png' : 'assets/images/bottom-nav-4-inactive-icon.png',
                width: 30,
                height: 30,
              ),
              label: '채팅',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == 4 ? 'assets/images/bottom-nav-5-active-icon.png' : 'assets/images/bottom-nav-5-inactive-icon.png',
                width: 30,
                height: 30,
              ),
              label: '마이페이지',
            ),
          ],
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          selectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          selectedItemColor: HexColor('#293bf0'),
          onTap: _onTab,
        ),
      ),
      onWillPop: () async {
        if (_scaffoldKey.currentState!.isEndDrawerOpen) {
          _scaffoldKey.currentState!.openDrawer();
        } else {
          _startBackPressCntResetTimer();
          _backPressCnt++;

          if (_backPressCnt == 1) {
            Fluttertoast.showToast(msg: '한 번 더 누르면 종료됩니다.');
          } else if (_backPressCnt > 1) {
            return true;
          }
        }
        return false;
      },
    );
  }

  _onTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _startBackPressCntResetTimer() {
    _cancelBackPressCntResetTimer();
    _resetBackPressCntTimer = Timer(const Duration(seconds: 2), () {
      _backPressCnt = 0;
    });
  }

  void _cancelBackPressCntResetTimer() {
    if (_resetBackPressCntTimer != null) {
      _resetBackPressCntTimer!.cancel();
    }
  }
}