import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/pages/group/group_manage/group_manage_info.dart';
import 'package:Deal_Connect/pages/group/group_manage/group_manage_parnter.dart';
import 'package:Deal_Connect/pages/group/group_search/group_search_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GroupManageIndex extends StatefulWidget {
  const GroupManageIndex({super.key});

  @override
  State<GroupManageIndex> createState() => _GroupManageIndexState();
}

class _GroupManageIndexState extends State<GroupManageIndex> {
  int? groupId;
  String? groupName;

  var args;

  @override
  void initState() {
    super.initState();

    final widgetsBinding = WidgetsBinding.instance;
    widgetsBinding?.addPostFrameCallback((callback) async {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        setState(() {
          args = ModalRoute.of(context)?.settings.arguments;
        });

        if (args != null) {
          setState(() {
            groupId = args['groupId'];
            groupName = args['groupName'];
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.5 - 25;
    final textStyle = const TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

    return DefaultLogoLayout(
      titleName: groupName,
      isNotInnerPadding: 'true',
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '그룹 정보, 그룹 회원을\n관리해보세요.',
              style: textStyle,
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
                      Navigator.pushNamed(context, '/group/edit',
                          arguments: {
                            "groupId": groupId,
                            "groupName": groupName
                          });
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
                                '그룹정보관리',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
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
                      Navigator.pushNamed(context, '/group/manage/partner',
                          arguments: {
                            "groupId": groupId,
                            "groupName": groupName
                          });
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
                                '파트너 관리',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
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
                ]),
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
                  "그룹관리 Tip",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                Expanded(
                    child: Text("그룹 이미지가 정책과 맞지 않는 경우 통보 없이 삭제 될 수 있습니다.")),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("· "),
                Expanded(child: Text("회원 가입, 방출은 신중하게 해주세요.")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
