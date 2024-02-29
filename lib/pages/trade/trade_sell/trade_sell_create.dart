import 'package:Deal_Connect/api/trade.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/form_data/trade_form_data.dart';
import 'package:Deal_Connect/pages/trade/trade_sell/trade_sell_create_business.dart';
import 'package:Deal_Connect/pages/trade/trade_sell/trade_sell_create_confirm.dart';
import 'package:Deal_Connect/pages/trade/trade_sell/trade_sell_create_form.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:flutter/material.dart';

class TradeSellCreate extends StatefulWidget {
  const TradeSellCreate({super.key});

  @override
  State<TradeSellCreate> createState() => _TradeSellCreateState();
}

class _TradeSellCreateState extends State<TradeSellCreate> {
  int _currentIndex = 0;
  int? userId;
  bool _isLoading = true;
  bool _isProcessable = false;
  final TradeFormData _formData = TradeFormData();

  late List<Widget> _widgetOptions;
  var args;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() {
    final widgetsBinding = WidgetsBinding.instance;
    widgetsBinding?.addPostFrameCallback((callback) async {
      if (ModalRoute
          .of(context)
          ?.settings
          .arguments != null) {
        setState(() {
          args = ModalRoute
              .of(context)
              ?.settings
              .arguments;
        });

        if (args != null) {
          setState(() {
            userId = args['userId'];
          });
        }

        setState(() {
          _isLoading = false;
        });
      }
    });
  }


  void _updateIsProcessable(bool isProcessable) {
    setState(() {
      _isProcessable = isProcessable;
    });
  }

  @override
  Widget build(BuildContext context) {
    _widgetOptions = <Widget>[
      TradeSellCreateBusiness(formData: _formData, onProcessableChanged: _updateIsProcessable),
      TradeSellCreateConfirm(userBusinessId: _formData.userBusinessId, partnerUserId: userId),
      TradeSellCreateForm(formData: _formData, onProcessableChanged: _updateIsProcessable),
    ];

    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return Loading();
    }

    return DefaultNextLayout(
      nextTitle: _currentIndex < 2 ? '확인' : '승인 요청',
      prevTitle: '',
      titleName: '판매등록',
      isCancel: false,
      isProcessable: _isProcessable,
      bottomBar: true,
      isNotInnerPadding: 'true',
      nextOnPressed: () {
        if (_currentIndex == 0) {
          setState(() {
            _currentIndex = 1;
          });
        } else if (_currentIndex == 1) {
          setState(() {
            _currentIndex = 2;
          });
        } else {
          _submit(context);
        }
      },
      prevOnPressed: () {},
      child: _widgetOptions.elementAt(_currentIndex),
    );
  }

  _submit(BuildContext context) async {
    CustomDialog.showProgressDialog(context);
    _formData.userId = userId;
    _formData.tradeType = 'sell';

    storeTrade(_formData.toMap(), _formData.receiptFile).then((response) async {
      CustomDialog.dismissProgressDialog();

      if (response.status == 'success') {
        _showCompleteDialog(context);
      } else {
        CustomDialog.showServerValidatorErrorMsg(response);
      }
    });
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
