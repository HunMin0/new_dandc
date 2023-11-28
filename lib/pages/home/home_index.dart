import 'package:Deal_Connect/pages/business/business_index.dart';
import 'package:flutter/material.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/Utils/shared_pref_utils.dart';
import 'package:Deal_Connect/pages/home/components/group_card.dart';
import 'package:Deal_Connect/pages/home/components/list_card.dart';

// 메인홈
class HomeIndex extends StatefulWidget {
  const HomeIndex({Key? key}) : super(key: key);

  @override
  State<HomeIndex> createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  User? myUser;

  @override
  void initState() {
    _initMyUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitle('그룹'),
                      _HorizontalList(),
                      SizedBox(
                        height: 20.0,
                      ),
                      _buildTitle('파트너'),
                      _partnerBanner(context, 8), // 파트너 배너상태
                      SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ];
      },
      body: _VerticalList(),
    );
  }

  // 공통 타이틀
  Padding _buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 14.0,
          ),
        ],
      ),
    );
  }

  // 파트너 배너
  InkWell _partnerBanner(BuildContext context, int waitingCount) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BusinessIndex()), // 배너 클릭 이동화면
        );
      },
      child: _partnerBannerStyle(waitingCount: 8),
    );
  }

  void _initMyUser() {
    SharedPrefUtils.getUser().then((value) {
      setState(() {
        myUser = value;
      });
    });
  }

  @override
  void dispose() {
    // marketingVideoControllers.forEach((controller) {
    //   controller.dispose();
    // });
    super.dispose();
  }
}

// 회원 가로 리스트
class _HorizontalList extends StatelessWidget {
  _HorizontalList ({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> groupDataList = [
    {
      'imagePath': 'main_sample01',
      'title': '서초구 고기집 사장모임',
      'category': '미식/친목',
      'memberCount': 37,
      'link':'#',
    },
    {
      'imagePath': 'main_sample02',
      'title': '골프여신이 함께해요',
      'category': '스포츠/레져',
      'memberCount': 143,
      'link':'#',
    },
    {
      'imagePath': 'main_sample03',
      'title': '수학의정석 시즌1',
      'category': '교육/레슨',
      'memberCount': 60,
      'link':'#',
    },
    {
      'imagePath': 'main_sample04',
      'title': '골프는 자세가 중요해',
      'category': '공부/학습',
      'memberCount': 54,
      'link':'#',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        height: 130.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: groupDataList.length,
          itemBuilder: (context, index){
            Map<String, dynamic> groupData = groupDataList[index];

            return GestureDetector(
              onTap: (){
                print('클릭됨');
              },
              child: GroupCard(
                imagePath: groupData['imagePath'],
                title: groupData['title'],
                category: groupData['category'],
                memberCount: groupData['memberCount'],
              ),
            );
          },
        ),
      ),
    );
  }
}

// 파트너 배너 디자인
class _partnerBannerStyle extends StatelessWidget {
  final int waitingCount;

  const _partnerBannerStyle({
    required this.waitingCount,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFf5f6fa),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 24.0,
                  color: Color(0xFF75a8e4),
                ),
                SizedBox(
                  width: 14.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$waitingCount개의 신규거래내역 승인을 기다리고 있어요!',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6f6f6f)),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      '신규 거래내역 보러가기',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}

// 회원 세로 리스트
class _VerticalList extends StatelessWidget {
  _VerticalList({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> verticalDataList = [
    {
      'avaterImagePath':'main_sample_avater',
      'bgImagePath': 'main_sample05',
      'companyName': '청년 한다발 서초점',
      'userName': '김훈민',
      'tagList': ['#서초구', '#당일배달', '#꽃다발'],
      'newMark': true,
      'link':'#',
    },
    {
      'avaterImagePath':'main_sample_avater2',
      'bgImagePath': 'main_sample06',
      'companyName': '골프여신 내동점',
      'userName': '임성택',
      'tagList': ['#사전예약', '#당일레슨', '#하우스'],
      'newMark': false,
      'link':'#',
    },
    {
      'avaterImagePath':'main_sample_avater3',
      'bgImagePath': 'main_sample07',
      'companyName': '헬스청년 괴정점',
      'userName': '이규봉',
      'tagList': ['#1:1', '#개인PT', '#신규환영'],
      'newMark': false,
      'link':'#',
    },
    {
      'avaterImagePath':'main_sample_avater2',
      'bgImagePath': 'main_sample08',
      'companyName': '청년 한다발 서초점',
      'userName': '홍길동',
      'tagList': ['#서초구', '#당일배달', '#꽃다발'],
      'newMark': false,
      'link':'#',
    },
    {
      'avaterImagePath':'main_sample_avater',
      'bgImagePath': 'main_sample09',
      'companyName': '청년 한다발 서초점',
      'userName': '홍길순',
      'tagList': ['#서초구', '#당일배달', '#꽃다발'],
      'newMark': false,
      'link':'#',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFf5f6f8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 14.0,
          left: 14.0,
          right: 14.0,
        ),
        child: ListView.builder(
          itemCount: verticalDataList.length,
          itemBuilder: (context, index){
            Map<String, dynamic> verticalData = verticalDataList[index];

            return GestureDetector(
              onTap: (){
                print('클릭했다~');
              },
              child: ListCard(
                avaterImagePath: verticalData['avaterImagePath'],
                bgImagePath: verticalData['bgImagePath'],
                companyName: verticalData['companyName'],
                userName: verticalData['userName'],
                tagList: verticalData['tagList'],
                newMark: verticalData['newMark'],
              ),
            );
          },
        ),
      ),
    );
  }
}
