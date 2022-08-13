import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewSearch extends StatelessWidget {
  final String url;
  const WebViewSearch({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Browser",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontSize: 24, color: Theme.of(context).primaryColor),
        ),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
