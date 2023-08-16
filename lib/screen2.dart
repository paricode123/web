import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';



class WebViewWidget extends StatefulWidget {
  final String initialUrl;
  final ValueSetter<WebViewController> onWebViewCreated;

  WebViewWidget({required this.initialUrl, required this.onWebViewCreated});

  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebView(
          initialUrl: widget.initialUrl,
          onWebViewCreated: (controller) {
            _webViewController = controller;
            widget.onWebViewCreated(controller);
          },
          onPageFinished: (url) {
            _webViewController.evaluateJavascript(
              "localStorage.setItem('cached_website_url', '$url');",
            );
            _saveCachedWebsiteUrl(url);
          },
        ),
      ),
    );
  }

  void _saveCachedWebsiteUrl(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cached_website_url', url);
  }
}
