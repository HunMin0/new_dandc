import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/pages/trade/trade_buy/trade_buy_create_confirm.dart';
import 'package:Deal_Connect/pages/trade/trade_buy/trade_buy_create_form.dart';
import 'package:Deal_Connect/pages/trade/trade_sell/trade_sell_create_confirm.dart';
import 'package:Deal_Connect/pages/trade/trade_sell/trade_sell_create_form.dart';
import 'package:flutter/material.dart';

class TradeSellCreate extends StatefulWidget {
  const TradeSellCreate({super.key});

  @override
  State<TradeSellCreate> createState() => _TradeSellCreateState();
}

class _TradeSellCreateState extends State<TradeSellCreate> {
  int _currentIndex = 0;
  final _pages = [
    TradeSellCreateConfirm(),
    TradeSellCreateForm(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultNextLayout(
      nextTitle: _currentIndex == 0 ? '확인' : '승인 요청',
      prevTitle: '',
      titleName: '판매등록',
      isCancel: false,
      isProcessable: true,
      bottomBar: true,
      isNotInnerPadding: 'true',
      nextOnPressed: () {
        _currentIndex == 0 ?
        setState(() {
          _currentIndex = 1;
        })
            : _showCompleteDialog(context);
      },
      prevOnPressed: () {},
      child: _pages[_currentIndex],
    );
  }

  void _showCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowCompleteDialog(
          messageTitle: '거래등록완료',
          messageText: '등록이 완료되었습니다.',
          buttonText: '확인',
          onConfirmed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        );
      },
    );
  }
}
