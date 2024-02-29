import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/api/trade.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/form_data/trade_form_data.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/model/user_business.dart';
import 'package:Deal_Connect/pages/trade/trade_buy/trade_buy_create_confirm.dart';
import 'package:Deal_Connect/pages/trade/trade_buy/trade_buy_create_form.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:flutter/material.dart';

class TradeBuyCreate extends StatefulWidget {
  const TradeBuyCreate({super.key});

  @override
  State<TradeBuyCreate> createState() => _TradeBuyCreateState();
}

class _TradeBuyCreateState extends State<TradeBuyCreate> {
  int _currentIndex = 0;
  int? userBusinessId;
  UserBusiness? userBusiness;
  User? myUserInfo;
  bool _isLoading = true;
  bool _isProcessable = false;
  final TradeFormData _formData = TradeFormData();

  late List<Widget> _widgetOptions;
  var args;

  User? myUser;

  @override
  void initState() {
    getMyUser().then((response) {
      if (response.status == 'success') {
        User user = User.fromJSON(response.data);
        setState(() {
          myUserInfo = user;
        });
        SharedPrefUtils.setUser(user).then((value) {
          SharedPrefUtils.getUser().then((user) {
            setState(() {
              myUser = user;
            });
          });
        });
      }
    });
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
            userBusinessId = args['userBusinessId'];
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
      TradeBuyCreateConfirm(userBusinessId: userBusinessId),
      TradeBuyCreateForm(formData: _formData, onProcessableChanged: _updateIsProcessable),
    ];

    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return Loading();
    }
    return DefaultNextLayout(
      nextTitle: _currentIndex == 0 ? '확인' : '승인 요청',
      prevTitle: '',
      titleName: '구매등록',
      isCancel: false,
      isProcessable: _currentIndex == 1 ? _isProcessable : true,
      bottomBar: true,
      isNotInnerPadding: 'true',
      nextOnPressed: () {
        _currentIndex == 0 ?
          setState(() {
            _currentIndex = 1;
          })
        : _submit(context);
      },
      prevOnPressed: () {},
      child: _widgetOptions.elementAt(_currentIndex),
    );
  }


  _submit(BuildContext context) async {
    CustomDialog.showProgressDialog(context);
    _formData.userBusinessId = userBusinessId;
    _formData.tradeType = 'buy';

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
