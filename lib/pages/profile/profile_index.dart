import 'package:Deal_Connect/components/layout/default_basic_layout.dart';
import 'package:Deal_Connect/components/list_line_business_card.dart';
import 'package:Deal_Connect/db/company_data.dart';
import 'package:Deal_Connect/db/post_data.dart';
import 'package:Deal_Connect/pages/profile/company_add/company_add_index.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_button.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_condition.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_info.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_tab_bar.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/not_user_registered.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/tabBarButton.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/user_company.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/user_post.dart';
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
              expandedHeight: 260.0,
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
        body: TabBarView(
          controller: tabController,
          children: [
            CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                            (context, index) => Container(
                          height: 40,
                          child: Text('index: $index'),
                        ),
                        childCount: 40))
              ],
            ),
            UserPost(),
          ],
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

class UserCompany extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data10')
        ],
      ),
    );
  }
}

class UserPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('User Post Page'),
    );
  }
}