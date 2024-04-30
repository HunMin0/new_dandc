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

class MoreAgreementPush extends StatefulWidget {
  const MoreAgreementPush({super.key});

  @override
  State<MoreAgreementPush> createState() => _MoreAgreementPushState();
}

class _MoreAgreementPushState extends State<MoreAgreementPush> {
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
      titleName: '서비스 알림 수신 동의',
      isNotInnerPadding: 'true',
      isCancel: false,
      prevOnPressed: () {},
      nextOnPressed: () {
        _submit();
      },
      nextTitle: ProfileUserData!.is_agree_app_notification == true ? '동의 철회' : '동의하기',
      prevTitle: '취소',
      isProcessable: true,
      bottomBar: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text("동의하시면 각종 기능 알림을 수신하여\n다른 파트너들과 쉽게 교류할 수 있어요!", style: SettingStyle.TITLE_STYLE.copyWith(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Container(
              color: SettingStyle.GREY_COLOR,
              padding: EdgeInsets.all(13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/sample/main_sample01.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          SizedBox(
                            width: 18.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("[그룹명] 가입신청이 승인되었습니다.",
                                    style: SettingStyle.NORMAL_TEXT_STYLE),
                                Text("2024-01-01", style: SettingStyle.SUB_GREY_TEXT,)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/sample/main_sample_avater2.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          SizedBox(
                            width: 18.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("[홍길동] 님이 거래내역 승인을 요청했습니다.",
                                    style: SettingStyle.NORMAL_TEXT_STYLE),
                                Text("2024-01-01", style: SettingStyle.SUB_GREY_TEXT,)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/sample/main_sample_avater3.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          SizedBox(
                            width: 18.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("[홍길동] 님이 파트너 신청을 했습니다.",
                                    style: SettingStyle.NORMAL_TEXT_STYLE),
                                Text("2024-01-01", style: SettingStyle.SUB_GREY_TEXT,)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/no-image.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          SizedBox(
                            width: 18.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("프로필 설정을 완료하고, 파트너를 늘려보세요!",
                                    style: SettingStyle.NORMAL_TEXT_STYLE),
                                Text("2024-01-01", style: SettingStyle.SUB_GREY_TEXT,)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/webviewer', arguments: { 'url' : 'https://elastic-wolverine-c46.notion.site/dad9fd935eae4ac3ab3d2f5946529548' });
                    },
                    child: Text("서비스 알림 수신 동의 자세히 보기", style: SettingStyle.NORMAL_TEXT_STYLE.copyWith(color: SettingStyle.MAIN_COLOR),),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _submit() {
    CustomDialog.showProgressDialog(context);
    bool newAgreementStatus = !(myUser!.is_agree_app_notification);
    updateAgreement({
      'is_agree_app_notification': !(myUser!.is_agree_app_notification),
    }).then((response) async {
      CustomDialog.dismissProgressDialog();
      if (response.status == 'success') {
        _initMyUserData();
        if (newAgreementStatus) {
          print('구독');
          FirebaseMessaging.instance.subscribeToTopic('all').then((_) {
            print('사용자가 all 토픽을 구독하였습니다.');
          });
        } else {
          FirebaseMessaging.instance.unsubscribeFromTopic('all').then((_) {
            print('구독안해');
            print('사용자가 all 토픽 구독을 취소하였습니다.');
          });
        }
      } else {
        CustomDialog.showServerValidatorErrorMsg(response);
      }
    });
  }
}
