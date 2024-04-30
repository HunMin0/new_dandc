import 'package:Deal_Connect/api/ad_manage.dart';
import 'package:Deal_Connect/api/business.dart';
import 'package:Deal_Connect/api/categories.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_basic_layout.dart';
import 'package:Deal_Connect/components/list_business_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/model/ad_manage.dart';
import 'package:Deal_Connect/model/category.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/model/user_business.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// 사업장찾기
class BusinessIndex extends StatefulWidget {
  const BusinessIndex({Key? key}) : super(key: key);

  @override
  State<BusinessIndex> createState() => _BusinessIndexState();
}

class _BusinessIndexState extends State<BusinessIndex>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? tabController;
  String? searchKeyword = '';
  int? searchCategory;

  List<UserBusiness>? userBusinessList = [];
  List<Category>? categoryList;
  List<AdManage>? adManageList = [];
  TextEditingController _textController = TextEditingController();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initCategoryData();
  }

  void _initCategoryData() async {
    var response = await getCategories();
    if (response.status == 'success' && mounted) {
      Iterable iterable = response.data;
      List<Category>? newCategoryList =
          List<Category>.from(iterable.map((e) => Category.fromJSON(e)));
      setState(() {
        categoryList = newCategoryList;
        if (categoryList != null) {
          tabController = TabController(
            length: categoryList!.length + 1,
            vsync: this,
          );
        }
      });
      await _initUserBusinessData();
      await _initAdData();
    }
  }

  Future<void> _initUserBusinessData() async {
    var response = await getUserBusinesses(queryMap: {
      'do_not_include_mine': true,
      'keyword': _textController.text,
      'category': searchCategory
    });
    if (response.status == 'success' && mounted) {
      Iterable iterable = response.data;
      List<UserBusiness>? userBusinessList = List<UserBusiness>.from(
          iterable.map((e) => UserBusiness.fromJSON(e)));
      setState(() {
        if (userBusinessList != null) {
          this.userBusinessList = userBusinessList;
        }
        _isLoading = false;
      });
    }
  }

  Future<void> _initAdData() async {
    var response = await getAds(queryMap: {
      'ad_type': '1',
    });
    if (response.status == 'success' && mounted) {
      Iterable iterable = response.data;
      List<AdManage>? adManageList = List<AdManage>.from(
          iterable.map((e) => AdManage.fromJSON(e)));
      setState(() {
        if (adManageList != null) {
          this.adManageList = adManageList;
        }
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_isLoading || categoryList == null || tabController == null) {
      // 로딩 중 인디케이터 표시
      return const Loading();
    }

    return DefaultBasicLayout(
        child: Container(
      color: SettingStyle.GREY_COLOR,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              setState(() {
                _isLoading = true;
              });
              _initCategoryData();
              _initUserBusinessData();
            },
          ),

          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: false,
            expandedHeight: 80,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextField(
                              controller: _textController,
                              onSubmitted: (keyword) {
                                setState(() {
                                  _isLoading = true;
                                  // searchKeyword = keyword;
                                  _textController.text = keyword;
                                });
                                _initUserBusinessData();
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: HexColor("#F5F6FA"),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  // 테두리를 둥글게 설정
                                  borderSide: BorderSide.none, // 바텀 border 없애기
                                ),
                                prefixIcon: const Icon(Icons.search_rounded),
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
          ),
          if (adManageList != null && adManageList!.isNotEmpty)
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: 80, // 슬라이더의 높이 설정, 필요에 따라 조정
                child: PageView.builder(
                  itemCount: adManageList!.length, // 광고 리스트의 개수
                  controller: PageController(viewportFraction: 1.0), // 한 화면에 보이는 페이지 비율 조정
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/business/info',
                            arguments: {"userBusinessId": int.parse(adManageList![index].ad_link.split('=').last)});
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 5.0), // 컨테이너 간 간격 조정
                        decoration: BoxDecoration(
                          color: SettingStyle.GREY_COLOR, // 배경색 설정
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              Utils.getImageFilePath(adManageList![index].has_image!),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
                        _isLoading = true;
                      });
                      _initUserBusinessData();
                    },
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
                        child: Text('전체'), // "전체" 탭 추가
                      ),
                      ...categoryList!.map((Category category) {
                        return Tab(
                          child: Text(category.name), // 나머지 카테고리 탭 추가
                        );
                      }).toList(),
                    ]),
              ),
              pinned: true,
            ),
          const SliverToBoxAdapter(
            child: Divider(
              color: Color(0xFFF5F6FA),
              thickness: 10.0,
              height: 10.0,
            ),
          ),
          userBusinessList != null && userBusinessList!.isNotEmpty
              ? SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      UserBusiness item = userBusinessList![index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/business/info',
                                arguments: {"userBusinessId": item.id});
                          },
                          child: ListBusinessCard(item: item));
                    },
                    childCount: userBusinessList!.length, // 아이템 개수
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 한 줄에 2개의 아이템
                    crossAxisSpacing: 10.0, // 아이템 간의 가로 간격
                    mainAxisSpacing: 10.0, // 아이템 간의 세로 간격
                    childAspectRatio: 1 / 1.4,
                  ),
                )
              : const SliverToBoxAdapter(
                  child: NoItems(),
                )
        ],
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
