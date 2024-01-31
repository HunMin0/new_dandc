import 'package:Deal_Connect/components/layout/default_basic_layout.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/db/trade_data.dart';
import 'package:Deal_Connect/pages/history/components/list_card.dart';
import 'package:Deal_Connect/pages/history/history_detail/history_detail_index.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GroupTradeIndex extends StatefulWidget {
  const GroupTradeIndex({Key? key}) : super(key: key);

  @override
  State<GroupTradeIndex> createState() => _GroupTradeIndexState();
}

class _GroupTradeIndexState extends State<GroupTradeIndex>
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
    return DefaultLogoLayout(
      isNotInnerPadding: 'true',
      titleName: '서초구 고기집 사장모임',
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 330.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '서초구 고기집 사장모임의\nDeal & Connect',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    _buildHistoryBox(),
                    SizedBox(
                      height: 14.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Divider(
              color: Color(0xFFF5F6FA),
              thickness: 16.0,
            ),
          ),
          SliverPersistentHeader(
            delegate: MySliverPersistentHeaderDelegate(tabController),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Divider(
              color: Color(0xFFF5F6FA),
              thickness: 16.0,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  child: tradeDataList.isNotEmpty
                      ? ListCard(
                    created_at: tradeDataList[index]['created_at'],
                    companyCeo: tradeDataList[index]['companyCeo'],
                    companyName: tradeDataList[index]['companyName'],
                    trade_name: tradeDataList[index]['trade_name'],
                    trade_price: tradeDataList[index]['trade_price'],
                    buyer: tradeDataList[index]['buyer'],
                  )
                      : const Text('등록된 데이터가 없습니다'),
                );
              },
              childCount: tradeDataList.length,
            ),
          ),
        ],
      ),
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;

  MySliverPersistentHeaderDelegate(this.tabController);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 50.0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Deal&Connect 랭킹', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          ],
        ),
      )
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

class _buildHistoryBox extends StatelessWidget {
  const _buildHistoryBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      Text('총 거래 금액'),
                      Text(
                        '788,793원',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
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
                      Text('총 거래 건수'),
                      Text(
                        '788건',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
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
                      Text('1인당 평균 거래금액'),
                      Text(
                        '788,793원',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
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
                      Text('1인 평균 거래 건수'),
                      Text(
                        '788건',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20,),
          _buildMyRanking(),
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
    return Container(
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
    );
  }
}
