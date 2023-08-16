import 'package:flutter/material.dart';
import 'package:untitled28/screen2.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _webViewController;
  late String _cachedWebsiteUrl;

  @override
  void initState() {
    super.initState();
    _loadCachedWebsiteUrl();
  }

  void _loadCachedWebsiteUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _cachedWebsiteUrl = prefs.getString('cached_website_url') ?? '';
  }

  void _saveCachedWebsiteUrl(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cached_website_url', url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/dp.jpeg',height: 400,), // Replace with your image asset
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewWidget(
                      initialUrl: _cachedWebsiteUrl.isNotEmpty
                          ? _cachedWebsiteUrl
                          : 'https://www.matkaindian.net/',
                      onWebViewCreated: (controller) {
                        _webViewController = controller;
                      },
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow.shade700, // Change the button color
                padding: EdgeInsets.symmetric(vertical: 16,horizontal: 50), // Increase the button height
              ),
              child: Text(
                'Proceed',
                style: TextStyle(fontSize: 20), // Adjust the font size if needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}

