import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_business_card.dart';
import 'package:Deal_Connect/components/list_card.dart';
import 'package:Deal_Connect/components/list_partner_manage_card.dart';
import 'package:Deal_Connect/db/company_data.dart';
import 'package:Deal_Connect/db/vertical_data.dart';
import 'package:Deal_Connect/pages/business/business_detail/business_detail_info.dart';
import 'package:Deal_Connect/pages/group/group_partner/group_partner_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GroupManagePartner extends StatefulWidget {
  const GroupManagePartner({super.key});

  @override
  State<GroupManagePartner> createState() => _GroupManagePartnerState();
}

class _GroupManagePartnerState extends State<GroupManagePartner>
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
    return DefaultLogoLayout(
        titleName: '서초구 고깃집 사장모임',
        isNotInnerPadding: 'true',
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
                                  onSubmitted: (value) {
                                    print(value);
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: HexColor("#F5F6FA"),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 20,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      // 테두리를 둥글게 설정
                                      borderSide:
                                          BorderSide.none, // 바텀 border 없애기
                                    ),
                                    prefixIcon: Icon(Icons.search_rounded),
                                    hintText: '검색 키워드를 입력해주세요',
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
                SliverToBoxAdapter(
                  child: Divider(
                    color: Color(0xFFF5F6FA),
                    thickness: 10.0,
                  ),
                ),
                SliverPersistentHeader(
                  delegate: GroupPartnerTabHeaderDelegate(tabController),
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
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    color: Color(0xFFF5F6FA),
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        _VerticalList(isNew: true),
                        _VerticalList(isNew: false),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}

// 회원 세로 리스트
class _VerticalList extends StatelessWidget {
  bool isNew;

  _VerticalList({this.isNew = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFf5f6f8),
      ),
      child: ListView.builder(
        itemCount: verticalDataList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> verticalData = verticalDataList[index];

          return GestureDetector(
            onTap: () {
              print('클릭했다~');
            },
            child: ListPartnerManageCard(
              avaterImagePath: verticalData['avaterImagePath'],
              bgImagePath: verticalData['bgImagePath'],
              companyName: verticalData['companyName'],
              userName: verticalData['userName'],
              tagList: verticalData['tagList'],
              isNew: isNew,
            ),
          );
        },
      ),
    );
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
              '신규가입요청',
            ),
          ),
          Tab(
            child: Text(
              '기존회원',
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
