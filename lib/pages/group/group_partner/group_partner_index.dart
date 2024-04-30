import 'package:Deal_Connect/api/group.dart';
import 'package:Deal_Connect/api/group_user.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_business_card.dart';
import 'package:Deal_Connect/components/list_group_user_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/model/group_user.dart';
import 'package:Deal_Connect/model/user_business.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GroupPartnerIndex extends StatefulWidget {
  const GroupPartnerIndex({super.key});

  @override
  State<GroupPartnerIndex> createState() => _GroupPartnerIndexState();
}

class _GroupPartnerIndexState extends State<GroupPartnerIndex>
    with TickerProviderStateMixin {
  late final TabController tabController;
  TextEditingController _textController = TextEditingController();
  int? groupId;
  String? groupName;
  List<GroupUser>? groupPartnerList = [];
  List<UserBusiness>? groupBusinessList = [];
  bool _isLoading = true;
  int tapPage = 0;

  var args;

  @override
  void initState() {
    super.initState();
    _initData();

    // tab컨트롤러 초기화
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  void _initData() async {
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

        if (groupId != null) {
          _initGroupUser(groupId);
          _initGroupUserBusiness(groupId);
        }
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _initGroupUser(groupId) {
    getGroupUsers(queryMap: {
      'group_id': groupId,
      'is_approved': true,
      'keyword': _textController.text
    }).then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;
        List<GroupUser> dataList =
            List<GroupUser>.from(iterable.map((e) => GroupUser.fromJSON(e)));
        setState(() {
          groupPartnerList = dataList;
        });
      }
    });
  }

  void _initGroupUserBusiness(groupId) {
    getGroupUserBusinesses(
            queryMap: {'group_id': groupId, 'keyword': _textController.text})
        .then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;
        List<UserBusiness> dataList = List<UserBusiness>.from(
            iterable.map((e) => UserBusiness.fromJSON(e)));
        setState(() {
          groupBusinessList = dataList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return const Loading();
    }
    return DefaultLogoLayout(
        titleName: groupName,
        isNotInnerPadding: 'true',
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            color: SettingStyle.GREY_COLOR,
            child: CustomScrollView(
              slivers: [
                CupertinoSliverRefreshControl(
                  onRefresh: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    _initData();
                  },
                ),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: false,
                  expandedHeight: 80,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextField(
                                  controller: _textController,
                                  onSubmitted: (value) {
                                    _initData();
                                  },
                                  decoration: SettingStyle.INPUT_STYLE.copyWith(
                                    prefixIcon:
                                        const Icon(Icons.search_rounded),
                                    hintText: '검색 키워드를 입력해주세요',
                                    filled: true,
                                    fillColor: HexColor("#F5F6FA"),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 20,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide.none, // 바텀 border 없애기
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(
                    color: Color(0xFFF5F6FA),
                    thickness: 10.0,
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      controller: tabController,
                      indicatorColor: Colors.black,
                      indicatorWeight: 2.0,
                      labelColor: Colors.black,
                      dividerColor: Colors.white,
                      unselectedLabelColor: Colors.grey[500],
                      labelStyle: SettingStyle.SUB_TITLE_STYLE,
                      unselectedLabelStyle: SettingStyle.SUB_TITLE_STYLE,
                      indicatorSize: TabBarIndicatorSize.tab,
                      onTap: (value) {
                        setState(() {
                          tapPage = value;
                        });
                        print(tabController.index);
                      },
                      tabs: const [
                        Tab(
                          child: Text(
                            '파트너',
                          ),
                        ),
                        Tab(
                          child: Text(
                            '사업장',
                          ),
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
                const SliverToBoxAdapter(
                  child: Divider(
                    color: Color(0xFFF5F6FA),
                    thickness: 16.0,
                  ),
                ),
                if (tapPage == 0) ...[
                  if (groupPartnerList != null &&
                      groupPartnerList!.isNotEmpty) ...[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        GroupUser item = groupPartnerList![index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/profile',
                                      arguments: {"userId": item.user_id})
                                  .then((value) {});
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14.0),
                              child: ListGroupUserCard(
                                item: item,
                                onApprovePressed: () {},
                                onDeclinePressed: () {},
                                onOutPressed: () {},
                                onManagerPressed: () {},
                                onManagerDownPressed: () {},
                              ),
                            ));
                      }, childCount: groupPartnerList!.length),
                    ),
                  ] else ...[
                    SliverToBoxAdapter(
                      child: NoItems(),
                    )
                  ]
                ] else if (tapPage == 1) ...[
                  if (groupBusinessList != null &&
                      groupBusinessList!.isNotEmpty) ...[
                    SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          UserBusiness item = groupBusinessList![index];
                          return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/business/info',
                                    arguments: {"userBusinessId": item.id});
                              },
                              child: ListBusinessCard(item: item));
                        },
                        childCount: groupBusinessList!.length, // 아이템 개수
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 한 줄에 2개의 아이템
                        crossAxisSpacing: 10.0, // 아이템 간의 가로 간격
                        mainAxisSpacing: 10.0, // 아이템 간의 세로 간격
                        childAspectRatio: 1 / 1.4,
                      ),
                    )
                  ] else ...[
                    SliverToBoxAdapter(
                      child: NoItems(),
                    )
                  ]
                ],
              ],
            ),
          ),
        ));
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
