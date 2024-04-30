import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/api/board.dart';
import 'package:Deal_Connect/api/business.dart';
import 'package:Deal_Connect/api/server_config.dart';
import 'package:Deal_Connect/components/common_item/grey_chip.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_basic_layout.dart';
import 'package:Deal_Connect/components/list_row_business_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/model/board_write.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/model/user_business.dart';
import 'package:Deal_Connect/model/user_keyword.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/not_user_registered.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/tabBarButton.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 프로필
class ProfileIndex extends StatefulWidget {
  Function onTab;

  ProfileIndex({Key? key, required this.onTab}) : super(key: key);

  @override
  State<ProfileIndex> createState() => _ProfileIndexState();
}

class _ProfileIndexState extends State<ProfileIndex>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final TabController tabController;

  bool _isLoading = true;
  User? myUser;
  User? ProfileUserData;
  List<UserBusiness>? userBusinessList;
  List<BoardWrite>? userBoardWriteList;
  var myPageData;
  String? shareUrl;
  int tapPage = 0;

  @override
  void initState() {
    super.initState();
    _initMyUserData();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }


  Future<void> generateAndSetUrl(id) async {
    setState(() {
      shareUrl = 'https://server.dealconnect.co.kr?uri=/profile&userId=$id';
    });
  }


  _initMyUserData() async {
    await getMyUser().then((response) {
      if (response.status == 'success') {
        User user = User.fromJSON(response.data);
        SharedPrefUtils.setUser(user).then((value) {
          SharedPrefUtils.getUser().then((user) async {
            if (user != null) {
              generateAndSetUrl(user.id);
              if (mounted) {
                setState(() {
                  myUser = user;
                });
              }
              await _initUserBusinessData();
              await _initUserMypageData();
              await _initUserBoardData();

              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
              }
            } else {
              CustomDialog.showCustomDialog(
                      context: context,
                      title: '사용자 정보 요청 실패',
                      msg: '사용자 정보를 불러올 수 없습니다.\n다시 로그인 해주세요.')
                  .then((value) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/intro', (r) => false);
              });
            }
          });
        });
      }
    });
  }

  Future<void> _initUserMypageData() async {
    try {
      var response = await getMyPageData();
      if (response.status == 'success' && mounted) {
        var responseMyPageData = response.data;
        setState(() {
          if (responseMyPageData != null) {
            myPageData = responseMyPageData;
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _initUserBusinessData() async {
    try {
      var response = await getUserBusinesses(queryMap: {'is_mine': true});
      if (response.status == 'success' && mounted) {
        Iterable iterable = response.data;
        List<UserBusiness>? userBusiness = List<UserBusiness>.from(
            iterable.map((e) => UserBusiness.fromJSON(e)));

        setState(() {
          this.userBusinessList = userBusiness;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _initUserBoardData() async {
    try {
      var response = await getBoardWrites(queryMap: {'is_mine': true});
      if (response.status == 'success' && mounted) {
        Iterable iterable = response.data;
        List<BoardWrite>? resData =
            List<BoardWrite>.from(iterable.map((e) => BoardWrite.fromJSON(e)));
        setState(() {
          this.userBoardWriteList = resData;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ImageProvider? backgroundImage;
    if (myUser != null &&
        myUser?.profile != null &&
        myUser?.profile?.has_profile_image != null) {
      backgroundImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(myUser!.profile!.has_profile_image!),
      );
    } else {
      backgroundImage = const AssetImage('assets/images/no-image.png');
    }

    int tradeAmount = 0;
    if (myPageData?['trade_amount'] != null &&
        myPageData!['trade_amount'] is String) {
      tradeAmount = int.tryParse(myPageData!['trade_amount']) ??
          0; // tryParse 사용하여 안전하게 변환
    }

    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return const Loading();
    }

    return DefaultBasicLayout(
      child: Container(
        decoration: BoxDecoration(color: SettingStyle.GREY_COLOR),
        child: CustomScrollView(
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                setState(() {
                  _isLoading = true;
                });
                _initMyUserData();
              },
            ),
            SliverAppBar(
              pinned: false,
              expandedHeight: 270.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 34.0,
                            backgroundImage: backgroundImage,
                          ),
                          const SizedBox(
                            width: 18.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      myUser != null ? myUser!.name : '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/profile/edit')
                                            .then((value) {
                                          _initMyUserData();
                                        });
                                      },
                                      child: Text("프로필 수정", style: SettingStyle.SMALL_TEXT_STYLE.copyWith(color: SettingStyle.MAIN_COLOR),),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                if (myUser != null)
                                  if (myUser!.has_keywords != null)
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: _buildTags(myUser!.has_keywords!),
                                    )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/profile/partners',
                                    arguments: {'userId': myUser!.id});
                              },
                              child: _buildUserTab(
                                myPageData?['partner_count'].toString() ?? '0',
                                '파트너',
                              ),
                            ),
                            _buildTabLine(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/profile/groups',
                                    arguments: {'userId': myUser!.id});
                              },
                              child: _buildUserTab(
                                myPageData?['group_count'].toString() ?? '0',
                                '소속그룹',
                              ),
                            ),
                            _buildTabLine(),
                            GestureDetector(
                              onTap: () {
                                widget.onTab(1);
                              },
                              child: _buildUserTab(
                                Utils.parsePrice(tradeAmount),
                                '거래내역',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Stack(
                              alignment: Alignment.centerRight, // 버튼 내 우측 정렬
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    CustomDialog.showShareDialog(
                                        context, myUser!.name, ServerConfig.SERVER_URL + '?uri=profile&userId=' + myUser!.id.toString());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    backgroundColor: const Color(0xFFF5F6FA),
                                    foregroundColor: const Color(0xFFF5F6FA),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                  ),
                                  child: const Text(
                                    '\u{1F44B} 프로필 공유하기',
                                    style: SettingStyle.NORMAL_TEXT_STYLE,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Stack(
                              alignment: Alignment.centerRight, // 버튼 내 우측 정렬
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/profile/partner/attends',
                                    ).then((value) {
                                      _initMyUserData();
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    backgroundColor: const Color(0xFFF5F6FA),
                                    foregroundColor: const Color(0xFFF5F6FA),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                  ),
                                  child: const Text(
                                    '\u{1F4EE} 파트너신청 확인',
                                    style: SettingStyle.NORMAL_TEXT_STYLE,
                                  ),
                                ),
                                if (myPageData != null &&
                                    myPageData['partner_want_approved_count']! >
                                        0) // 알림 숫자가 0보다 클 때만 뱃지 표시
                                  Positioned(
                                    left: 5, // 우측 여백
                                    top: 5, // 상단 여백
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: Colors.red, // 뱃지 배경색
                                        shape: BoxShape.circle, // 원형 뱃지
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(
                color: Color(0xFFF5F6FA),
                thickness: 16.0,
              ),
            ),
            if (userBusinessList != null && userBusinessList!.isNotEmpty) ...[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  UserBusiness item = userBusinessList![index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/business/info',
                                arguments: {"userBusinessId": item.id})
                            .then((value) {
                          _initMyUserData();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: ListRowBusinessCard(item: item),
                      ));
                }, childCount: userBusinessList!.length),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 40.0, left: 13.0, right: 13.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TabBarButton(
                            btnTitle: '내 업체 추가하기',
                            onPressed: () {
                              Navigator.pushNamed(
                                      context, '/profile/company/create')
                                  .then((value) {
                                _initUserBusinessData();
                                _initMyUserData();
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              SliverToBoxAdapter(child: const NotUserRegistered(isTabType: true)),
            ],
          ],
        ),
      ),
    );
  }

  // 반복태그
  Widget _buildTags(List<UserKeyword> tagList) {
    List<Widget> tagWidgets = [];
    for (int i = 0; i < tagList.length; i++) {
      tagWidgets.add(Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: GreyChip(chipText: '#' + tagList[i].keyword),
      ));
    }

    return Row(children: tagWidgets);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: 1.0,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

Widget _buildUserTab(String tabData, String tabTitle) {

  return Container(
    width: 120.0,
    child: Column(
      children: [
        Text(
          tabData,
          style: SettingStyle.TITLE_STYLE,
        ),
        Text(
          tabTitle,
          style: SettingStyle.SMALL_TEXT_STYLE,
        ),
      ],
    ),
  );
}

Widget _buildTabLine() {
  return Container(
    width: 1.0,
    height: double.infinity,
    color: const Color(0xFFD9D9D9),
  );
}

