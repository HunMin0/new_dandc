import 'package:Deal_Connect/components/layout/default_basic_layout.dart';
import 'package:Deal_Connect/db/trade_data.dart';
import 'package:Deal_Connect/pages/history/components/list_card.dart';
import 'package:Deal_Connect/pages/history/history_detail/history_detail_index.dart';
import 'package:Deal_Connect/pages/history/history_ranking/history_ranking_index.dart';
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
    return DefaultBasicLayout(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 510.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '나의 브릿지 현황',
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
                    _buildMyRanking(),
                    SizedBox(
                      height: 14.0,
                    ),
                    _buildApproval(),
                    SizedBox(
                      height: 10.0,
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
                      Text('판매내역'),
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
                      Text('구매내역'),
                      Text(
                        '788,793원',
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
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: HexColor('#FFFFFF'),
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.6,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        minHeight: 6,
                        backgroundColor: HexColor('#D9D9D9'),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(HexColor('#75A8E4')),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  children: [
                    Text(
                      "60건",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      "37건",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
            text: const TextSpan(
              text: '총 누적거래 ',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF666666),
                  fontSize: 13),
              children: <TextSpan>[
                TextSpan(
                  text: '97건',
                  style: TextStyle(
                    color: Color(0xFF75A8E4),
                  ),
                ),
                TextSpan(
                  text: ' 중 ',
                ),
                TextSpan(
                  text: '판매내역이 ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: '23건',
                  style: TextStyle(
                    color: Color(0xFF75A8E4),
                  ),
                ),
                TextSpan(
                  text: " 많아요\u{1f525}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
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
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => HistoryRankingIndex()));
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

class _buildApproval extends StatelessWidget {
  const _buildApproval({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 18.0,
      ),
      decoration: BoxDecoration(
        color: HexColor('#F5F6FA'),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoryDetailIndex(
                            historyType: 'mine',
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.add_alert_rounded,
                    color: HexColor('#666666'),
                    size: 20.0,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('나의 승인 내역'),
                  const Spacer(),
                  Text(
                    '10건',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.chevron_right,
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoryDetailIndex(
                            historyType: 'partner',
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.list_alt,
                    color: HexColor('#666666'),
                    size: 20.0,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('파트너 승인 요청 내역'),
                  const Spacer(),
                  Text(
                    '3건',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: HexColor('#666666'),
                    size: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}