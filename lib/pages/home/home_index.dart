import 'dart:convert';

import 'package:Deal_Connect/api/ad_manage.dart';
import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/api/main.dart';
import 'package:Deal_Connect/api/user_log.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/list_partner_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/model/ad_manage.dart';
import 'package:Deal_Connect/model/group.dart';
import 'package:Deal_Connect/model/trade.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/Utils/shared_pref_utils.dart';
import 'package:Deal_Connect/pages/home/components/group_card.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

// 메인홈
class HomeIndex extends StatefulWidget {
  Function onTab;

  HomeIndex({Key? key, required this.onTab}) : super(key: key);

  @override
  State<HomeIndex> createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex>
    with AutomaticKeepAliveClientMixin {

  User? myUser;
  List<Group>? userGroups;
  List<User>? userPartners;
  List<Trade>? userNeedApproveTrades;
  List<AdManage>? adManageList;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAndSetUserLog();
    _initMyUserData();

  }

  _initMyUserData() async {
    var response = await getMyUser();
    if (response.status == 'success' && mounted) {
      User user = User.fromJSON(response.data);
      await SharedPrefUtils.setUser(user);
      var userFromPrefs = await SharedPrefUtils.getUser();
      if (mounted) {
        if (userFromPrefs != null) {
          setState(() {
            myUser = userFromPrefs;
            // 탈퇴회원 중 철회기간 내에 회원은 철회 페이지로 이동
            if (myUser!.is_active == false) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/auth/withdraw', (r) => false);
            }
          });
        } else { // 이 경우에도 mounted 체크를 추가합니다.
          CustomDialog.showCustomDialog(
              context: context,
              title: '사용자 정보 요청 실패',
              msg: '사용자 정보를 불러올 수 없습니다.\n다시 로그인 해주세요.')
              .then((value) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/intro', (r) => false);
          });
        }
      }
      await _initMainData();
      await _initAdData();

    }
  }

  Future<void> _initMainData() async {
    var response = await getMainData(context);
    if (response.status == 'success' && mounted) {
      await updateUI(response.data);
    }
  }

  Future<void> updateUI(Map<String, dynamic> data) async {
    setState(() {
      userGroups = List<Group>.from(data['group_items'].map((e) => Group.fromJSON(e)));
      userPartners = List<User>.from(data['partner_items'].map((e) => User.fromJSON(e)));
      userNeedApproveTrades = List<Trade>.from(data['trade_items'].map((e) => Trade.fromJSON(e)));
      _isLoading = false;
    });
  }

  Future<void> _initAdData() async {
    var response = await getAds(queryMap: {
      'ad_type': '2',
    });
    if (response.status == 'success' && mounted) {
      Iterable iterable = response.data;
      List<AdManage>? adManageList = List<AdManage>.from(
          iterable.map((e) => AdManage.fromJSON(e)));
      setState(() {
        if (adManageList != null) {
          this.adManageList = adManageList;
        }
        _isLoading = false;
      });
      _checkAndSetAd();
    }
  }

  Future<bool> _refreshData() async {
    try {
      await _initMyUserData();
      return true;
    } catch (e) {
      return false;
    }
  }

  //하루에 한번만 로그 인서트
  void _checkAndSetUserLog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastLoggedDate = prefs.getString('lastLoggedDate');
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    if (lastLoggedDate == null || lastLoggedDate != today) {
      _setUserLog();
      await prefs.setString('lastLoggedDate', today);
    }
  }

  void _setUserLog() {
    try {
      setUserLog({ 'page': 'main' });
    } catch (e) {
      print(e);
    }
  }

  void _checkAndSetAd() async {
    if (adManageList != null && adManageList!.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? lastShowAdDate = prefs.getString('lastShowAdDate');
      String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      if (lastShowAdDate == null || lastShowAdDate != today) {
        showFullSizeModalBottomSheet(context);
      }
    }
  }

  void _closeNotToday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await prefs.setString('lastShowAdDate', today);
  }

  void showFullSizeModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 이 속성을 true로 설정하여 전체 화면으로 확장
      builder: (BuildContext context) {
        // 전체 화면 크기를 활용하기 위해 MediaQuery를 사용
        return Column(
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 50, // 슬라이더의 높이 설정, 필요에 따라 조정
              child: PageView.builder(
                itemCount: adManageList!.length, // 광고 리스트의 개수
                controller: PageController(viewportFraction: 1.0), // 한 화면에 보이는 페이지 비율 조정
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      var url = adManageList![index].ad_link;
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                      throw 'Could not launch $url';
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: SettingStyle.GREY_COLOR, // 배경색 설정
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            Utils.getImageFilePath(adManageList![index].has_image!),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _closeNotToday();
                      Navigator.pop(context);
                    },
                    child: Text(
                      '오늘 하루 그만 보기',
                      style: SettingStyle.NORMAL_TEXT_STYLE.copyWith(color: SettingStyle.MAIN_COLOR, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '닫기',
                      style: SettingStyle.NORMAL_TEXT_STYLE,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }


  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    super.build(context); // 이 호출이 중요합니다.
    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return const Loading();
    }
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              setState(() {
                _isLoading = true;
              });
              _refreshData();
            },
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  _buildTitle('그룹', '그룹 찾기', '/group'),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Container(
                      height: 130.0,
                      child: userGroups != null && userGroups!.isNotEmpty
                          ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: userGroups?.length ?? 0,
                        itemBuilder: (context, index) {
                          Group item = userGroups![index] as Group;

                          return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/group/info',
                                    arguments: {
                                      'groupId': item.id
                                    }).then((value) {
                                  _initMainData();
                                });
                              },
                              child: GroupCard(item: item));
                        },
                      )
                          : GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/group');
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 130.0,
                          decoration: const BoxDecoration(
                              color: SettingStyle.GREY_COLOR,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0))),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.person_add, size: 40, color: HexColor("#DDDDDD"),),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "가입하실 그룹을 찾거나,\n만들어보세요.",
                                style: SettingStyle.SUB_GREY_TEXT,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (userNeedApproveTrades?.isNotEmpty ?? false)
                    Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        _partnerBanner(
                            context, userNeedApproveTrades!.length),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),

                ],
              ),
            ]),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        '파트너',
                        style: SettingStyle.TITLE_STYLE,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          widget.onTab(3);
                        },
                        child: Text('파트너 찾기', style: SettingStyle.SMALL_TEXT_STYLE.copyWith(color: SettingStyle.MAIN_COLOR),),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14.0,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFf5f6f8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 14.0,
                  left: 14.0,
                  right: 14.0,
                ),
                child: userPartners != null && userPartners!.isNotEmpty
                    ? Column(
                  children: userPartners!.map((User item) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/profile/partner/info',
                          arguments: {'userId': item.id},
                        );
                      },
                      child: ListPartnerCard(
                        item: item,
                        onDeletePressed: () {},
                        onApprovePressed: () {},
                      ),
                    );
                  }).toList(),
                )
                    : GestureDetector(
                  onTap: () {
                    widget.onTab(3);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 170.0,
                    decoration: const BoxDecoration(
                        color: SettingStyle.GREY_COLOR,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.sparkles,
                          size: 50,
                          color: HexColor("#DDDDDD"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "그룹에 가입하거나\n사업자 검색을 통해\n파트너들을 관리해보세요.",
                          style: SettingStyle.SUB_GREY_TEXT,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
                style: SettingStyle.TITLE_STYLE,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, goto).then((value) {
                    _initMyUserData();
                    _initMainData();
                  });
                },
                child: Text(buttonText, style: SettingStyle.SMALL_TEXT_STYLE.copyWith(color: SettingStyle.MAIN_COLOR),),
              ),
            ],
          ),
          const SizedBox(
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
        Navigator.pushNamed(
            context, '/trade/history/approve',
            arguments: {'division': 'mine'})
            .then((value) {
          _initMainData();
        });
      },
      child: _partnerBannerStyle(waitingCount: waitingCount),
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
          color: const Color(0xFFf5f6fa),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 24.0,
                  color: Color(0xFF75a8e4),
                ),
                const SizedBox(
                  width: 14.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$waitingCount개의 신규거래내역 승인을 기다리고 있어요!',
                      style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6f6f6f)),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    const Text(
                      '신규 거래내역 보러가기',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
