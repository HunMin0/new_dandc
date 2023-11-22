import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:DealConnect/components/const/setting_colors.dart';
import 'package:DealConnect/pages/add/add_section.dart';
import 'package:DealConnect/pages/business/business_section.dart';
import 'package:DealConnect/pages/history/history_section.dart';
import 'package:DealConnect/pages/home/home_section.dart';
import 'package:DealConnect/pages/profile/profile_section.dart';

class HomeIndex extends StatefulWidget {
  const HomeIndex({Key? key}) : super(key: key);

  @override
  State<HomeIndex> createState() => _HomePageState();
}

class _HomePageState extends State<HomeIndex> {

  int _currentIndex = 0;
  final _pages = [
    HomeSection(onTab:(){} ), // 메인홈
    const HistorySection(), // 거래내역
    const AddSection(), // 거래추가
    const BusinessSection(), // 사업장찾기
    const ProfileSection(), // 프로필
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false, // safearea까지 먹힌 색을 top은 미적용 처리
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false, // 뒤로가기 버튼 제거처리
            title: GestureDetector(
              onTap: (){
                setState(() {
                  _currentIndex = 0;
                });
              },
              child: Image.asset('assets/images/logo.png', width: 170, fit: BoxFit.contain,),
            ),
            elevation: 0,
            actions: [
              AppBarAction(
                imagePath: 'assets/images/search.png',
                onTap: (){},
              ),
              AppBarAction(
                imagePath: 'assets/images/alarm.png',
                onTap: (){},
              ),
              AppBarAction(
                imagePath: 'assets/images/more.png',
                onTap: (){},
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: _pages[_currentIndex],
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: _onAddMedicien,
            child: const Icon(CupertinoIcons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // floatingAction위치

          bottomNavigationBar: BottomNavigationBar(
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
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0,), // 활성화된 라벨의 텍스트 스타일
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0,), // 비활성화된 라벨의 텍스트 스타일

            items: <BottomNavigationBarItem>[
              _buildBottomItem('assets/images/icons/home_icon', '홈', 0),
              _buildBottomItem('assets/images/icons/history_icon', '거래내역', 1),
              _buildBottomItem('assets/images/icons/add_icon', '거래추가', 2),
              _buildBottomItem('assets/images/icons/business_icon', '사업장찾기', 3),
              _buildBottomItem('assets/images/icons/profile_icon', '프로필', 4),
            ],

          ),
        ),
      ),
    );
  }

  // bottom 네비게이션 영역
  BottomNavigationBarItem _buildBottomItem(String imagePath, String label, int index) {
    return BottomNavigationBarItem(
      icon: _currentIndex == index
          ? ImageIcon(
        AssetImage('$imagePath'+'_over.png'),
        size: 20.0,
      )
          : ImageIcon(
        AssetImage('$imagePath'+'.png'),
        size: 20.0,
      ),
      label: label,
    );
  }

  // 플로팅액션버튼 푸쉬 페이지
  void _onAddMedicien(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddSection()));
  }
}

// 앱바 액션영역
class AppBarAction extends StatelessWidget {
  final String imagePath;
  final Function() onTap;

  const AppBarAction({
    required this.imagePath, required this.onTap, Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Image.asset(imagePath, width: 20, fit: BoxFit.contain,),
      ),
    );
  }
}
