import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/api/setting.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/model/app_config.dart';
import 'package:Deal_Connect/pages/more/license_page.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MoreIndex extends StatefulWidget {
  const MoreIndex({super.key});

  @override
  State<MoreIndex> createState() => _MoreIndexState();
}

class _MoreIndexState extends State<MoreIndex> {

  AppConfig? appConfig;
  String? version;

  @override
  void initState() {
    _initAppConfig();
    super.initState();
  }


  void _initAppConfig() {
    getAppConfig().then((response) {
      if (response.status == 'success') {
        AppConfig resultData = AppConfig.fromJSON(response.data);

        setState(() {
          appConfig = resultData;
        });
      }
    });

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;

      print('appName: $appName');
      print('packageName: $packageName');
      print('version: $version');
      print('buildNumber: $buildNumber');

      setState(() {
        this.version = version;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLogoLayout(
        titleName: '메뉴',
        isNotInnerPadding: 'true',
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text('공지사항', style: SettingStyle.TITLE_STYLE),
                      Spacer(),
                      Icon(CupertinoIcons.chevron_right, color: HexColor("#cccccc"),)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/more/qna');
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text('고객센터', style: SettingStyle.TITLE_STYLE),
                      Spacer(),
                      Icon(CupertinoIcons.chevron_right, color: HexColor("#cccccc"),)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {

                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text('앱 버전', style: SettingStyle.TITLE_STYLE),
                      Spacer(),
                      Text(version ?? '')
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => LicensePageIndex()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text('오픈 소스 라이선스', style: SettingStyle.TITLE_STYLE),
                      Spacer(),
                      Icon(CupertinoIcons.chevron_right, color: HexColor("#cccccc"),)
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                color: SettingStyle.GREY_COLOR,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/webviewer', arguments: { 'url' : 'https://elastic-wolverine-c46.notion.site/206e03ed63634093a147baa93be78887' });
                      },
                      child: Text('이용약관', style: SettingStyle.NORMAL_TEXT_STYLE.copyWith(color: HexColor("#AAAAAA"))),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/webviewer', arguments: { 'url' : 'https://elastic-wolverine-c46.notion.site/39205eef13dc49b0a3dd0d8f9bf4b35e' });
                      },
                      child: Text('개인정보처리방침', style: SettingStyle.NORMAL_TEXT_STYLE.copyWith(color: HexColor("#AAAAAA"))),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/more/agreemnt/push');
                      },
                      child: Text('서비스 알림 수신 동의', style: SettingStyle.NORMAL_TEXT_STYLE.copyWith(color: HexColor("#AAAAAA"))),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/more/agreemnt/selectable');
                      },
                      child: Text('선택 약관 동의', style: SettingStyle.NORMAL_TEXT_STYLE.copyWith(color: HexColor("#AAAAAA"))),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        print('로그아웃');
                        CustomDialog.showDoubleBtnDialog(
                          context: context,
                          msg: "정말 로그아웃\n하시겠습니까?",
                          leftBtnText: "취소",
                          rightBtnText: "확인",
                          onLeftBtnClick: () {
                          },
                          onRightBtnClick: () {
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
                      child: Text('로그아웃', style: SettingStyle.NORMAL_TEXT_STYLE.copyWith(color: HexColor("#AAAAAA"))),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/auth/withdraw');
                      },
                      child: Text('회원탈퇴', style: SettingStyle.NORMAL_TEXT_STYLE.copyWith(color: HexColor("#AAAAAA"))),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
