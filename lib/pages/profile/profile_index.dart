import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/api/business.dart';
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
  List<UserBusiness>? userBusiness; //사업장
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
    getUserBusinessData().then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;

        List<UserBusiness>? userBusiness = List<UserBusiness>.from(
            iterable.map((e) => UserBusiness.fromJSON(e)));

        setState(() {
          if (userBusiness != null) {
            this.userBusiness = userBusiness;
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
                  padding: EdgeInsets.all(12.0),
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
                                SizedBox(
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
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/profile/edit')
                                  .then((value) {
                                _initMyUserData();
                              });
                            },
                            child: Icon(
                              Icons.edit_note,
                              color: HexColor("#dddddd"),
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      SizedBox(
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
                                myPageData?['trade_amount'].toString() ?? '0',
                                '거래내역',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      ProfileUserButton(),
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
              SizedBox(
                child: (userBusiness != null && userBusiness!.isNotEmpty)
                    ? CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              UserBusiness item = userBusiness![index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            BusinessDetailInfo()),
                                  );
                                },
                                child: ListRowBusinessCard(item: item),
                              );
                            }, childCount: userBusiness!.length),
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
                                              '/profile/company/create');
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
                                        builder: (context) =>
                                            GroupBoardInfo()),
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
      if (i < 3) {
        // 최대 3개 태그만 표시
        tagWidgets.add(Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: _cardTag(
              tagList[i] as UserKeyword), // tagList[i]는 Map<String, dynamic> 타입
        ));
      } else {
        break;
      }
    }

    return Row(children: tagWidgets);
  }

  // 태그 공통
  Container _cardTag(UserKeyword text) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFf5f6fa),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 7.0),
        child: Text(
          '#' + text.keyword,
          style: TextStyle(
              color: Color(0xFF5f5f66),
              fontSize: 11.0,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
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
