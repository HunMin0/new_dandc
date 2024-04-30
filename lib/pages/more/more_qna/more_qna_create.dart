import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/api/qna.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/model/qna.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MoreQnaCreate extends StatefulWidget {
  const MoreQnaCreate({super.key});

  @override
  State<MoreQnaCreate> createState() => _MoreQnaCreateState();
}

class _MoreQnaCreateState extends State<MoreQnaCreate> {
  User? myUserData;
  Qna? qna;
  int? qnaId;
  bool _isLoading = true;
  var args;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initData();
    _initMyUserData();
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
                if (qna != null) {
                  _titleController.text = qna!.title;
                  _questionController.text = qna!.question;
                  _emailController.text = qna!.email;
                }
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

  _initMyUserData() async {
    await getMyUser().then((response) {
      if (response.status == 'success') {
        User user = User.fromJSON(response.data);
        setState(() {
          myUserData = user;
          if (myUserData != null) {
            _emailController.text = myUserData!.email ?? '';
          }
        });
      }

      setState(() {
        _isLoading = false;
      });
    });
  }







  @override
  Widget build(BuildContext context) {
    return DefaultNextLayout(
        titleName: '고객센터',
        isCancel: true,
        prevOnPressed: () {
          Navigator.pop(context);
        },
        nextOnPressed: () {
          qnaId != null ? _modify() : _submit();
        },
        nextTitle: qnaId != null ? '수정하기' : '등록하기',
        prevTitle: '취소',
        isProcessable: true,
        bottomBar: true,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '문의 제목',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                    TextFormField(
                        controller: _titleController,
                        decoration: SettingStyle.INPUT_STYLE.copyWith(
                          hintText: '문의 제목을 입력해주세요.',
                        )),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '이메일',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                    TextFormField(
                        controller: _emailController,
                        decoration: SettingStyle.INPUT_STYLE.copyWith(
                          hintText: '답변 받으실 이메일을 입력해주세요.',
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '문의 내용',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                    TextFormField(
                        controller: _questionController,
                        maxLines: 4,
                        decoration: SettingStyle.INPUT_STYLE.copyWith(
                          hintText: '문의 내용을 입력해주세요.',
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }

  _submit() async {
    CustomDialog.showProgressDialog(context);

    storeQna({
      'title': _titleController.text,
      'question': _questionController.text,
      'email': _emailController.text,
    }).then((response) async {
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
          messageTitle: '문의 저장 완료',
          messageText: '문의 저장이 완료 되었습니다.',
          buttonText: '확인',
          onConfirmed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  _modify() {
    CustomDialog.showProgressDialog(context);

    updateQna(qnaId!, {
      'title': _titleController.text,
      'question': _questionController.text,
      'email': _emailController.text,
    }).then((response) async {
      CustomDialog.dismissProgressDialog();

      if (response.status == 'success') {
        _showCompleteDialog(context);
      } else {
        CustomDialog.showServerValidatorErrorMsg(response);
      }
    });
  }
}
