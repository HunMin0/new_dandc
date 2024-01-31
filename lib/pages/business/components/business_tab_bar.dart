import 'package:Deal_Connect/pages/business/components/business_tab_list.dart';
import 'package:Deal_Connect/pages/history/components/history_tab_list.dart';
import 'package:flutter/material.dart';

class BusinessTabBar extends StatefulWidget {
  const BusinessTabBar({super.key});

  @override
  State<BusinessTabBar> createState() => _BusinessTabBarState();
}

class _BusinessTabBarState extends State<BusinessTabBar> with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    // tab컨트롤러 초기화
    tabController = TabController(
      length: 4,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F6FA),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: tabController,
              indicatorColor: Colors.black,
              indicatorWeight: 2.0,
              labelColor: Colors.black,
              dividerColor: Colors.black,
              unselectedLabelColor: Colors.grey[500],
              isScrollable: true,
              onTap: (value) {
                print(value);
              },
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
                    '식당/주점/카페',
                  ),
                ),
                Tab(
                  child: Text(
                    '법무/세무/보험',
                  ),
                ),
                Tab(
                  child: Text(
                    '화장품/건강식품',
                  ),
                ),
                Tab(
                  child: Text(
                    '화장품/건강식품',
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Color(0xFFF5F6FA),
            thickness: 10.0,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              color: Color(0xFFF5F6FA),
              child: BusinessTabList(),
            ),
          ),
        ],
      ),
    );
  }
}
