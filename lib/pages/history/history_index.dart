import 'dart:ffi';

import 'package:Deal_Connect/api/trade.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_basic_layout.dart';
import 'package:Deal_Connect/components/list_trade_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/db/trade_data.dart';
import 'package:Deal_Connect/model/trade.dart';
import 'package:Deal_Connect/pages/history/components/list_card.dart';
import 'package:Deal_Connect/pages/history/history_detail/history_detail_index.dart';
import 'package:Deal_Connect/pages/history/history_ranking/history_ranking_index.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HistoryIndex extends StatefulWidget {
  const HistoryIndex({Key? key}) : super(key: key);

  @override
  State<HistoryIndex> createState() => _HistoryIndexState();
}

class _HistoryIndexState extends State<HistoryIndex>
    with TickerProviderStateMixin {
  late final TabController tabController;
  var tradeHistoryDashboardData;
  List<Trade>? tradeList = [];
  bool _isLoading = true;
  String tradeType = '';

  @override
  void initState() {
    _initData();
    super.initState();
    // tab컨트롤러 초기화
    tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  void _initData() {
    getTradeHistoryDashboard(context).then((response) {
      if (response.status == 'success') {
        var responseData = response.data;

        setState(() {
          if (responseData != null) {
            tradeHistoryDashboardData = responseData;
          }
        });
      }
      _initTradeData();
    });

    setState(() {
      _isLoading = false;
    });
  }

  void _initTradeData() {
    getTrades(queryMap: {'trade_type': tradeType, 'is_my_trades' : 'true'}).then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;

        List<Trade>? tradeListData =
            List<Trade>.from(iterable.map((e) => Trade.fromJSON(e)));

        setState(() {
          this.tradeList = tradeListData;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalSellAmount = 0;
    int totalBuyAmount = 0;
    int totalBuyCount = 0;
    int totalSellCount = 0;
    int totalCount = 0;
    int countSpace = 0;
    String sellOrBuy = '';
    int totalNeedMyApproveCount = 0;
    int totalNeedPartnerApproveCount = 0;

    if (tradeHistoryDashboardData != null) {
      if (tradeHistoryDashboardData!['total_sell_amount'] != null &&
          tradeHistoryDashboardData!['total_sell_amount'] is String) {
        totalSellAmount =
            int.parse(tradeHistoryDashboardData!['total_sell_amount']) ?? 0;
      }

      if (tradeHistoryDashboardData!['total_buy_amount'] != null &&
          tradeHistoryDashboardData!['total_buy_amount'] is String) {
        totalBuyAmount =
            int.parse(tradeHistoryDashboardData!['total_buy_amount']) ?? 0;
      }

      if (tradeHistoryDashboardData!['total_sell_count'] != null &&
          tradeHistoryDashboardData!['total_sell_count'] is int) {
        totalSellCount = tradeHistoryDashboardData!['total_sell_count'] ?? 0;
      }

      if (tradeHistoryDashboardData!['total_buy_count'] != null &&
          tradeHistoryDashboardData!['total_buy_count'] is int) {
        totalBuyCount = tradeHistoryDashboardData!['total_buy_count'] ?? 0;
      }

      if (tradeHistoryDashboardData['total_count'] != null &&
          tradeHistoryDashboardData['total_count'] is int) {
        totalCount = tradeHistoryDashboardData!['total_count'] ?? 0;
      }

      if (tradeHistoryDashboardData!['total_need_my_approve_count'] != null &&
          tradeHistoryDashboardData!['total_need_my_approve_count'] is int) {
        totalNeedMyApproveCount =
            tradeHistoryDashboardData!['total_need_my_approve_count'] ?? 0;
      }

      if (tradeHistoryDashboardData['total_need_partner_approve_count'] !=
              null &&
          tradeHistoryDashboardData['total_need_partner_approve_count']
              is int) {
        totalNeedPartnerApproveCount =
            tradeHistoryDashboardData!['total_need_partner_approve_count'] ?? 0;
      }

      if (totalSellCount > totalBuyCount) {
        sellOrBuy = '판매';
        countSpace = totalSellCount - totalBuyCount;
      }

      if (totalBuyCount > totalSellCount) {
        sellOrBuy = '구매';
        countSpace = totalBuyCount - totalSellCount;
      }
    }

    if (_isLoading || tradeHistoryDashboardData == null) {
      // 로딩 중 인디케이터 표시
      return Loading();
    }
    return DefaultBasicLayout(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 510.0,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '나의 브릿지 현황',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 14.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: HexColor('#F5F6FA'),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('판매내역'),
                                      Text(
                                        Utils.parsePrice(totalSellAmount),
                                        style: SettingStyle.SUB_TITLE_STYLE,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Container(
                                  width: 1,
                                  height: 40,
                                  color: const Color(0xFFDDDDDD),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('구매내역'),
                                      Text(
                                        Utils.parsePrice(totalBuyAmount),
                                        style: SettingStyle.SUB_TITLE_STYLE,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 20.0),
                            decoration: BoxDecoration(
                              color: HexColor('#FFFFFF'),
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      "판매",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "구매",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: LinearProgressIndicator(
                                        value: totalCount == 0
                                            ? 0
                                            : (totalSellCount /
                                                totalCount.toDouble()),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        minHeight: 6,
                                        backgroundColor: HexColor('#D9D9D9'),
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                HexColor('#75A8E4')),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '$totalSellCount 건',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    Text(
                                      '$totalBuyCount 건',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (sellOrBuy != '')
                            RichText(
                              text: TextSpan(
                                text: '총 누적거래 ',
                                style: SettingStyle.SMALL_TEXT_STYLE
                                    .copyWith(color: Color(0xFF444444)),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '$totalCount 건',
                                    style: SettingStyle.SMALL_TEXT_STYLE
                                        .copyWith(color: Color(0xFF75A8E4)),
                                  ),
                                  TextSpan(
                                    text: ' 중 ',
                                    style: SettingStyle.SMALL_TEXT_STYLE
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: '$sellOrBuy 건 수가 ',
                                    style: SettingStyle.SMALL_TEXT_STYLE
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: countSpace.toString() + ' 건',
                                    style: SettingStyle.SMALL_TEXT_STYLE
                                        .copyWith(color: Color(0xFF75A8E4)),
                                  ),
                                  TextSpan(
                                    text: " 많아요\u{1f525}",
                                    style: SettingStyle.SMALL_TEXT_STYLE
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 14.0,
                    ),
                    _buildMyRanking(),
                    const SizedBox(
                      height: 14.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 18.0,
                      ),
                      decoration: BoxDecoration(
                        color: HexColor('#F5F6FA'),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                      context, '/trade/history/approve',
                                      arguments: {'division': 'mine'})
                                  .then((value) {
                                _initData();
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.bell_solid,
                                    color: HexColor('#666666'),
                                    size: 20.0,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text('내가 받은 승인 요청'),
                                  const Spacer(),
                                  Text(
                                    '$totalNeedMyApproveCount 건',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    CupertinoIcons.right_chevron,
                                    color: HexColor('#666666'),
                                    size: 20.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: HexColor('#D9D9D9'),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                      context, '/trade/history/approve',
                                      arguments: {'division': 'partner'})
                                  .then((value) {
                                _initData();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.list_bullet,
                                    color: HexColor('#666666'),
                                    size: 20.0,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text('내가 보낸 승인 요청'),
                                  const Spacer(),
                                  Text(
                                    '$totalNeedPartnerApproveCount 건',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    CupertinoIcons.right_chevron,
                                    color: HexColor('#666666'),
                                    size: 20.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              color: Color(0xFFF5F6FA),
              thickness: 16.0,
            ),
          ),
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
                  _initTradeData();
                },
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
            ),
            pinned: true,
          ),
          const SliverToBoxAdapter(
            child: Divider(
              color: Color(0xFFF5F6FA),
              thickness: 16.0,
            ),
          ),
          tradeList != null && tradeList!.isNotEmpty
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/trade/history/info',
                                arguments: {'tradeId': tradeList![index].id})
                                .then((value) {
                              _initData();
                            });
                          },
                          child: ListTradeCard(
                            item: tradeList![index],
                          ));
                    },
                    childCount: tradeList!.length,
                  ),
                )
              : const SliverToBoxAdapter(
                  child: NoItems(),
                ),
        ],
      ),
    );
  }
}

class _buildMyRanking extends StatelessWidget {
  const _buildMyRanking({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/trade/history/ranking');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
        decoration: BoxDecoration(
          color: HexColor('#75A8E4'),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '나의 파트너들 중 누가 제일 큰손일까요!?',
                  style: TextStyle(
                    color: HexColor('#FFFFFF'),
                    fontSize: 13,
                  ),
                ),
                Text(
                  '랭킹 보러가기',
                  style: TextStyle(
                      color: HexColor('#FFFFFF'),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: Colors.white,
              size: 24.0,
            ),
          ],
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
