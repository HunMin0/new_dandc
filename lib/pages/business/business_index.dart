import 'package:Deal_Connect/api/business.dart';
import 'package:Deal_Connect/api/categories.dart';
import 'package:Deal_Connect/components/layout/default_basic_layout.dart';
import 'package:Deal_Connect/components/list_business_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/model/category.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/model/user_business.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// 사업장찾기
class BusinessIndex extends StatefulWidget {
  const BusinessIndex({Key? key}) : super(key: key);

  @override
  State<BusinessIndex> createState() => _BusinessIndexState();
}

class _BusinessIndexState extends State<BusinessIndex>
    with TickerProviderStateMixin {
  TabController? tabController;
  String? searchKeyword = '';
  int? searchCategory;

  List<UserBusiness>? userBusinessList = [];
  List<Category>? categoryList;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initCategoryData();
    _initUserBusinessData();
  }

  void _initCategoryData() {
    getCategories().then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;
        List<Category>? newCategoryList =
            List<Category>.from(iterable.map((e) => Category.fromJSON(e)));
        setState(() {
          categoryList = newCategoryList;
          _isLoading = false;
          if (categoryList != null) {
            tabController = TabController(
              length: categoryList!.length + 1,
              vsync: this,
            );
          }
        });
      }
    });
  }

  void _initUserBusinessData() {
    getUserBusinesses(
            queryMap: {'do_not_include_mine': true, 'keyword': searchKeyword, 'category': searchCategory})
        .then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;

        List<UserBusiness>? userBusinessList = List<UserBusiness>.from(
            iterable.map((e) => UserBusiness.fromJSON(e)));

        setState(() {
          if (userBusinessList != null) {
            this.userBusinessList = userBusinessList;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    tabController?.dispose(); // tabController를 메모리에서 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || categoryList == null || tabController == null) {
      // 로딩 중 인디케이터 표시
      return Loading();
    }

    return DefaultBasicLayout(
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
                            onSubmitted: (keyword) {
                              setState(() {
                                searchKeyword = keyword;
                              });
                              _initUserBusinessData();
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
                                borderSide: BorderSide.none, // 바텀 border 없애기
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
              thickness: 8.0,
            ),
          ),
          if (categoryList != null)
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: tabController,
                  indicatorColor: Colors.black,
                  indicatorWeight: 2.0,
                  labelColor: Colors.black,
                  dividerColor: Colors.white,
                  unselectedLabelColor: Colors.grey[500],
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  onTap: (value) {

                    setState(() {
                      if (value > 0) {
                        searchCategory = categoryList![value - 1].id;
                      } else {
                        searchCategory = null;
                      }
                    });
                    _initUserBusinessData();
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
                      child: Text('전체'), // "전체" 탭 추가
                    ),
                    ...categoryList!.map((Category category) {
                      return Tab(
                        child: Text(category.name), // 나머지 카테고리 탭 추가
                      );
                    }).toList(),
                  ]
                ),
              ),
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
        child: userBusinessList != null && userBusinessList!.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 한 줄에 2개의 아이템
                  crossAxisSpacing: 10.0, // 아이템 간의 가로 간격
                  mainAxisSpacing: 10.0, // 아이템 간의 세로 간격
                  childAspectRatio: 1 / 1.4,
                ),
                itemCount: userBusinessList!.length, // 아이템 개수
                itemBuilder: (context, index) {
                  UserBusiness item = userBusinessList![index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/business/info',
                            arguments: {"userBusinessId": item.id});
                      },
                      child: ListBusinessCard(item: item)
                  );
                },
              )
            : NoItems(),
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
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
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

