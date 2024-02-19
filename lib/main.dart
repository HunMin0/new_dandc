import 'package:Deal_Connect/components/const/setting_themes.dart';
import 'package:Deal_Connect/pages/auth/join/join_index.dart';
import 'package:Deal_Connect/pages/auth/login/login_index.dart';
import 'package:Deal_Connect/pages/auth/login/user_id_login.dart';
import 'package:Deal_Connect/pages/auth/terms/terms_index.dart';
import 'package:Deal_Connect/pages/default_page.dart';
import 'package:Deal_Connect/pages/group/group_board/group_board_create.dart';
import 'package:Deal_Connect/pages/group/group_board/group_board_info.dart';
import 'package:Deal_Connect/pages/group/group_index.dart';
import 'package:Deal_Connect/pages/group/group_manage/group_manage_index.dart';
import 'package:Deal_Connect/pages/group/group_manage/group_manage_info.dart';
import 'package:Deal_Connect/pages/group/group_manage/group_manage_parnter.dart';
import 'package:Deal_Connect/pages/group/group_partner/group_partner_index.dart';
import 'package:Deal_Connect/pages/group/group_register/group_register_index.dart';
import 'package:Deal_Connect/pages/group/group_search/group_search_index.dart';
import 'package:Deal_Connect/pages/group/group_trade/group_trade_index.dart';
import 'package:Deal_Connect/pages/group/group_view.dart';
import 'package:Deal_Connect/pages/intro/intro_index.dart';
import 'package:Deal_Connect/pages/profile/company_create/company_create_photo.dart';
import 'package:Deal_Connect/pages/profile/company_create/company_create_index.dart';
import 'package:Deal_Connect/pages/profile/company_create/company_create_step_one.dart';
import 'package:Deal_Connect/pages/profile/company_create/company_create_step_three.dart';
import 'package:Deal_Connect/pages/profile/company_create/company_create_step_two.dart';
import 'package:Deal_Connect/pages/profile/other_profile.dart';
import 'package:Deal_Connect/pages/profile/profile_edit/profile_edit_index.dart';
import 'package:Deal_Connect/pages/profile/profile_group/profile_group_index.dart';
import 'package:Deal_Connect/pages/profile/profile_index.dart';
import 'package:Deal_Connect/pages/profile/profile_partner/profile_partner_index.dart';
import 'package:Deal_Connect/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'components/address_search_viewer.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([ // 선호하는 화면 방향 설정
    DeviceOrientation.portraitUp, // 세로 방향 고정
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Deal&Connect', // 디바이스의 작업줄에 표시역할
        theme: SettingThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ko', 'KR'),
        ],
        initialRoute: '/',
        routes: {
          '/': (context) => RootPage(),
          '/home': (context) => DefaultPage(),
          '/intro': (context) => IntroIndex(),
          '/login': (context) => LoginIndex(),
          '/login/userId': (context) => UserIdLogin(),
          '/register': (context) => JoinIndex(),
          '/register/terms': (context) => TermsIndex(),
          '/profile/edit': (context) => ProfileEditIndex(),
          '/profile/company/create': (context) => CompanyCreateIndex(),
          '/profile/company/create/photo': (context) => CompanyCreatePhoto(),
          '/profile/company/create/step1': (context) => CompanyCreateStepOne(),
          '/profile/company/create/step2': (context) => CompanyCreateStepTwo(),
          '/profile/company/create/step3': (context) => CompanyCreateStepThree(),
          '/profile/groups': (context) => ProfileGroupIndex(),
          '/profile/partners': (context) => ProfilePartnerIndex(),
          '/profile': (context) => OtherProfileIndex(),
          '/group': (context) => GroupIndex(),
          '/group/partner': (context) => GroupPartnerIndex(),
          '/group/trade': (context) => GroupTradeIndex(),
          '/group/search': (context) => GroupSearchIndex(),
          '/group/info': (context) => GroupView(),
          '/group/create': (context) => GroupRegisterIndex(),
          '/group/manage': (context) => GroupManageIndex(),
          '/group/manage/info': (context) => GroupManageInfo(),
          '/group/manage/partner': (context) => GroupManagePartner(),
          '/group/board/create': (context) => GroupBoardCreate(),
          '/group/board/edit': (context) => GroupBoardCreate(),
          '/group/board/info': (context) => GroupBoardInfo(),
          '/address/search': (context) => AddressSearchViewer(),
        }
    );
  }

}