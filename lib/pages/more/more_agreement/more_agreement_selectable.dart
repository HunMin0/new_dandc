import 'package:Deal_Connect/Utils/shared_pref_utils.dart';
import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MoreAgreementSelectable extends StatefulWidget {
  const MoreAgreementSelectable({super.key});

  @override
  State<MoreAgreementSelectable> createState() => _MoreAgreementSelectableState();
}

class _MoreAgreementSelectableState extends State<MoreAgreementSelectable> {
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
    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return const Loading();
    }

    return DefaultNextLayout(
      titleName: '마케팅 정보 수신 및 활용 동의',
      isNotInnerPadding: 'true',
      isCancel: false,
      prevOnPressed: () {},
      nextOnPressed: () {
        _submit();
      },
      nextTitle: ProfileUserData!.is_agree_marketing == true ? '동의 철회' : '동의하기',
      prevTitle: '취소',
      isProcessable: true,
      bottomBar: true,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("마케팅 활용 및 정보 수신 동의 철회 시, 이벤트 참여가 제한될 수 있으며 이용자 맞춤형 서비스 등 마케팅 정보 안내 서비스가 제한됩니다.", style: SettingStyle.NORMAL_TEXT_STYLE.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: 30,),
            Text(" 향후 마케팅 활용에 새롭게 동의하고자 하는 경우에는 홈화면 우측 상단 '더 보기' 버튼을 통해 들어온 화면 하단의 '선택 약관 동의'에서 동의 하실 수 있습니다.", style: SettingStyle.NORMAL_TEXT_STYLE.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/webviewer', arguments: { 'url' : 'https://elastic-wolverine-c46.notion.site/1f4c9c56d1ed45e6b19c2796d1872657' });
              },
              child: Text("마케팅 정보 활용 동의 자세히 보기", style: SettingStyle.NORMAL_TEXT_STYLE.copyWith(color: SettingStyle.MAIN_COLOR),),
            )
          ],
        ),
      ),
    );
  }

  void _submit() {
    CustomDialog.showProgressDialog(context);
    bool newAgreementStatus = !(myUser!.is_agree_marketing);
    updateAgreement({
      'is_agree_marketing': newAgreementStatus,
    }).then((response) async {
      CustomDialog.dismissProgressDialog();
      if (response.status == 'success') {
        _initMyUserData();
        if (newAgreementStatus) {
          print('구독');
          FirebaseMessaging.instance.subscribeToTopic('marketing').then((_) {
            print('사용자가 marketing 토픽을 구독하였습니다.');
          });
        } else {
          FirebaseMessaging.instance.unsubscribeFromTopic('marketing').then((_) {
            print('구독안해');
            print('사용자가 marketing 토픽 구독을 취소하였습니다.');
          });
        }
      } else {
        CustomDialog.showServerValidatorErrorMsg(response);
      }
    });
  }
}
