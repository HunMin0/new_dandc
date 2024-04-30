import 'package:Deal_Connect/Utils/custom_dialog.dart';
import 'package:Deal_Connect/api/trade.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/common_item/color_chip.dart';
import 'package:Deal_Connect/components/common_item/expended_elevated_button.dart';
import 'package:Deal_Connect/components/common_item/stack_thumbnail.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/model/trade.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/pages/history/history_detail/reciept_view.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class HistoryDetailConfirm extends StatefulWidget {
  const HistoryDetailConfirm({super.key});

  @override
  State<HistoryDetailConfirm> createState() => _HistoryDetailConfirmState();
}

class _HistoryDetailConfirmState extends State<HistoryDetailConfirm> {
  bool _isLoading = true;
  String? division;
  int? tradeId;
  Trade? tradeData;
  User? myUser;
  TextEditingController _descriptionController = TextEditingController();

  var args;

  @override
  void initState() {
    _initMyUser();
    _initData();
    super.initState();
  }

  void _initMyUser() {
    SharedPrefUtils.getUser().then((value) => myUser = value);
  }

  void _initData() async {
    final widgetsBinding = WidgetsBinding.instance;
    widgetsBinding?.addPostFrameCallback((callback) async {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        setState(() {
          args = ModalRoute.of(context)?.settings.arguments;
        });

        if (args != null) {
          setState(() {
            tradeData = args['tradeData'];
            division = args['division'];
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
    if (_isLoading || tradeData == null) {
      return Loading();
    }

    return DefaultNextLayout(
      titleName: division == 'approved' ? '거래내역 승인하기' : '거래내역 반려하기',
      isNotInnerPadding: 'true',
      isProcessable: true,
      bottomBar: true,
      isCancel: true,
      nextTitle: '확인',
      prevTitle: '취소',
      nextOnPressed: () {
        _submitManage(division!);
      },
      prevOnPressed: () {
        Navigator.pop(context);
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: division == 'approved' ? Text(tradeData!.has_request_user != null
                          ? tradeData!.has_request_user!.name + ' 회원과의\n거래내역을 승인합니다.\n한마디 남겨보세요!'
                          : '', style: SettingStyle.TITLE_STYLE,) : Text(tradeData!.has_request_user != null
                          ? tradeData!.has_request_user!.name + ' 회원과의\n거래내역을 반려합니다.\n반려이유를 남겨주세요'
                          : '', style: SettingStyle.TITLE_STYLE,),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: HexColor("#F5F6FA"),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [

                          Row(
                            children: [
                              Text("거래일자"),
                              Spacer(),
                              Text(tradeData!.traded_at!.substring(0, 11) ?? '')
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text("거래업체"),
                              Spacer(),
                              Text(tradeData!.has_business!.name)
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text("거래항목"),
                              Spacer(),
                              Text(tradeData!.trade_services)
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text("거래금액"),
                              Spacer(),
                              Text(
                                  Utils.parsePrice(tradeData!.price)
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (tradeData!.user_description != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "[${tradeData!.has_buy_user!.name}]님 한마디",
                            style: SettingStyle.SUB_TITLE_STYLE,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: HexColor("#F5F6FA"),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(tradeData?.user_description ?? ''),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    if (tradeData!.business_user_description != null)
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "[${tradeData!.has_business!.name}]님 한마디",
                                style: SettingStyle.SUB_TITLE_STYLE,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: HexColor("#F5F6FA"),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(tradeData?.business_user_description ?? ''),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            '파트너 님께 한마디',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                        TextFormField(
                            controller: _descriptionController,
                            maxLines: 7,
                            decoration: SettingStyle.INPUT_STYLE.copyWith(
                              hintText: '파트너님께 남기고 싶은 말을 남겨주세요.',
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitManage(String mode) {
    if (mode == 'approved') {
      CustomDialog.showDoubleBtnDialog(
          context: context,
          msg: '정말 승인 하시겠습니까?',
          rightBtnText: '승인',
          onLeftBtnClick: () {},
          onRightBtnClick: () {
            _manageSubmit('approved');
          });
    }
    if (mode == 'rejected') {
      CustomDialog.showDoubleBtnDialog(
          context: context,
          msg: '정말 반려 하시겠습니까?',
          rightBtnText: '반려',
          onLeftBtnClick: () {},
          onRightBtnClick: () {
            _manageSubmit('rejected');
          });
    }
  }

  void _manageSubmit(String tradeStatus) {
    CustomDialog.showProgressDialog(context);
    manageTrade(tradeData!.id, {'trade_status': tradeStatus, 'description' : _descriptionController.text})
        .then((response) async {
      CustomDialog.dismissProgressDialog();
      if (response.status == 'success') {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ShowCompleteDialog(
              messageTitle: tradeStatus == 'rejected' ? '반려 완료' : '승인 완료',
              messageText: '처리되었습니다.',
              buttonText: '확인',
              onConfirmed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            );
          },
        );
      } else {
        CustomDialog.showServerValidatorErrorMsg(response);
      }
    });
  }
}
