import 'package:Deal_Connect/api/trade.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_ranking_group_user_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/model/group_user.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GroupTradeIndex extends StatefulWidget {
  const GroupTradeIndex({Key? key}) : super(key: key);

  @override
  State<GroupTradeIndex> createState() => _GroupTradeIndexState();
}

class _GroupTradeIndexState extends State<GroupTradeIndex> {
  bool _isLoading = true;
  var tradeHistoryDashboardData;
  List<GroupUser>? groupRankingPartnerList = [];
  int? groupId;
  String? groupName;

  var args;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    final widgetsBinding = WidgetsBinding.instance;
    widgetsBinding?.addPostFrameCallback((callback) async {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        setState(() {
          args = ModalRoute.of(context)?.settings.arguments;
        });

        if (args != null) {
          setState(() {
            groupId = args['groupId'];
            groupName = args['groupName'];
          });
        }

        if (groupId != null) {
          getGroupTradeHistoryDashboard(groupId!).then((response) {
            if (response.status == 'success') {
              var responseData = response.data;

              setState(() {
                if (responseData != null) {
                  tradeHistoryDashboardData = responseData;
                }
              });
            }
          });
          _initGroupTradeRanking(groupId!);
        }
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _initGroupTradeRanking(groupId) async {
    await getGroupTradeRanking(queryMap: { 'group_id': groupId }).then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;

        List<GroupUser>? resData =
        List<GroupUser>.from(iterable.map((e) => GroupUser.fromJSON(e)));

        setState(() {
          groupRankingPartnerList = resData;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    int totalAmount = 0;
    int totalCount = 0;
    int priceAverage = 0;

    if (tradeHistoryDashboardData != null) {
      if (tradeHistoryDashboardData['total_amount'] != null) {
        if (tradeHistoryDashboardData!['total_amount'] is String) {
          totalAmount = int.parse(tradeHistoryDashboardData!['total_amount']);
        } else {
          totalAmount = tradeHistoryDashboardData!['total_amount'];
        }
      }

      if (tradeHistoryDashboardData['totalCount'] != null) {
        if (tradeHistoryDashboardData!['totalCount'] is String) {
          totalCount = int.parse(tradeHistoryDashboardData!['total_count']);
        } else {
          totalCount = tradeHistoryDashboardData!['total_count'];
        }
      }

      if (tradeHistoryDashboardData['price_average'] != null) {
        if (tradeHistoryDashboardData!['price_average'] is String) {
          priceAverage = int.parse(tradeHistoryDashboardData!['price_average']);
        } else {
          priceAverage = tradeHistoryDashboardData!['price_average'];
        }
      }
    }

    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return Loading();
    }
    return DefaultLogoLayout(
      isNotInnerPadding: 'true',
      titleName: groupName,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 320.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$groupName의\nDeal & Connect',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: HexColor('#F5F6FA'),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('총 거래 금액', style: SettingStyle.SMALL_TEXT_STYLE),
                                      Text(
                                        Utils.moneyGenerator(totalAmount),
                                        style: SettingStyle.TITLE_STYLE,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Container(
                                  width: 1,
                                  height: 40,
                                  color: Color(0xFFDDDDDD),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('총 거래 건수', style: SettingStyle.SMALL_TEXT_STYLE),
                                      Text(
                                        '${totalCount.toString()}건',
                                        style: SettingStyle.TITLE_STYLE,
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
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('평균 거래금액', style: SettingStyle.SMALL_TEXT_STYLE),
                                      if (tradeHistoryDashboardData != null)
                                      Text(
                                        Utils.moneyGenerator(priceAverage),
                                        style: SettingStyle.TITLE_STYLE,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/group/trade/detail', arguments: { 'groupId' : groupId, 'groupName': groupName });
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
                                        '상세 거래내역 보기',
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
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 14.0,
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
          SliverToBoxAdapter(
            child: Container(
                height: 50.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Deal&Connect 랭킹',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Spacer(),
                          Text('최근 30일')
                        ],
                      ),
                    ],
                  ),
                )),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              color: Color(0xFFF5F6FA),
              thickness: 16.0,
            ),
          ),
          groupRankingPartnerList != null && groupRankingPartnerList!.isNotEmpty ?
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    GroupUser item = groupRankingPartnerList![index];
                return ListRankingGroupUserCard(item: item, index: index);
              },
              childCount: groupRankingPartnerList!.length,
            ),
          ) : const SliverToBoxAdapter(
            child: NoItems(),
          ),

        ],
      ),
    );
  }
}

