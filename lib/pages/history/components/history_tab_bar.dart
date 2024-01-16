import 'package:Deal_Connect/db/company_data.dart';
import 'package:Deal_Connect/db/post_data.dart';
import 'package:Deal_Connect/pages/history/components/history_tab_list.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/not_user_registered.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/user_company.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/user_post.dart';
import 'package:flutter/material.dart';

class HistoryTabBar extends StatefulWidget {
  const HistoryTabBar({super.key});

  @override
  State<HistoryTabBar> createState() => _HistoryTabBarState();
}

class _HistoryTabBarState extends State<HistoryTabBar>
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
                '전체',
              ),
            ),
            Tab(
              child: Text(
                '구매',
              ),
            ),
            Tab(
              child: Text(
                '판매',
              ),
            ),
          ],
        ),
        Divider(
          color: Color(0xFFF5F6FA),
          thickness: 10.0,
        ),
        Expanded(
          child: Container(
            color: Color(0xFFF5F6FA),
            child: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                HistoryTabList(),
                HistoryTabList(),
                HistoryTabList()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
