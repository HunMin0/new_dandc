import 'package:Deal_Connect/api/partner.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_card.dart';
import 'package:Deal_Connect/components/list_group_user_card.dart';
import 'package:Deal_Connect/components/list_partner_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/db/vertical_data.dart';
import 'package:Deal_Connect/model/partner.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PartnerAttendIndex extends StatefulWidget {
  const PartnerAttendIndex({super.key});

  @override
  State<PartnerAttendIndex> createState() => _PartnerAttendIndexState();
}

class _PartnerAttendIndexState extends State<PartnerAttendIndex> {
  List<Partner>? partnerList;
  bool _isLoading = true;
  User? myUser; // 저장 된 내 정보

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    getPartners(queryMap: {'is_approved': 'false'}).then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;
        List<Partner>? partnerListData =
            List<Partner>.from(iterable.map((e) => Partner.fromJSON(e)));
        setState(() {
          if (partnerListData != null) {
            partnerList = partnerListData;
          }
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return Loading();
    }

    return DefaultLogoLayout(
        titleName: '파트너 신청 내역',
        isNotInnerPadding: 'true',
        child: Column(
          children: [
            partnerList != null && partnerList!.isNotEmpty
                ? Expanded(
                    child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFf5f6f8),
                    ),
                    child: ListView.builder(
                      itemCount: partnerList!.length,
                      itemBuilder: (context, index) {
                        Partner item = partnerList![index];

                        return GestureDetector(
                          onTap: () {
                            print('클릭했다~');
                          },
                          child: ListPartnerCard(
                              item: item.has_user,
                              onApprovePressed: () {
                                _approve(item.user_id);
                              },
                              onDeletePressed: () {
                                _delete(item.user_id);
                              },
                              hasButton: true),
                        );
                      },
                    ),
                  ))
                : NoItems(),
          ],
        ));
  }

  void _approve(int id) {
    CustomDialog.showDoubleBtnDialog(
        context: context,
        msg: '정말 승인하시겠습니까?',
        rightBtnText: '승인',
        onLeftBtnClick: () {},
        onRightBtnClick: () {
          _approveSubmit(id, 'approve');
        });
  }

  void _delete(int id) {
    CustomDialog.showDoubleBtnDialog(
        context: context,
        msg: '정말 삭제하시겠습니까?',
        rightBtnText: '삭제',
        onLeftBtnClick: () {},
        onRightBtnClick: () {
          _approveSubmit(id, 'decline');
        });
  }

  void _approveSubmit(int id, String division) {
    CustomDialog.showProgressDialog(context);

    approvePartner({'user_id': id, 'division': division}).then((response) async {
      CustomDialog.dismissProgressDialog();

      if (response.status == 'success') {
        if (division == 'approve') {
          _showCompleteDialog(context, '승인완료', '승인되었습니다.');
        } else {
          _showCompleteDialog(context, '삭제완료', '삭제되었습니다.');
        }
      } else {
        CustomDialog.showServerValidatorErrorMsg(response);
      }
    });
  }

  void _showCompleteDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowCompleteDialog(
          messageTitle: title,
          messageText: text,
          buttonText: '확인',
          onConfirmed: () {
            Navigator.of(context).pop();
            _initData();
          },
        );
      },
    );
  }
}
