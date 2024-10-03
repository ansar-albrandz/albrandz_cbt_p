import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewHelper extends StatefulWidget {
  final String url;
   const WebViewHelper({super.key, required this.url});

  @override
  State<WebViewHelper> createState() => _WebViewHelperState();
}

class _WebViewHelperState extends State<WebViewHelper> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {

          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }
  var controller = WebViewController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: controller),
        isLoading
            ? const LinearProgressIndicator() // Display a linear loader
            : const SizedBox()
      ],
    );
  }
}

