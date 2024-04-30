import 'package:Deal_Connect/api/group_trade.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/list_group_trade_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/model/group_trade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupTradeMineList extends StatefulWidget {
  int? groupId;
  String? groupName;

  GroupTradeMineList({this.groupId, this.groupName, super.key});

  @override
  State<GroupTradeMineList> createState() => _GroupTradeMineListState();
}

class _GroupTradeMineListState extends State<GroupTradeMineList>
    with TickerProviderStateMixin {
  late final TabController tabController;
  List<GroupTrade> groupTradeList = [];
  bool _isLoading = true;
  String tradeType = '';

  @override
  void initState() {
    super.initState();
    super.initState();
    _initData();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  void _initData() {
    getGroupTrades(queryMap: {'group_id': widget.groupId, 'trade_type': tradeType}).then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;

        List<GroupTrade>? resData =
        List<GroupTrade>.from(iterable.map((e) => GroupTrade.fromJSON(e)));
        setState(() {
          this.groupTradeList = resData;
        });
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return Loading();
    }

    return Expanded(
      child: Container(
        color: SettingStyle.GREY_COLOR,
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _isLoading = true;
            });
            _initData();
          },
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
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
                    onTap: (value) {
                      setState(() {
                        if (value == 0) {
                          tradeType = '';
                        }
                        if (value == 1) {
                          tradeType = 'buy';
                        }
                        if (value == 2) {
                          tradeType = 'sell';
                        }
                      });
                      _initData();
                    },
                    tabs: const [
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
                ),
                pinned: true,
              ),
              const SliverToBoxAdapter(
                child: Divider(
                  color: Color(0xFFF5F6FA),
                  thickness: 16.0,
                ),
              ),
              groupTradeList.isNotEmpty
                  ? SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/trade/history/info',
                                arguments: {'tradeId': groupTradeList[index].has_trade!.id});
                          },
                          child: ListGroupTradeCard(
                            item: groupTradeList[index],
                          )),
                    );
                  },
                  childCount: groupTradeList.length,
                ),
              )
                  : const SliverToBoxAdapter(
                child: NoItems(),
              ),
            ],
          ),
        ),
      ),
    );
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