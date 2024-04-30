import 'package:Deal_Connect/Utils/custom_dialog.dart';
import 'package:Deal_Connect/api/trade.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/common_item/color_chip.dart';
import 'package:Deal_Connect/components/common_item/expended_elevated_button.dart';
import 'package:Deal_Connect/components/common_item/stack_thumbnail.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
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

class HistoryDetailInfo extends StatefulWidget {
  const HistoryDetailInfo({super.key});

  @override
  State<HistoryDetailInfo> createState() => _HistoryDetailInfoState();
}

class _HistoryDetailInfoState extends State<HistoryDetailInfo> {
  bool _isLoading = true;
  int? tradeId;
  Trade? tradeData;
  User? myUser;

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
            tradeId = args['tradeId'];
          });
        }
        if (tradeId != null) {
          await getTrade(tradeId!).then((response) {
            if (response.status == 'success') {
              Trade resultData = Trade.fromJSON(response.data);
              setState(() {
                tradeData = resultData;
              });
            } else {
              Fluttertoast.showToast(
                  msg: '파트너 정보를 받아오는 도중 오류가 발생했습니다.\n오류코드: 463');
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
    if (_isLoading || tradeData == null) {
      return Loading();
    }

    ImageProvider? receiptThumbnailImage =
        AssetImage('assets/images/no-image.png');

    ImageProvider? ownerProfileThumbnailImage =
        AssetImage('assets/images/no-image.png');
    ImageProvider? businessThumbnailImage =
        AssetImage('assets/images/no-image.png');

    String buttonStatus = 'approved';
    //내가 응답해야 하고
    if (tradeData!.response_user_id == myUser!.id) {
      //상태가 대기이면
      if (tradeData!.trade_status == 'pending') {
        //내 승인대기로 >> 승인, 반려 버튼 노출
        buttonStatus = 'approve_or_reject';
      }
    }

    //내가 보낸 요청의 경우
    if (tradeData!.request_user_id == myUser!.id) {
      if (tradeData!.trade_status == 'pending') {
        //대기중, 취소 버튼 노출
        buttonStatus = 'pending_or_cancel';
      }
    }

    if (tradeData != null) {
      if (tradeData!.has_receipt_image != null) {
        final receiptImage = tradeData!.has_receipt_image!;
        receiptThumbnailImage = CachedNetworkImageProvider(
          Utils.getImageFilePath(receiptImage),
        );
      }

      if (tradeData!.has_business_owner != null &&
          tradeData!.has_business_owner!.profile != null &&
          tradeData!.has_business_owner!.profile!.has_profile_image !=
              null) {
        final ownerProfileImage =
            tradeData!.has_business_owner!.profile!.has_profile_image!;
        ownerProfileThumbnailImage = CachedNetworkImageProvider(
          Utils.getImageFilePath(ownerProfileImage),
        );
      }

      if (tradeData!.has_business != null &&
          tradeData!.has_business!.has_business_image != null) {
        final businessImage = tradeData!.has_business!.has_business_image!;
        businessThumbnailImage = CachedNetworkImageProvider(
          Utils.getImageFilePath(businessImage),
        );
      }
    }

    ImageProvider? userProfileThumbnailImage =
        AssetImage('assets/images/no-image.png');
    ImageProvider? userBusinessThumbnailImage =
        AssetImage('assets/images/no-image.png');

    if (tradeData != null) {
      if (tradeData!.has_buy_user != null &&
          tradeData!.has_buy_user!.profile != null &&
          tradeData!.has_buy_user!.profile!.has_profile_image !=
              null) {
        final userProfileImage =
            tradeData!.has_buy_user!.profile!.has_profile_image!;
        userProfileThumbnailImage = CachedNetworkImageProvider(
          Utils.getImageFilePath(userProfileImage),
        );
      }

      if (tradeData!.has_buy_user != null &&
          tradeData!.has_buy_user!.main_business != null &&
          tradeData!.has_buy_user!.main_business!.has_business_image != null) {
        final userBusinessImage =
            tradeData!.has_buy_user!.main_business!.has_business_image!;
        userBusinessThumbnailImage = CachedNetworkImageProvider(
          Utils.getImageFilePath(userBusinessImage),
        );
      }
    }

    return DefaultLogoLayout(
      titleName: '거래내역 상세',
      isNotInnerPadding: 'true',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      SizedBox(
                        width: 100,
                        child: Column(
                          children: [
                            StackThumbNail(
                                profileThumbnailImage:
                                    ownerProfileThumbnailImage,
                                businessThumbnailImage: businessThumbnailImage),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              tradeData != null &&
                                      tradeData!.has_business != null
                                  ? tradeData!.has_business!.name
                                  : '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              tradeData != null &&
                                      tradeData!.has_business_owner != null
                                  ? tradeData!.has_business_owner!.name
                                  : '',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Icon(
                            CupertinoIcons.right_chevron,
                            size: 50,
                            color: HexColor("#aaaaaa"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(tradeData!.trade_type == 'sell' ? '판매' : '구매')
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 100,
                        child: Column(
                          children: [
                            StackThumbNail(
                                profileThumbnailImage:
                                    userProfileThumbnailImage,
                                businessThumbnailImage:
                                    userBusinessThumbnailImage),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              tradeData != null &&
                                      tradeData!.has_buy_user != null
                                  ? tradeData!.has_buy_user!.name
                                  : '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              tradeData != null &&
                                      tradeData!.has_buy_user != null &&
                                      tradeData!.has_buy_user!.main_business !=
                                          null
                                  ? tradeData!.has_buy_user!.main_business!.name
                                  : '',
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
            if (buttonStatus == 'approve_or_reject')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    ExpendedElevatedButton(
                      btnName: '승인',
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/trade/history/info/confirm', arguments: {
                          'tradeData': tradeData!,
                          'division': 'approved'
                        }).then((value) {
                          _initData();
                        });
                      },
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    ExpendedElevatedButton(
                      btnName: '반려',
                      textColor: HexColor("#ff4433"),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/trade/history/info/confirm', arguments: {
                          'tradeData': tradeData!,
                          'division': 'rejected'
                        }).then((value) {
                          _initData();
                        });
                      },
                    ),
                  ],
                ),
              ),
            if (buttonStatus == 'pending_or_cancel')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ExpendedElevatedButton(
                          btnName: '대기중',
                          onPressed: () {},
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        ExpendedElevatedButton(
                          btnName: '삭제',
                          textColor: HexColor("#ff4433"),
                          onPressed: () {
                            _submitManage('delete');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '[승인대기] 상태에서만 삭제가 가능합니다.',
                      style: SettingStyle.SUB_GREY_TEXT,
                    )
                  ],
                ),
              ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "거래 정보",
                        style: SettingStyle.SUB_TITLE_STYLE,
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReceiptView(
                                      receiptImage: receiptThumbnailImage!)));
                        },
                        child: Text(
                          "영수증 확인",
                          style: TextStyle(
                              color: HexColor("#75A8E4"),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
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
                            const Text("상태"),
                            const Spacer(),
                            if (tradeData!.trade_status == 'rejected')
                              ColorChip(
                                color: HexColor("#aa5544"),
                                textColor: HexColor("#ffffff"),
                                chipText: '반려',
                              ),
                            if (tradeData!.trade_status == 'pending')
                              ColorChip(
                                color: HexColor("#44aa44"),
                                textColor: HexColor("#ffffff"),
                                chipText: '승인대기',
                              ),
                            if (tradeData!.trade_status == 'approved')
                              ColorChip(
                                color: HexColor("#4455aa"),
                                textColor: HexColor("#ffffff"),
                                chipText: '승인',
                              ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
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
                            Text(Utils.parsePrice(tradeData!.price))
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "[${tradeData!.has_business!.name}]님 한마디",
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
                          child:
                              Text(tradeData?.business_user_description ?? ''),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  if (tradeData!.partner_return_reason != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "반려사유",
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
                          child:
                          Text(tradeData?.partner_return_reason ?? ''),
                        )
                      ],
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submitManage(String mode) {
    if (mode == 'delete') {
      CustomDialog.showDoubleBtnDialog(
          context: context,
          msg: '정말 삭제하시겠습니까?',
          rightBtnText: '삭제',
          onLeftBtnClick: () {},
          onRightBtnClick: () {
            _deleteSubmit();
          });
    }
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
          onRightBtnClick: () {});
    }
  }

  void _deleteSubmit() {
    CustomDialog.showProgressDialog(context);

    deleteTrade(tradeData!.id).then((response) async {
      CustomDialog.dismissProgressDialog();

      if (response.status == 'success') {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ShowCompleteDialog(
              messageTitle: '삭제 완료',
              messageText: '삭제가 완료 되었습니다.',
              buttonText: '확인',
              onConfirmed: () {
                Navigator.of(context).pop();
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

  void _manageSubmit(String tradeStatus) {
    CustomDialog.showProgressDialog(context);
    manageTrade(tradeData!.id, {'trade_status': tradeStatus})
        .then((response) async {
      CustomDialog.dismissProgressDialog();
      if (response.status == 'success') {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ShowCompleteDialog(
              messageTitle: '승인 완료',
              messageText: '승인이 완료 되었습니다.',
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
