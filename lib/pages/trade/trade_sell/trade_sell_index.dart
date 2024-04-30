import 'package:Deal_Connect/api/partner.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
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
  TextEditingController _textController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    getPartners(queryMap: { 'keyword': _textController.text }).then((response) {
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

    return DefaultLogoLayout(
      isNotInnerPadding: 'true',
      titleName: '판매등록',
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Container(
              color: HexColor("#ffffff"),
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _textController,
                onSubmitted: (value) {
                  setState(() {
                    _isLoading = true;
                  });
                  _initData();
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
            Expanded(
              child: Container(
                color: Color(0xFFf5f6f8),
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
            ),
          ],
        ),
      ),
    );
  }
}
