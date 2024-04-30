import 'dart:convert';

import 'package:Deal_Connect/components/const/setting_themes.dart';
import 'package:Deal_Connect/pages/auth/find/find_index.dart';
import 'package:Deal_Connect/pages/auth/join/join_index.dart';
import 'package:Deal_Connect/pages/auth/join/sns_join.dart';
import 'package:Deal_Connect/pages/auth/login/login_index.dart';
import 'package:Deal_Connect/pages/auth/login/user_id_login.dart';
import 'package:Deal_Connect/pages/auth/terms/terms_index.dart';
import 'package:Deal_Connect/pages/auth/withdraw/withdraw_index.dart';
import 'package:Deal_Connect/pages/business/business_detail/business_detail_info.dart';
import 'package:Deal_Connect/pages/business/business_history/business_history_index.dart';
import 'package:Deal_Connect/pages/business/business_index.dart';
import 'package:Deal_Connect/pages/business/business_service/business_service_create.dart';
import 'package:Deal_Connect/pages/business/business_service/business_service_info.dart';
import 'package:Deal_Connect/pages/default_page.dart';
import 'package:Deal_Connect/pages/group/group_board/group_board_create.dart';
import 'package:Deal_Connect/pages/group/group_board/group_board_info.dart';
import 'package:Deal_Connect/pages/group/group_detail/group_detail_info.dart';
import 'package:Deal_Connect/pages/group/group_index.dart';
import 'package:Deal_Connect/pages/group/group_manage/group_manage_index.dart';
import 'package:Deal_Connect/pages/group/group_manage/group_manage_info.dart';
import 'package:Deal_Connect/pages/group/group_manage/group_manage_parnter.dart';
import 'package:Deal_Connect/pages/group/group_partner/group_partner_index.dart';
import 'package:Deal_Connect/pages/group/group_register/group_register_index.dart';
import 'package:Deal_Connect/pages/group/group_search/group_search_index.dart';
import 'package:Deal_Connect/pages/group/group_trade/group_trade_detail.dart';
import 'package:Deal_Connect/pages/group/group_trade/group_trade_index.dart';
import 'package:Deal_Connect/pages/history/history_detail/history_detail_confirm.dart';
import 'package:Deal_Connect/pages/history/history_detail/history_detail_index.dart';
import 'package:Deal_Connect/pages/history/history_detail/history_detail_info.dart';
import 'package:Deal_Connect/pages/history/history_list/history_list_index.dart';
import 'package:Deal_Connect/pages/history/history_ranking/history_ranking_index.dart';
import 'package:Deal_Connect/pages/intro/intro_index.dart';
import 'package:Deal_Connect/pages/more/more_agreement/more_agreement_push.dart';
import 'package:Deal_Connect/pages/more/more_agreement/more_agreement_selectable.dart';
import 'package:Deal_Connect/pages/more/more_index.dart';
import 'package:Deal_Connect/pages/more/more_qna/more_qna_create.dart';
import 'package:Deal_Connect/pages/more/more_qna/more_qna_index.dart';
import 'package:Deal_Connect/pages/more/more_qna/more_qna_info.dart';
import 'package:Deal_Connect/pages/more/web_viewer.dart';
import 'package:Deal_Connect/pages/profile/company_create/company_create_photo.dart';
import 'package:Deal_Connect/pages/profile/company_create/company_create_index.dart';
import 'package:Deal_Connect/pages/profile/company_create/company_create_step_one.dart';
import 'package:Deal_Connect/pages/profile/company_create/company_create_step_three.dart';
import 'package:Deal_Connect/pages/profile/company_create/company_create_step_two.dart';
import 'package:Deal_Connect/pages/profile/other_profile.dart';
import 'package:Deal_Connect/pages/profile/partner_attend/partner_attend_index.dart';
import 'package:Deal_Connect/pages/profile/profile_edit/profile_edit_index.dart';
import 'package:Deal_Connect/pages/profile/profile_group/profile_group_index.dart';
import 'package:Deal_Connect/pages/profile/profile_partner/profile_partner_index.dart';
import 'package:Deal_Connect/pages/root_page.dart';
import 'package:Deal_Connect/pages/trade/trade_buy/trade_buy_create.dart';
import 'package:Deal_Connect/pages/trade/trade_sell/trade_sell_create.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:uni_links/uni_links.dart';
import 'components/address_search_viewer.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print('title: ${message.notification?.title}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {

  KakaoSdk.init(
    nativeAppKey: '9912da7147abaf6f54e2c765b623a533',
    javaScriptAppKey: '543f99effd47d7ba3905fb417dce0e80',
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    description:
        'This channel is used for important notifications.', // description
  );
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);


  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );


  flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: IOSInitializationSettings(),
    ),
    onSelectNotification: (String? payload) async {
      print(payload);

      if (payload != null) {
        Map<String, dynamic> data = jsonDecode(payload);
        String? route = data['route'];
        Map<String, dynamic> arguments = data['argument'] ?? {};

        if (route != null) {
          // 네비게이터를 사용하여 경로 이동 및 arguments 전달
          navigatorKey.currentState?.pushNamed(route, arguments: arguments);
        } else {
          navigatorKey.currentState?.pushNamed('/home');
        }
      }
    },
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      String? route = message.data['route'];
      String argumentJson = message.data['argument'] ?? '{}';
      Map<String, dynamic> arguments = jsonDecode(argumentJson);

      String payload = jsonEncode({
        'route': route,
        'argument': arguments,
      });

      print('Message also contained a notification: ${message.notification}');
      flutterLocalNotificationsPlugin.show(
        message.hashCode,
        message.notification?.title,
        message.notification?.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: const IOSNotificationDetails(
              badgeNumber: 1,
              subtitle: 'the subtitle',
              sound: 'slow_spring_board.aiff',
            )),
        payload: payload, // 여기에 라우트 정보를 전달
      );
    }
  });

  //url 링크
  uriLinkStream.listen((Uri? uri) {
    print("uri: $uri");
    if (uri != null) {
      String route = uri.path; // Extract the route from the URI
      Map<String, dynamic> arguments = {};

      // Extract query parameters and parse them as needed
      uri.queryParameters.forEach((key, value) {
        // Check for specific keys that should be integers
        if (key == "userId" || key == "userBusinessId" || key == "groupId") {
          int? intValue = int.tryParse(value);
          if (intValue != null) {
            arguments[key] = intValue;
          } else {
            print("Warning: Failed to parse integer for key $key");
          }
        } else {
          arguments[key] = value;
        }
      });

      // Using navigatorKey to navigate to the specific route with parsed arguments
      print('route: $route');
      navigatorKey.currentState?.pushNamed(route, arguments: arguments);
    } else {
      // Fallback to home if no URI is received
      navigatorKey.currentState?.pushNamed('/home');
    }
  }, onError: (Object err) {
    print("err: $err");
  });


  SystemChrome.setPreferredOrientations([
    // 선호하는 화면 방향 설정
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
    return CupertinoApp(
        title: 'Deal&Connect',
        navigatorKey: navigatorKey,
        theme: SettingThemes.cupertinoTheme,
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
          '/sns_register': (context) => SnsJoin(),
          '/register/terms': (context) => TermsIndex(),
          '/find': (context) => FindIndex(),
          '/profile/edit': (context) => ProfileEditIndex(),
          '/profile/company/create': (context) => CompanyCreateIndex(),
          '/profile/company/create/photo': (context) => CompanyCreatePhoto(),
          '/profile/company/create/step1': (context) => CompanyCreateStepOne(),
          '/profile/company/create/step2': (context) => CompanyCreateStepTwo(),
          '/profile/company/create/step3': (context) =>
              CompanyCreateStepThree(),
          '/profile/groups': (context) => ProfileGroupIndex(),
          '/profile/partners': (context) => ProfilePartnerIndex(),
          '/profile/partner/attends': (context) => PartnerAttendIndex(),
          '/profile/partner/info': (context) => OtherProfileIndex(),
          '/profile': (context) => OtherProfileIndex(),
          '/group': (context) => GroupIndex(),
          '/group/partner': (context) => GroupPartnerIndex(),
          '/group/trade': (context) => GroupTradeIndex(),
          '/group/trade/detail': (context) => GroupTradeDetail(),
          '/group/search': (context) => GroupSearchIndex(),
          '/group/info': (context) => GroupDetailInfo(),
          '/group/create': (context) => GroupRegisterIndex(),
          '/group/edit': (context) => GroupRegisterIndex(),
          '/group/manage': (context) => GroupManageIndex(),
          '/group/manage/info': (context) => GroupManageInfo(),
          '/group/manage/partner': (context) => GroupManagePartner(),
          '/group/board/create': (context) => GroupBoardCreate(),
          '/group/board/edit': (context) => GroupBoardCreate(),
          '/group/board/info': (context) => GroupBoardInfo(),
          '/business': (context) => BusinessIndex(),
          '/business/info': (context) => BusinessDetailInfo(),
          '/business/edit': (context) => CompanyCreateIndex(),
          '/business/edit/photo': (context) => CompanyCreatePhoto(),
          '/business/service/edit': (context) => BusinessServiceCreate(),
          '/business/service/create': (context) => BusinessServiceCreate(),
          '/business/service/info': (context) => BusinessServiceInfo(),
          '/business/history': (context) => BusinessHistoryIndex(),
          '/trade/buy/create': (context) => TradeBuyCreate(),
          '/trade/sell/create': (context) => TradeSellCreate(),
          '/trade/history/approve': (context) => HistoryDetailIndex(),
          '/trade/history/info': (context) => HistoryDetailInfo(),
          '/trade/history/info/confirm': (context) => HistoryDetailConfirm(),
          '/trade/history/ranking': (context) => HistoryRankingIndex(),
          '/trade/history/list': (context) => HistoryListIndex(),
          '/address/search': (context) => AddressSearchViewer(),
          '/more': (context) => MoreIndex(),
          '/more/qna': (context) => MoreQnaIndex(),
          '/more/qna/create': (context) => MoreQnaCreate(),
          '/more/qna/edit': (context) => MoreQnaCreate(),
          '/more/qna/info': (context) => MoreQnaInfo(),
          '/more/agreemnt/push': (context) => MoreAgreementPush(),
          '/more/agreemnt/selectable': (context) => MoreAgreementSelectable(),
          '/auth/withdraw': (context) => WithdrawIndex(),
          '/webviewer': (context) => WebViewer(),
        });
  }
}
