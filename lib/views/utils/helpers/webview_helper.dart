import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewHelper extends StatefulWidget {
  final String url;
   const WebViewHelper({super.key, required this.url});

  @override
  State<WebViewHelper> createState() => _WebViewHelperState();
}

class _WebViewHelperState extends State<WebViewHelper> {

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {

          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }
  var controller = WebViewController();

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
