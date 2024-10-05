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
      ..loadRequest(Uri.parse(widget.url))
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

            controller.runJavaScript(
                """
                document.querySelector('.appie-page-title-area.appie-page-service-title-area').style.display='none';
                document.querySelector('.appie-header-area.appie-sticky').style.display='none';
                document.querySelector('.appie-footer-area').style.display='none';
                """
            );
          },
          onHttpError: (HttpResponseError error) {
            print(error.response?.statusCode);
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      );

  }
  var controller = WebViewController();

  @override
  Widget build(BuildContext context) {
    return  Stack(
        children: [
          WebViewWidget(controller: controller),
          isLoading
              ? const LinearProgressIndicator() // Display a linear loader
              : const SizedBox()
        ],
      );
  }
}

