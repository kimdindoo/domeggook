import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Product1688Screen extends StatefulWidget {
  const Product1688Screen({super.key});

  @override
  State<Product1688Screen> createState() => _Product1688ScreenState();
}

class _Product1688ScreenState extends State<Product1688Screen> {
  WebViewController? _webViewController;

  @override
  void initState() {
    _webViewController = WebViewController()
      ..loadRequest(Uri.parse('https://1688.domeggook.com/'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WebViewWidget(controller: _webViewController!));
  }
}
