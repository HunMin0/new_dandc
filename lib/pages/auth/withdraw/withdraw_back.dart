import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:flutter/material.dart';

class WithdrawBack extends StatefulWidget {
  const WithdrawBack({super.key});

  @override
  State<WithdrawBack> createState() => _WithdrawBackState();
}

class _WithdrawBackState extends State<WithdrawBack> {
  @override
  Widget build(BuildContext context) {
    return DefaultNextLayout(
      titleName: '회원탈퇴',
      isCancel: false,
      prevOnPressed: () {},
      nextOnPressed: () {
        _deleteItem();
      },
      nextTitle: '탈퇴하기',
      prevTitle: '',
      isProcessable: true,
      bottomBar: true,
      child: Column(
        children: [

        ],
      )
    );
  }



  void _deleteItem() {
    CustomDialog.showDoubleBtnDialog(
        context: context,
        msg: '정말 탈퇴를 철회하시겠습니까?',
        rightBtnText: '탈퇴철회하기',
        onLeftBtnClick: () {},
        onRightBtnClick: () {
          _deleteSubmit();
        });
  }

  void _deleteSubmit() {
    CustomDialog.showProgressDialog(context);

    userDestroyBack({}).then((response) async {
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
          messageTitle: '탈퇴 철회 완료',
          messageText: '탈퇴철회가 완료 되었습니다.',
          buttonText: '확인',
          onConfirmed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (r) => false);
          },
        );
      },
    );
  }
}
