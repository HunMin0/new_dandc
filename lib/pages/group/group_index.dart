import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/pages/group/group_search/group_search_index.dart';
import 'package:Deal_Connect/pages/group/register/register_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GroupIndex extends StatelessWidget {
  const GroupIndex({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.5 - 25;

    final boxStyle = ElevatedButton.styleFrom(
      backgroundColor: SettingStyle.MAIN_COLOR,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 0,
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
    );

    return DefaultLogoLayout(
      titleName: '그룹 찾아보기',
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '그룹에 가입해서\n네트워킹에 참여하세요.',
              style: SettingStyle.TITLE_STYLE,
            ),
            const SizedBox(
              height: 30.0,
            ),
            const SizedBox(
              height: 50.0,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => GroupSearchIndex()),
                      );
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 130, // 버튼의 세로 크기
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: HexColor('#F5F6FA'),
                            borderRadius: BorderRadius.circular(
                                10.0), // 여기서 10.0은 원하는 반지름 값입니다.
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 50.0), // 이미지와 버튼 사이의 간격 조절
                              Text(
                                '그룹 찾기',
                                style: SettingStyle.TITLE_STYLE,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            top: -25,
                            left: 40,
                            child: Image(
                              image: AssetImage(
                                  'assets/images/icons/trade_button_icon_buy.png'),
                              height: 90,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => GroupRegisterIndex()),
                      );
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 130, // 버튼의 세로 크기
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: HexColor('#F5F6FA'),
                            borderRadius: BorderRadius.circular(
                                10.0), // 여기서 10.0은 원하는 반지름 값입니다.
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 50.0), // 이미지와 버튼 사이의 간격 조절
                              Text(
                                '그룹 만들기',
                                style: SettingStyle.TITLE_STYLE,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            top: -25,
                            left: (screenWidth - 70) / 2,
                            child: Image(
                              image: AssetImage(
                                  'assets/images/icons/trade_button_icon_sell.png'),
                              height: 90,
                            )),
                      ],
                    ),
                  ),
                ]
            ),
            SizedBox(
              height: 60,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: HexColor("#75A8E4"),
                  size: 18,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "그룹찾기 Tip",
                  style: SettingStyle.SUB_TITLE_STYLE,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("· "),
                Expanded(child: Text("거래내역 등록 전에 등록하고자 하는 업체를 파트너로 저장해주세요.")),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("· "),
                Expanded(child: Text("거래내역 등록 전에 거래 영수증 등 증빙 자료를 준비해주세요.")),
              ],
            ),
            SizedBox(height: 20.0,),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: boxStyle,
                    onPressed: () {},
                    child: Text(
                      '그룹 이란?',
                      style: SettingStyle.SUB_TITLE_STYLE.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
