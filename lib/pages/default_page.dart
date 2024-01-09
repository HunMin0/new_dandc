import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/pages/business/business_index.dart';
import 'package:Deal_Connect/pages/history/history_index.dart';
import 'package:Deal_Connect/pages/home/home_index.dart';
import 'package:Deal_Connect/pages/profile/profile_index.dart';
import 'package:Deal_Connect/pages/transaction/transaction_index.dart';
import 'package:flutter/material.dart';

import 'group/group_index.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  int _currentIndex = 0;
  final _pages = [
    HomeIndex(), // 메인홈
    HistoryIndex(), // 거래내역
    TransactionIndex(), // 거래추가
    BusinessIndex(), // 사업장찾기
    ProfileIndex(), // 프로필
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false, // safearea까지 먹힌 색을 top은 미적용 처리
        child: Scaffold(
          appBar: renderAppBar(),
          floatingActionButton: _renderFloatingActionButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // floatingAction위치
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: _pages[_currentIndex],
          ),
          bottomNavigationBar: renderBottomNavigationBar(),
        ),
      ),
    );
  }

  // AppBar 영역
  AppBar renderAppBar(){
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false, // 뒤로가기 버튼 제거처리
      scrolledUnderElevation: 0, // 스크롤시 배경색이 강제되는거 해제
      title: GestureDetector(
        onTap: (){
          setState(() {
            _currentIndex = 0;
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
        _AppBarAction(
          imagePath: 'search',
          onTap: () {},
        ),
        _AppBarAction(
          imagePath: 'alarm',
          onTap: () {},
        ),
        _AppBarAction(
          imagePath: 'more',
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
      ],
    );
  }

  // BottomNavigation 영역
  BottomNavigationBar renderBottomNavigationBar(){
    final textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12.0,
    );

    return BottomNavigationBar(
      backgroundColor: SettingColors.primaryMeterialColor,
      elevation: 0,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      currentIndex: _currentIndex, // 선택된 인덱스의 값을 얻는다
      selectedItemColor: Color(0xFF3c3c3c),
      unselectedItemColor: Color(0xFFc3c3c3),
      type: BottomNavigationBarType.fixed, // 라벨의 텍스트 노출
      selectedLabelStyle: textStyle, // 활성화된 라벨의 텍스트 스타일
      unselectedLabelStyle: textStyle, // 비활성화된 라벨의 텍스트 스타일

      items: <BottomNavigationBarItem>[
        _buildBottomItem('home_icon', '홈', 0),
        _buildBottomItem('history_icon', '거래내역', 1),
        _buildBottomItem('add_icon', '거래추가', 2),
        _buildBottomItem('business_icon', '사업장찾기', 3),
        _buildBottomItem('profile_icon', '프로필', 4),
      ],

    );
  }

  // bottom 네비게이션 상태변화
  BottomNavigationBarItem _buildBottomItem(String imagePath, String label, int index) {
    return BottomNavigationBarItem(
      icon: _currentIndex == index
          ? ImageIcon(
        AssetImage('assets/images/icons/$imagePath'+'_over.png'),
        size: 20.0,
      )
          : ImageIcon(
        AssetImage('assets/images/icons/$imagePath.png'),
        size: 20.0,
      ),
      label: label,
    );
  }

  // Floating 액션 버튼
   _renderFloatingActionButton() {
    if(_currentIndex == 0){
      return FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)
          => GroupIndex()));
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
