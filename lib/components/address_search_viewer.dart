import 'dart:io';

import 'package:Deal_Connect/api/server_config.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:flutter/material.dart';
import "package:webview_flutter/webview_flutter.dart";

class AddressSearchViewer extends StatefulWidget {
  @override
  AddressSearchViewerState createState() => AddressSearchViewerState();
}

class AddressSearchViewerState extends State<AddressSearchViewer> {
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'messageHandler',
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
          Navigator.pop(context, message.message);
        });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLogoLayout(
      titleName: '우편번호 검색',
      isNotInnerPadding: 'true',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: Text("주소를 검색해주세요.", style: SettingStyle.SUB_TITLE_STYLE,),
          ),
          Expanded(
            child: WebView(
              initialUrl: ServerConfig.SERVER_URL + '/address/search/viewer',
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: <JavascriptChannel>{
                _toasterJavascriptChannel(context),
              },
            ),
          ),
        ],
      ),
    );
  }
}