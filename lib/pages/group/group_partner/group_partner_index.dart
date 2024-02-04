import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_business_card.dart';
import 'package:Deal_Connect/components/list_card.dart';
import 'package:Deal_Connect/db/company_data.dart';
import 'package:Deal_Connect/db/vertical_data.dart';
import 'package:Deal_Connect/pages/business/business_detail/business_detail_info.dart';
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
    final titleStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20.0,
    );

    return DefaultLogoLayout(
        titleName: '서초구 고기집 사장모임',
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
                        _VerticalList(),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFf5f6f8),
                          ),
                          child: companyDataList.isNotEmpty
                              ? GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // 한 줄에 2개의 아이템
                              crossAxisSpacing: 10.0, // 아이템 간의 가로 간격
                              mainAxisSpacing: 10.0, // 아이템 간의 세로 간격
                              childAspectRatio: 1 / 1.4,
                            ),
                            itemCount: companyDataList.length, // 아이템 개수
                            itemBuilder: (context, index) {
                              Map<String, dynamic> companyData = companyDataList[index];
                              return GestureDetector(
                                onTap: () {
                                  print('클릭했다~ ');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessDetailInfo()));
                                },
                                child: Container(
                                  child: ListBusinessCard(
                                    bgImagePath: companyData['bgImagePath'],
                                    avaterImagePath: companyData['avaterImagePath'],
                                    companyName: companyData['companyName'],
                                    tagList : companyData['tagList'],
                                  ),
                                ),
                              );
                            },
                          ) : const Text('등록된 데이터가 없습니다'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
        )
    );
  }
}

// 회원 세로 리스트
class _VerticalList extends StatelessWidget {
  _VerticalList({Key? key}) : super(key: key);

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
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => OtherProfileIndex()
                ),
              );
            },
            child: ListCard(
              avaterImagePath: verticalData['avaterImagePath'],
              bgImagePath: verticalData['bgImagePath'],
              companyName: verticalData['companyName'],
              userName: verticalData['userName'],
              tagList: verticalData['tagList'],
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
