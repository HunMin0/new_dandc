import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:flutter/material.dart';

class WithdrawIndex extends StatefulWidget {
  const WithdrawIndex({super.key});

  @override
  State<WithdrawIndex> createState() => _WithdrawIndexState();
}

class _WithdrawIndexState extends State<WithdrawIndex> {
  bool isChecked = false;
  User? ProfileUserData;
  bool _isLoading = true;
  User? myUser;

  @override
  void initState() {
    super.initState();
    _initMyUserData();
  }

  _initMyUserData() async {
    await getMyUser().then((response) {
      if (response.status == 'success') {
        User user = User.fromJSON(response.data);
        setState(() {
          ProfileUserData = user;
          if (ProfileUserData!.is_active == false) {
            isChecked = true;
          }
        });
        SharedPrefUtils.setUser(user).then((value) {
          SharedPrefUtils.getUser().then((user) {
            if (user != null) {
              setState(() {
                myUser = user;
              });
            } else {
              CustomDialog.showCustomDialog(
                  context: context,
                  title: '사용자 정보 요청 실패',
                  msg: '사용자 정보를 불러올 수 없습니다.\n다시 로그인 해주세요.')
                  .then((value) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/intro', (r) => false);
              });
            }
          });
        });
      }

      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ProfileUserData == null) {
      return const Loading();
    }

    return DefaultNextLayout(
      titleName: ProfileUserData!.is_active == false ? '회원탈퇴철회' : '회원탈퇴',
      isCancel: false,
      prevOnPressed: () {},
      nextOnPressed: () {
        ProfileUserData!.is_active == false ? _deleteItem('cancel') : _deleteItem('delete');
      },
      nextTitle: ProfileUserData!.is_active == false ? '회원탈퇴철회' : '회원탈퇴',
      prevTitle: '',
      isProcessable: isChecked,
      bottomBar: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("탈퇴 전 확인하세요", style: SettingStyle.TITLE_STYLE,),
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
              color: SettingStyle.GREY_COLOR,
              borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            child: const Column(
              children: [
                Text("회원 탈퇴는 신청일로부터 30일이 지나면 완료 처리됩니다."),
                SizedBox(height: 10,),
                Text("탈퇴 신청 기간(30일) 내 계정에 로그인하여 탈퇴 철회가가능합니다."),
                SizedBox(height: 10,),
                Text("탈퇴 완료시, 계정 정보와 게시글, 거래 내역 등 모든데이터가 삭제되며 복구가 불가능합니다."),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              const Text('안내 사항을 모두 확인하였으며, 이에 동의합니다.')
            ],
          ),
        ],
      ),
    );
  }


  void _deleteItem(division) {
    CustomDialog.showDoubleBtnDialog(
        context: context,
        msg: division == 'cancel' ? '정말 철회하시겠습니까?' : '정말 탈퇴하시겠습니까?',
        rightBtnText: division == 'cancel' ? '철회하기' : '탈퇴하기',
        onLeftBtnClick: () {},
        onRightBtnClick: () {
          division == 'cancel' ? _deleteBackSubmit() : _deleteSubmit();
        });
  }

  void _deleteBackSubmit() {
    CustomDialog.showProgressDialog(context);

    userDestroyBack({}).then((response) async {
      CustomDialog.dismissProgressDialog();

      if (response.status == 'success') {
        _showCompleteBackDialog(context);
      } else {
        CustomDialog.showServerValidatorErrorMsg(response);
      }
    });
  }

  void _showCompleteBackDialog(BuildContext context) {
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

  void _deleteSubmit() {
    CustomDialog.showProgressDialog(context);

    userDestroy({}).then((response) async {
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
          messageTitle: '탈퇴 완료',
          messageText: '탈퇴가 완료 되었습니다.',
          buttonText: '확인',
          onConfirmed: () {
            logout({}).then((response) {
              if (response.status == 'success') {
                SharedPrefUtils.clearUser().then((result) {
                  Navigator.pushNamedAndRemoveUntil(context, '/intro', (r) => false);
                });
              } else {
                CustomDialog.showServerValidatorErrorMsg(response);
                SharedPrefUtils.clearUser().then((result) {
                  Navigator.pushNamedAndRemoveUntil(context, '/intro', (r) => false);
                });
              }
            });
          },
        );
      },
    );
  }
}
