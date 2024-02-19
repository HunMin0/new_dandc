import 'package:Deal_Connect/api/main.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/list_user_card.dart';
import 'package:Deal_Connect/db/vertical_data.dart';
import 'package:Deal_Connect/model/group.dart';
import 'package:Deal_Connect/model/trade.dart';
import 'package:Deal_Connect/pages/group/group_index.dart';
import 'package:Deal_Connect/pages/history/history_detail/history_detail_index.dart';
import 'package:Deal_Connect/pages/profile/other_profile.dart';
import 'package:Deal_Connect/pages/search/search_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/Utils/shared_pref_utils.dart';
import 'package:Deal_Connect/pages/home/components/group_card.dart';
import 'package:Deal_Connect/components/list_card.dart';

// 메인홈
class HomeIndex extends StatefulWidget {
  Function onTab;

  HomeIndex({Key? key, required this.onTab}) : super(key: key);

  @override
  State<HomeIndex> createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  User? myUser;
  List<Group>? userGroups;
  List<User>? userPartners;
  List<Trade>? userNeedApproveTrades;

  @override
  void initState() {
    _initMyUser();
    _initMainData();
    super.initState();
  }

  void _initMainData() {
    getMainData(context).then((response) {
      if (response.status == 'success') {
        Iterable groupIterable = response.data['group_items'];
        Iterable partnerIterable = response.data['partner_items'];
        Iterable tradeIterable = response.data['trade_items'];

        List<Group>? userGroups =
            List<Group>.from(groupIterable.map((e) => Group.fromJSON(e)));
        List<User>? userPartners =
            List<User>.from(partnerIterable.map((e) => User.fromJSON(e)));
        List<Trade>? userNeedApproveTrades =
            List<Trade>.from(tradeIterable.map((e) => Trade.fromJSON(e)));

        setState(() {
          if (userGroups != null) {
            this.userGroups = userGroups;
          }
          if (partnerIterable != null) {
            this.userPartners = userPartners;
          }
          if (tradeIterable != null) {
            this.userNeedApproveTrades = userNeedApproveTrades;
          }
        });
      }
    });
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
                      _buildTitle('그룹', '그룹 찾기', '/group'),
                      _HorizontalList(userGroups : userGroups),
                      SizedBox(
                        height: 20.0,
                      ),
                      _buildTitle('파트너', '파트너 찾기', '/search'),
                      if (userNeedApproveTrades?.isNotEmpty ?? false)
                        _partnerBanner(context, userNeedApproveTrades!.length),
                      // 파트너 배너상태
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
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFf5f6f8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 14.0,
            left: 14.0,
            right: 14.0,
          ),
          child: userPartners != null && userPartners!.isNotEmpty
              ? ListView.builder(
            itemCount:  userPartners != null ? userPartners!.length : 0,
            itemBuilder: (context, index) {
              User item = userPartners![index];
              return ListUserCard(item: item);
            },
          )
              : GestureDetector(
            onTap: () {
              widget.onTab(3);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 130.0,
              decoration: const BoxDecoration(
                  color: SettingStyle.GREY_COLOR,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "가입하실 그룹을 찾거나,\n등록해보세요.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  // 공통 타이틀
  Padding _buildTitle(String text, String buttonText, String goto) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, goto)
                      .then((value) {
                    _initMyUser();
                    _initMainData();
                  });
                },
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Color(0xff333333),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: SettingStyle.GREY_COLOR,
                  foregroundColor: SettingStyle.GREY_COLOR,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
            ],
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
              builder: (context) =>
                  HistoryDetailIndex(historyType: "mine")), // 배너 클릭 이동화면
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
    super.dispose();
  }
}

class _HorizontalList extends StatelessWidget {
  List<Group>? userGroups;

  _HorizontalList({this.userGroups, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        height: 130.0,
        child: userGroups != null && userGroups!.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: userGroups?.length ?? 0,
                itemBuilder: (context, index) {
                  Group item =
                      userGroups![index] as Group;

                  return GroupCard(item: item);
                },
              )
            : GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/group');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 130.0,
                  decoration: BoxDecoration(
                      color: SettingStyle.GREY_COLOR,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_outline),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "가입하실 그룹을 찾거나,\n등록해보세요.",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

// 파트너 배너 디자인
class _partnerBannerStyle extends StatelessWidget {
  final int waitingCount;

  const _partnerBannerStyle({required this.waitingCount, Key? key})
      : super(key: key);

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
