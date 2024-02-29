import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/api/business.dart';
import 'package:Deal_Connect/components/common_item/grey_chip.dart';
import 'package:Deal_Connect/components/layout/default_basic_layout.dart';
import 'package:Deal_Connect/components/list_row_business_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/post_list_card.dart';
import 'package:Deal_Connect/db/company_data.dart';
import 'package:Deal_Connect/db/post_data.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/model/user_business.dart';
import 'package:Deal_Connect/model/user_keyword.dart';
import 'package:Deal_Connect/pages/business/business_detail/business_detail_info.dart';
import 'package:Deal_Connect/pages/group/group_board/group_board_info.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_button.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_info.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/not_user_registered.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/tabBarButton.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// 프로필
class ProfileIndex extends StatefulWidget {
  Function onTab;

  ProfileIndex({Key? key, required this.onTab}) : super(key: key);

  @override
  State<ProfileIndex> createState() => _ProfileIndexState();
}

class _ProfileIndexState extends State<ProfileIndex>
    with TickerProviderStateMixin {
  late final TabController tabController;

  bool _isLoading = true;
  User? myUser; // 저장 된 내 정보
  User? ProfileUserData;
  List<UserBusiness>? userBusinessList; //사업장
  var myPageData;

  @override
  void initState() {
    super.initState();

    _initMyUserData();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  _initMyUserData() async {
    await getMyUser().then((response) {
      if (response.status == 'success') {
        User user = User.fromJSON(response.data);
        setState(() {
          ProfileUserData = user;
        });
        SharedPrefUtils.setUser(user).then((value) {
          SharedPrefUtils.getUser().then((user) {
            if (user != null) {
              setState(() {
                myUser = user;
              });
              _initUserBusinessData();
              _initUserMypageData();
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

      setState(() {
        _isLoading = false;
      });
    });
  }

  void _initUserMypageData() {
    getMyPageData().then((response) {
      if (response.status == 'success') {
        var responseMyPageData = response.data;

        setState(() {
          if (responseMyPageData != null) {
            myPageData = responseMyPageData;
          }
        });
      }
    });
  }

  void _initUserBusinessData() {
    getUserBusinesses(queryMap: {'is_mine': true}).then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;

        List<UserBusiness>? userBusiness = List<UserBusiness>.from(
            iterable.map((e) => UserBusiness.fromJSON(e)));

        setState(() {
          if (userBusiness != null) {
            this.userBusinessList = userBusiness;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? backgroundImage;
    if (ProfileUserData != null &&
        ProfileUserData?.has_user_profile != null &&
        ProfileUserData?.has_user_profile?.has_profile_image != null) {
      backgroundImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(
            ProfileUserData!.has_user_profile!.has_profile_image!),
      );
    } else {
      backgroundImage = AssetImage('assets/images/no-image.png');
    }

    int tradeAmount = 0;
    if (myPageData?['trade_amount'] != null && myPageData!['trade_amount'] is String) {
      tradeAmount = int.tryParse(myPageData!['trade_amount']) ?? 0; // tryParse 사용하여 안전하게 변환
    }

    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return Loading();
    }

    return DefaultBasicLayout(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: false,
              expandedHeight: 270.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 34.0,
                            backgroundImage: backgroundImage,
                          ),
                          SizedBox(
                            width: 18.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ProfileUserData != null
                                      ? ProfileUserData!.name
                                      : '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                if (ProfileUserData != null)
                                  if (ProfileUserData!.has_keywords != null)
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: _buildTags(
                                          ProfileUserData!.has_keywords!),
                                    )
                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/profile/edit')
                                  .then((value) {
                                _initMyUserData();
                              });
                            },
                            child: Icon(
                              CupertinoIcons.person_crop_square,
                              color: HexColor("#dddddd"),
                              size: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          )
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
                                    context, '/profile/partners');
                              },
                              child: _buildUserTab(
                                myPageData?['partner_count'].toString() ?? '0',
                                '파트너',
                              ),
                            ),
                            _buildTabLine(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/profile/groups');
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
                      SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        children: [
                          _reanderButton(
                            btnName: '프로필 공유하기',
                            onPressed: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  showDragHandle: false,
                                  context: context,
                                  builder: (_) {
                                    return Container(
                                      width: double.infinity,
                                      height: 150,
                                      padding: EdgeInsets.only(top: 20.0),
                                      color: HexColor("FFFFFF"),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text("공유 방법을 선택해주세요."),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Spacer(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.messenger),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text("문자")
                                                  ],
                                                ),
                                                Spacer(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.messenger),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text("카카오")
                                                  ],
                                                ),
                                                Spacer(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.messenger),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text("뭐시기")
                                                  ],
                                                ),
                                                Spacer(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.messenger),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text("문자")
                                                  ],
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          _reanderButton(
                            alertCount: (myPageData != null ? myPageData['partner_want_approved_count'] : 0) ?? 0,
                            btnName: '파트너 신청 확인하기',
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/profile/partner/attends',
                                  ).then((value) {
                                _initMyUserData();
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Divider(
                color: Color(0xFFF5F6FA),
                thickness: 10.0,
              ),
            ),
            SliverPersistentHeader(
              delegate: ProfileUserTabHeaderDelegate(tabController),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Divider(
                color: Color(0xFFF5F6FA),
                thickness: 16.0,
              ),
            ),
          ];
        },
        body: Container(
          color: Color(0xFFf5f6f8),
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: TabBarView(
            controller: tabController,
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  _initMyUserData();
                },
                child: SizedBox(
                  child: (userBusinessList != null &&
                          userBusinessList!.isNotEmpty)
                      ? CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                UserBusiness item = userBusinessList![index];
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/business/info', arguments: {
                                        "userBusinessId": item.id
                                      }).then((value) {
                                        _initMyUserData();
                                      });
                                    },
                                    child: ListRowBusinessCard(item: item));
                              }, childCount: userBusinessList!.length),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 40.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TabBarButton(
                                          btnTitle: '내 업체 추가하기',
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                    '/profile/company/create')
                                                .then((value) {
                                              _initMyUserData();
                                            });
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : NotUserRegistered(isTabType: true),
                ),
              ),
              SizedBox(
                child: postDataList.isNotEmpty
                    ? CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              Map<String, dynamic> postData =
                                  postDataList[index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => GroupBoardInfo()),
                                  );
                                },
                                child: PostListCard(
                                  bgImagePath: postData['bgImagePath'],
                                  postTitle: postData['postTitle'],
                                  postSubject: postData['postSubject'],
                                  groupName: postData['groupName'],
                                  date: postData['date'],
                                  newMark: postData['newMark'],
                                ),
                              );
                            }, childCount: companyDataList.length),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: 50.0,
                            ),
                          ),
                        ],
                      )
                    : NotUserRegistered(isTabType: false),
              ),
            ],
          ),
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
}

class ProfileUserTabHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;

  ProfileUserTabHeaderDelegate(this.tabController);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 50.0,
      color: Colors.white,
      child: TabBar(
        controller: tabController,
        indicatorColor: Colors.black,
        indicatorWeight: 2.0,
        labelColor: Colors.black,
        dividerColor: Colors.white,
        unselectedLabelColor: Colors.grey[500],
        labelStyle: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(
            child: Text(
              '사업장',
            ),
          ),
          Tab(
            child: Text(
              '작성한 글',
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 50.0;

  @override
  double get minExtent => 50.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

Widget _buildUserTab(String tabData, String tabTitle) {
  final tabDataStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20.0,
  );
  final tabTitleStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
  );

  return Container(
    width: 120.0,
    child: Column(
      children: [
        Text(
          tabData,
          style: tabDataStyle,
        ),
        Text(
          tabTitle,
          style: tabTitleStyle,
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
class _reanderButton extends StatelessWidget {
  final String btnName;
  final VoidCallback onPressed;
  final int? alertCount;

  const _reanderButton({
    required this.btnName,
    required this.onPressed,
    this.alertCount = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.centerRight, // 버튼 내 우측 정렬
        children: [
          ElevatedButton(
            onPressed: onPressed,
            child: Text(
              btnName,
              style: TextStyle(
                  color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w500),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              backgroundColor: Color(0xFFF5F6FA),
              foregroundColor: Color(0xFFF5F6FA),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
          if (alertCount != null && alertCount! > 0) // 알림 숫자가 0보다 클 때만 뱃지 표시
            Positioned(
              left: 5, // 우측 여백
              top: 5, // 상단 여백
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.red, // 뱃지 배경색
                  shape: BoxShape.circle, // 원형 뱃지
                ),
              ),
            ),
        ],
      ),
    );
  }
}