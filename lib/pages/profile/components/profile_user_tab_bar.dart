import 'package:Deal_Connect/db/company_data.dart';
import 'package:Deal_Connect/db/post_data.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/not_user_registered.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/user_post.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/user_company.dart';
import 'package:flutter/material.dart';

class ProfileUserTabBar extends StatefulWidget {
  const ProfileUserTabBar({Key? key}) : super(key: key);

  @override
  _ProfileUserTabBarState createState() => _ProfileUserTabBarState();
}

class _ProfileUserTabBarState extends State<ProfileUserTabBar>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    // tab컨트롤러 초기화
    tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Color(0xFFF5F6FA),
          thickness: 10.0,
        ),
        TabBar(
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
        Expanded(
          child: Container(
            color: Color(0xFFF5F6FA),
            child: TabBarView(
              controller: tabController,
              children: [
                // 사업장
                // _NotUserCompany 내 사업장이 미등록 상태일때
                // _UserCompany 사업장이 등록 상태일때
                companyDataList.isNotEmpty
                    ? UserCompany(companyDataList: companyDataList)
                    : NotUserRegistered(isTabType: true),
                // 작성한 글
                postDataList.isNotEmpty
                    ? UserPost(postDataList: postDataList)
                    : NotUserRegistered(isTabType: false),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
