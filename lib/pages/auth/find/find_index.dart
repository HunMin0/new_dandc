import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FindIndex extends StatefulWidget {
  const FindIndex({super.key});

  @override
  State<FindIndex> createState() => _FindIndexState();
}

class _FindIndexState extends State<FindIndex> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultNextLayout(
      titleName: "비밀번호 재설정",
      isProcessable: true,
      bottomBar: true,
      isCancel: false,
      prevOnPressed: () {},
      nextOnPressed: () {
        _submit();
      },
      nextTitle: '재설정 메일 보내기',
      prevTitle: '',
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "비밀번호 재설정",
                style:
                    SettingStyle.TITLE_STYLE.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "가입할 때 등록하신 이메일 주소로 생성된 신규 비밀번호를 보내드립니다.\n로그인 후 비밀번호를 꼭 재설정해주세요.",
                style: SettingStyle.SUB_GREY_TEXT,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _emailController,
                decoration: SettingStyle.INPUT_STYLE.copyWith(
                  hintText: '이메일을 입력해주세요.',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    CustomDialog.showProgressDialog(context);
    await sendPasswordMail({
      'email': _emailController.text,
    }).then((value) {
      CustomDialog.dismissProgressDialog();
      if (value.status == 'success') {
        Fluttertoast.showToast(msg: '메일이 발송되었습니다. 변경된 비밀번호로 로그인해주세요.');
        Navigator.pop(context);
      } else {
        CustomDialog.showServerValidatorErrorMsg(value);
      }
    });
  }
}
