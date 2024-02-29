import 'package:Deal_Connect/api/partner.dart';
import 'package:Deal_Connect/components/layout/default_search_layout.dart';
import 'package:Deal_Connect/components/list_partner_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/model/partner.dart';
import 'package:Deal_Connect/pages/trade/trade_sell/trade_sell_create.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TradeSellIndex extends StatefulWidget {
  TradeSellIndex({
    Key? key,
  }) : super(key: key);

  @override
  State<TradeSellIndex> createState() => _TradeSellIndexState();
}

class _TradeSellIndexState extends State<TradeSellIndex> {
  String? searchKeyword;
  List<Partner>? partnerList = [];
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    getPartners(queryMap: { 'keyword': searchKeyword }).then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;
        List<Partner>? partnerListData = List<Partner>.from(
            iterable.map((e) => Partner.fromJSON(e)));
        setState(() {
          if (partnerListData != null) {
            this.partnerList = partnerListData;
          }
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || partnerList == null) {
      return Loading();
    }

    return DefaultSearchLayout(
      isNotInnerPadding: 'true',
      onSubmit: (keyword) {
        setState(() {
          searchKeyword = keyword;
          _initData();
        });
      },
      child: Container(
        color: HexColor('#F5F6FA'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            partnerList != null && partnerList!.isNotEmpty ? Expanded(child: Container(
              padding: EdgeInsets.all(13.0),
              decoration: BoxDecoration(
                color: Color(0xFFf5f6f8),
              ),
              child: ListView.builder(
                itemCount: partnerList!.length,
                itemBuilder: (context, index) {
                  Partner item = partnerList![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/trade/sell/create', arguments: {'userId' : item.has_user!.id});
                    },
                    child: ListPartnerCard(item : item.has_user, onApprovePressed: () {}, onDeletePressed: () {},),
                  );
                },
              ),
            )) : NoItems()
          ],
        ),
      ),
    );
  }
}
