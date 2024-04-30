import 'package:flutter/material.dart';
import "package:webview_flutter/webview_flutter.dart";

class WebViewer extends StatefulWidget {
  @override
  WebViewerState createState() => WebViewerState();
}

class WebViewerState extends State<WebViewer> {
  late WebViewController controller;
  String? url;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setBackgroundColor(Colors.white)
      ..addJavaScriptChannel('messageHandler', onMessageReceived: (JavaScriptMessage message) {
        print(message.message);
        Navigator.pop(context, message.message);
      })
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    // Post frame callback to get the URL from arguments and load the WebView.
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      if (args != null && args.containsKey('url')) {
        final String? initialUrl = args['url'];
        if (initialUrl != null) {
          url = initialUrl;
          controller.loadRequest(Uri.parse(url!));
        } else {
          // Handle null URL appropriately
          print('URL is null');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
    controller.clearCache();
    super.dispose();
  }
}
