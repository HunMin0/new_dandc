import 'package:Deal_Connect/api/group.dart';
import 'package:Deal_Connect/api/group_user.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_business_card.dart';
import 'package:Deal_Connect/components/list_card.dart';
import 'package:Deal_Connect/components/list_group_user_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/model/group_user.dart';
import 'package:Deal_Connect/model/user_business.dart';
import 'package:Deal_Connect/pages/profile/other_profile.dart';
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
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
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
                                    decoration:
                                    SettingStyle.INPUT_STYLE.copyWith(
                                      prefixIcon:
                                      const Icon(Icons.search_rounded),
                                      hintText: '검색 키워드를 입력해주세요',
                                      filled: true,
                                      fillColor: HexColor("#F5F6FA"),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
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
                    delegate: GroupPartnerTabHeaderDelegate(tabController),
                    pinned: true,
                  ),
                  const SliverToBoxAdapter(
                    child: Divider(
                      color: Color(0xFFF5F6FA),
                      thickness: 16.0,
                    ),
                  ),
                ];
              },
              body: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      color: const Color(0xFFF5F6FA),
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          groupPartnerList != null
                              ? Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFf5f6f8),
                            ),
                            child: ListView.builder(
                              itemCount: groupPartnerList!.length,
                              itemBuilder: (context, index) {
                                GroupUser item = groupPartnerList![index];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                          const OtherProfileIndex()),
                                    );
                                  },
                                  child: ListGroupUserCard(
                                    item: item,
                                    onApprovePressed: () {},
                                    onDeclinePressed: () {},
                                    onOutPressed: () {},
                                    onManagerPressed: () {},
                                    onManagerDownPressed: () {},
                                  ),
                                );
                              },
                            ),
                          )
                              : const NoItems(),
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFf5f6f8),
                            ),
                            child: groupBusinessList!.isNotEmpty
                                ? GridView.builder(
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // 한 줄에 2개의 아이템
                                crossAxisSpacing: 10.0, // 아이템 간의 가로 간격
                                mainAxisSpacing: 10.0, // 아이템 간의 세로 간격
                                childAspectRatio: 1 / 1.4,
                              ),
                              itemCount:
                              groupBusinessList!.length, // 아이템 개수
                              itemBuilder: (context, index) {
                                UserBusiness item =
                                groupBusinessList![index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/business/info',
                                        arguments: {
                                          "userBusinessId": item.id
                                        });
                                  },
                                  child: ListBusinessCard(
                                    item: item,
                                  ),
                                );
                              },
                            )
                                : const Text('등록된 데이터가 없습니다'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}

class GroupPartnerTabHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;

  GroupPartnerTabHeaderDelegate(this.tabController);

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
        labelStyle: const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          const Tab(
            child: Text(
              '파트너',
            ),
          ),
          const Tab(
            child: Text(
              '사업장',
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
