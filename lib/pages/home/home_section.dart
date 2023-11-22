import 'package:DealConnect/Utils/shared_pref_utils.dart';
import 'package:DealConnect/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:DealConnect/pages/add/add_section.dart';
import 'package:DealConnect/pages/home/group_card.dart';
import 'package:DealConnect/pages/home/list_card.dart';

class HomeSection extends StatefulWidget {
  Function onTab;

  HomeSection({required this.onTab, Key? key}) : super(key: key);

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  var navHeight = 0.0;
  User? myUser;

  @override
  void initState() {
    _initMyUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle('그룹'),
            SizedBox(height: 20.0,),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Container(
                height: 130.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    // map으로 GroupCard 반복처리
                    GroupCard(
                        imagePath: 'assets/images/sample/main_sample01.jpg',
                        title: '서초구 고기집 사장모임',
                        category: '미식/친목',
                        memberCount: 37),
                    GroupCard(
                        imagePath: 'assets/images/sample/main_sample02.jpg',
                        title: '골프여신이 함께해요',
                        category: '스포츠/레져',
                        memberCount: 143),
                    GroupCard(
                        imagePath: 'assets/images/sample/main_sample03.jpg',
                        title: '수학의정석 시즌1',
                        category: '교육/레슨',
                        memberCount: 60),
                    GroupCard(
                        imagePath: 'assets/images/sample/main_sample04.jpg',
                        title: '골프는 자세가 중요해',
                        category: '공부/학습',
                        memberCount: 54),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            _buildTitle('파트너'),
            SizedBox(height: 12.0,),
            _partnerBanner(context, 8), // 파트너 배너상태
            SizedBox(height: 16.0,),
          ],
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFf5f6f8),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 14.0, left: 14.0, right: 14.0,),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  // map으로 ListCard 반복처리
                  ListCard(
                    avaterImagePath: 'assets/images/sample/main_sample_avater.jpg',
                    bgImagePath: 'assets/images/sample/main_sample05.jpg',
                    companyName: '청년 한다발 서초점',
                    userName: '김훈민',
                    tagList: ['#서초구','#당일배달','#꽃다발'],
                    newMark: true,
                  ),
                  ListCard(
                    avaterImagePath: 'assets/images/sample/main_sample_avater2.jpg',
                    bgImagePath: 'assets/images/sample/main_sample06.jpg',
                    companyName: '골프여신 내동점',
                    userName: '임성택',
                    tagList: ['#사전예약','#당일레슨','#하우스'],
                    newMark: false,
                  ),
                  ListCard(
                    avaterImagePath: 'assets/images/sample/main_sample_avater3.jpg',
                    bgImagePath: 'assets/images/sample/main_sample07.jpg',
                    companyName: '헬스청년 괴정점',
                    userName: '이규봉',
                    tagList: ['#1:1','#개인PT','#신규환영'],
                    newMark: false,
                  ),
                  ListCard(
                    avaterImagePath: 'assets/images/sample/main_sample_avater4.jpeg',
                    bgImagePath: 'assets/images/sample/main_sample08.jpg',
                    companyName: '청년 한다발 서초점',
                    userName: '홍길동',
                    tagList: ['#서초구','#당일배달','#꽃다발'],
                    newMark: false,
                  ),
                  ListCard(
                    avaterImagePath: 'assets/images/sample/main_sample_avater5.png',
                    bgImagePath: 'assets/images/sample/main_sample09.jpg',
                    companyName: '청년 한다발 서초점',
                    userName: '홍길순',
                    tagList: ['#서초구','#당일배달','#꽃다발'],
                    newMark: false,
                  ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding _buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
    );
  }

  InkWell _partnerBanner(BuildContext context, int waitingCount) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddSection()), // 배너 클릭 이동화면
        );
      },
      child: Padding(
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
                  Icon(Icons.check_circle, size: 24.0, color: Color(0xFF75a8e4),),
                  SizedBox(width: 14.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$waitingCount개의 신규거래내역 승인을 기다리고 있어요!', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: Color(0xFF6f6f6f)),),
                      SizedBox(height: 4.0,),
                      Text('신규 거래내역 보러가기', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),),
                    ],
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, size: 16.0,),
            ],
          ),
        ),
      ),
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
