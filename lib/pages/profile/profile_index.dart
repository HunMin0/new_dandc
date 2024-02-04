import 'package:Deal_Connect/components/layout/default_basic_layout.dart';
import 'package:Deal_Connect/components/list_line_business_card.dart';
import 'package:Deal_Connect/components/post_list_card.dart';
import 'package:Deal_Connect/db/company_data.dart';
import 'package:Deal_Connect/db/post_data.dart';
import 'package:Deal_Connect/pages/business/business_detail/business_detail_info.dart';
import 'package:Deal_Connect/pages/group/group_board/group_board_info.dart';
import 'package:Deal_Connect/pages/profile/company_add/company_add_index.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_button.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_condition.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_info.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/not_user_registered.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/tabBarButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 프로필
class ProfileIndex extends StatefulWidget {
  const ProfileIndex({Key? key}) : super(key: key);

  @override
  State<ProfileIndex> createState() => _ProfileIndexState();
}

class _ProfileIndexState extends State<ProfileIndex>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    // tab컨트롤러 초기화
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      ProfileUserInfo(
                        userName: '홍길동',
                        userInfo: '다양한 소프트웨어 개발을 통해 서비스',
                        imgPath: 'main_sample01',
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      ProfileUserCondition(
                        partner: 123,
                        company: 3,
                        history: '10k',
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
                child: companyDataList.isNotEmpty
                    ? CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              Map<String, dynamic> verticalData =
                                  companyDataList[index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(builder: (context) => BusinessDetailInfo()
                                    ),
                                  );
                                },
                                child: ListLineBusinessCard(
                                  bgImagePath: verticalData['bgImagePath'],
                                  companyName: verticalData['companyName'],
                                  tagList: verticalData['tagList'],
                                ),
                              );
                            }, childCount: companyDataList.length),
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CompanyAddIndex()));
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
                                Map<String, dynamic> postData = postDataList[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(builder: (context) => GroupBoardInfo(id: 1)
                                  ),
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
                      child: SizedBox(height: 50.0,),
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