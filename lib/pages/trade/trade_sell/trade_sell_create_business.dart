import 'dart:ui';

import 'package:Deal_Connect/api/business.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/list_business_card.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/form_data/trade_form_data.dart';
import 'package:Deal_Connect/model/user_business.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TradeSellCreateBusiness extends StatefulWidget {
  final TradeFormData formData;
  bool isProcessable = false;

  void Function(bool) onProcessableChanged;

  TradeSellCreateBusiness(
      {required this.formData, required this.onProcessableChanged});

  @override
  State<TradeSellCreateBusiness> createState() =>
      _TradeSellCreateBusinessState();
}

class _TradeSellCreateBusinessState extends State<TradeSellCreateBusiness> {
  List<UserBusiness>? userBusinessList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initUserBusinessData();
  }

  void _initUserBusinessData() {
    getUserBusinesses(queryMap: {'is_mine': true}).then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;

        List<UserBusiness>? userBusinessList = List<UserBusiness>.from(
            iterable.map((e) => UserBusiness.fromJSON(e)));

        setState(() {
          if (userBusinessList != null) {
            this.userBusinessList = userBusinessList;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(13.0),
          child: Text('판매등록을 진행할\n회원님의 업체를 선택해주세요.',
              style: SettingStyle.TITLE_STYLE),
        ),
        userBusinessList != null && userBusinessList!.isNotEmpty
            ? Expanded(
                child: Container(
                    color: Color(0xFFf5f6f8),
                    padding: EdgeInsets.all(14.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 한 줄에 2개의 아이템
                        crossAxisSpacing: 10.0, // 아이템 간의 가로 간격
                        mainAxisSpacing: 10.0, // 아이템 간의 세로 간격
                        childAspectRatio: 1 / 1.4,
                      ),
                      itemCount: userBusinessList!.length, // 아이템 개수
                      itemBuilder: (context, index) {
                        UserBusiness item = userBusinessList![index];
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.formData.userBusinessId = item.id;
                                _checkProcessable();
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  border: Border.all(width:2, color: widget.formData.userBusinessId == item.id ? SettingStyle.MAIN_COLOR : Colors.transparent )
                                ),
                                child: ListBusinessCard(item: item)
                            )
                        );
                      },
                    )),
              )
            : NoItems(),
      ],
    ));
  }

  void _checkProcessable() {
    bool isProcessable = widget.formData.userBusinessId != null;
    widget.onProcessableChanged(isProcessable);
  }
}
