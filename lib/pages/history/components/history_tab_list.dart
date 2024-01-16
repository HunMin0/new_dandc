import 'package:Deal_Connect/db/trade_data.dart';
import 'package:Deal_Connect/pages/history/components/list_card.dart';
import 'package:flutter/cupertino.dart';

class HistoryTabList extends StatefulWidget {
  const HistoryTabList({super.key});

  @override
  State<HistoryTabList> createState() => _HistoryTabListState();
}

class _HistoryTabListState extends State<HistoryTabList> {

  @override
  void initState() {
    super.initState();
    print('22초기화');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: tradeDataList.isNotEmpty
            ? ListView.builder(
          itemCount: tradeDataList.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> tradeData = tradeDataList[index];
            return GestureDetector(
              onTap: () {
                print('클릭했다~ ');
              },
              child: ListCard(
                created_at: tradeData['created_at'],
                companyCeo: tradeData['companyCeo'],
                companyName: tradeData['companyName'],
                trade_name: tradeData['trade_name'],
                trade_price: tradeData['trade_price'],
                buyer: tradeData['buyer'],
              ),
            );
          },
        )
            : const Text('등록된 데이터가 없습니다'),
    );
  }
}
