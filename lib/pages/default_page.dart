import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/pages/business/business_index.dart';
import 'package:Deal_Connect/pages/history/history_index.dart';
import 'package:Deal_Connect/pages/home/home_index.dart';
import 'package:Deal_Connect/pages/notice/notice_index.dart';
import 'package:Deal_Connect/pages/profile/profile_index.dart';
import 'package:Deal_Connect/pages/search/search_index.dart';
import 'package:Deal_Connect/pages/search/search_partner_list.dart';
import 'package:Deal_Connect/pages/trade/trade_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'group/group_index.dart';

class DefaultPage extends StatefulWidget {
  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final pageController = PageController();

  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;
  late final List<Widget> _children;
  DateTime? lastPressed;
  bool canPop = false;

  @override
  void initState() {
    super.initState();
    _children = [
      HomeIndex(onTab: _onTap),
      HistoryIndex(),
      TradeIndex(),
      BusinessIndex(),
      ProfileIndex(onTab: _onTap),
    ];
  }

  void _onTap(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    const maxDuration = Duration(seconds: 2);
    final isWarning = lastPressed == null || now.difference(lastPressed!) > maxDuration;

    if (isWarning) {
      lastPressed = DateTime.now();
      Fluttertoast.showToast(msg: '한 번 더 누르면 종료됩니다.');

      return false; // 이전 화면으로 이동하지 않음
    } else {
      return true; // 앱 종료
    }
  }


  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 13.0,
    );

    return PopScope(
      canPop: canPop,
      onPopInvoked: (bool didPop) {
        setState(() {
          canPop= !didPop;
        });
        if (canPop) {
          _onWillPop();
        }
      },
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Container(
          color: Colors.white,
          child: SafeArea(
            top: false, // safearea까지 먹힌 색을 top은 미적용 처리
            child: Scaffold(
              key: _scaffoldKey,
              appBar: renderAppBar(),
              body: PageView(
                controller: pageController,
                onPageChanged: onPageChanged,
                children: _children,
                physics: NeverScrollableScrollPhysics(), // No
              ),
              bottomNavigationBar: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: BottomNavigationBar(
                    backgroundColor: SettingColors.primaryMeterialColor,
                    elevation: 0,
                    onTap: _onTap,
                    currentIndex: _selectedIndex,
                    selectedItemColor: Color(0xFF3c3c3c),
                    unselectedItemColor: Color(0xFFc3c3c3),
                    type: BottomNavigationBarType.fixed,
                    selectedLabelStyle: textStyle,
                    unselectedLabelStyle: textStyle,

                    items: <BottomNavigationBarItem>[
                      _buildBottomItem('home_icon', '홈', 0),
                      _buildBottomItem('history_icon', '거래내역', 1),
                      _buildBottomItem('add_icon', '거래추가', 2),
                      _buildBottomItem('business_icon', '사업장찾기', 3),
                      _buildBottomItem('profile_icon', '프로필', 4),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  // AppBar 영역
  AppBar renderAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      title: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = 0;
          });
        },
        child: Image.asset(
          'assets/images/logo.png',
          width: 170,
          fit: BoxFit.contain,
        ),
      ),
      elevation: 0,
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => SearchIndex()));
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.0),
            child: Icon(
              CupertinoIcons.search,
              size: 28,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => NoticeIndex()));
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.0),
            child: Icon(
              CupertinoIcons.bell,
              size: 28,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/more');
            },
            icon: Icon(
              CupertinoIcons.ellipsis_vertical,
              size: 28,
            )),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  // bottom 네비게이션 상태변화
  BottomNavigationBarItem _buildBottomItem(
      String imagePath, String label, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        height: 30,
        padding: EdgeInsets.only(bottom: 5),
        child: _selectedIndex == index
            ? ImageIcon(
                AssetImage('assets/images/icons/$imagePath' + '_over.png'),
                size: 22.0,
              )
            : ImageIcon(
                AssetImage('assets/images/icons/$imagePath.png'),
                size: 22.0,
              ),
      ),
      label: label,
    );
  }

  // Floating 액션 버튼
  _renderFloatingActionButton() {
    if (_selectedIndex == 0) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => GroupIndex()));
        },
        backgroundColor: PRIMARY_COLOR,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      );
    } else {
      return null;
    }
  }
}

// AppBar 액션 영역
class _AppBarAction extends StatelessWidget {
  final String imagePath;
  final Function() onTap;

  const _AppBarAction({required this.imagePath, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Image.asset(
          'assets/images/$imagePath.png',
          width: 20,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
