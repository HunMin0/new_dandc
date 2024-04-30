import 'dart:io';

import 'package:Deal_Connect/api/server_config.dart';
import 'package:flutter/material.dart';
import "package:webview_flutter/webview_flutter.dart";

class AddressSearchViewer extends StatefulWidget {
  @override
  AddressSearchViewerState createState() => AddressSearchViewerState();
}

class AddressSearchViewerState extends State<AddressSearchViewer> {
  late final WebViewController controller;


  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setBackgroundColor(Colors.white)
      ..addJavaScriptChannel('messageHandler', onMessageReceived: (JavaScriptMessage message) {
        print(message.message);
        Navigator.pop(context, message.message);
      })
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(ServerConfig.SERVER_URL + '/address/search/viewer',),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('우편번호 검색'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.0),
            child: Text("주소를 검색해주세요.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: WebViewWidget(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}
