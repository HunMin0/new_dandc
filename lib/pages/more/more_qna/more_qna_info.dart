import 'package:Deal_Connect/api/qna.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/model/qna.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MoreQnaInfo extends StatefulWidget {
  const MoreQnaInfo({super.key});

  @override
  State<MoreQnaInfo> createState() => _MoreQnaInfoState();
}

class _MoreQnaInfoState extends State<MoreQnaInfo> {
  Qna? qna;
  int? qnaId;
  bool _isLoading = true;
  var args;

  @override
  void initState() {
    super.initState();
    _initData();
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
            qnaId = args['qnaId'];
          });
        }
        if (qnaId != null) {
          await getQna(qnaId!).then((response) {
            if (response.status == 'success') {
              Qna resultData = Qna.fromJSON(response.data);
              setState(() {
                qna = resultData;
              });
            } else {
              Fluttertoast.showToast(
                  msg: '서비스 정보를 받아오는 도중 오류가 발생했습니다.\n오류코드: 463');
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
    if (_isLoading || qna == null) {
      return Loading();
    }
    return DefaultNextLayout(
        titleName: '고객센터',
        isCancel: qna!.has_answer == false ? true : false,
        prevOnPressed: () {
          _deleteItem();
        },
        nextOnPressed: () {
          Navigator.pushNamed(context, '/more/qna/edit',
              arguments: {'qnaId': qnaId}).then((value) {
            _initData();
          });
        },
        nextTitle: '수정하기',
        prevTitle: '삭제',
        isProcessable: true,
        bottomBar: qna!.has_answer == false ? true : false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  qna!.title,
                  style: SettingStyle.TITLE_STYLE,
                ),
                Text(qna!.created_at!.substring(0, 16), style: SettingStyle.SUB_GREY_TEXT,)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: SettingStyle.GREY_COLOR),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text(qna!.question,softWrap: true,)),
                  SizedBox(width: 10,),
                  Icon(CupertinoIcons.quote_bubble_fill,
                      color: SettingStyle.MAIN_COLOR),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            if (qna!.has_answer)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: SettingStyle.GREY_COLOR),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(CupertinoIcons.quote_bubble_fill,
                        color: SettingStyle.ALERT_COLOR),
                    SizedBox(width: 10,),
                    Expanded(child: Text(qna!.answer!)),
                  ],
                ),
              )
          ],
        ));
  }


  void _deleteItem() {
    CustomDialog.showDoubleBtnDialog(
        context: context,
        msg: '정말 삭제하시겠습니까?',
        rightBtnText: '삭제',
        onLeftBtnClick: () {},
        onRightBtnClick: () {
          _deleteSubmit();
        });
  }

  void _deleteSubmit() {
    CustomDialog.showProgressDialog(context);

    deleteQna(qnaId!).then((response) async {
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
          messageTitle: '삭제 완료',
          messageText: '삭제가 완료 되었습니다.',
          buttonText: '확인',
          onConfirmed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
