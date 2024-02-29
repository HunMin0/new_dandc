import 'package:Deal_Connect/api/trade.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_trade_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/model/trade.dart';
import 'package:Deal_Connect/pages/history/components/search_term_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HistoryDetailIndex extends StatefulWidget {
  HistoryDetailIndex({super.key});

  @override
  State<HistoryDetailIndex> createState() => _HistoryDetailIndexState();
}

class _HistoryDetailIndexState extends State<HistoryDetailIndex> {
  bool _isLoading = true;
  List<Trade>? tradeList;
  String? division;
  String? divisionString;
  int selectedMonth = 0;

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
            division = args['division'];
          });
        }
        if (division != null) {
          if (division == 'mine') {
            divisionString = 'is_need_my_approved';
          } else {
            divisionString = 'is_need_partner_approved';
          }
          await getTrades(
                  queryMap: {divisionString: true , 'selected_month': selectedMonth})
              .then((response) {
            if (response.status == 'success') {
              Iterable iterable = response.data;

              List<Trade>? tradeList =
                  List<Trade>.from(iterable.map((e) => Trade.fromJSON(e)));

              setState(() {
                this.tradeList = tradeList;
                _isLoading = false;
              });
            }
          });
        }
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return const Loading();
    }

    return DefaultLogoLayout(
      isNotInnerPadding: 'true',
      titleName: '내가 받은 승인 요청',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('총 ${tradeList!.length} 건'),
                Spacer(),
                DropdownButton<int>(
                  value: selectedMonth, // 여기서 selectedMonth는 int 타입의 상태 변수입니다.
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedMonth = newValue!;
                    });
                    _initData();
                  },
                  items: const [
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text('이번 달'),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Text('최근 3개월'),
                    ),
                    DropdownMenuItem<int>(
                      value: 6,
                      child: Text('최근 6개월'),
                    ),
                    DropdownMenuItem<int>(
                      value: 12,
                      child: Text('최근 1년'),
                    ),
                    DropdownMenuItem<int>(
                      value: 0, // '전체'를 나타내는 경우 특별한 값 (예: 0)을 할당할 수 있습니다.
                      child: Text('전체'),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
            child: Container(
              decoration: BoxDecoration(color: HexColor('#F5F6FA')),
            ),
          ),
          tradeList != null && tradeList!.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                  itemCount: tradeList!.length,
                  itemBuilder: (context, index) {
                    Trade item = tradeList![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/trade/history/info',
                            arguments: {'tradeId': item.id}).then((value) {
                          _initData();
                        });
                      },
                      child: ListTradeCard(item: item),
                    );
                  },
                ))
              : NoItems(),
        ],
      ),
    );
  }
}
