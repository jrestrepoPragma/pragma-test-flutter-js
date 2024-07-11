// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports

void main() => runApp(const MaterialApp(home: WebViewExample()));

const String kLogExamplePage = '''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load file or HTML string example</title>
</head>
<body onload="console.log('Logging that the page is loading.')">

<h1>Local demo page</h1>
<p>
  This page is used to test the forwarding of console logs to Dart.
</p>

<style>
    .btn-group button {
      padding: 24px; 24px;
      display: block;
      width: 25%;
      margin: 5px 0px 0px 0px;
    }
</style>

<div class="btn-group">
    <button onclick="console.error('This is an error message.')">Error</button>
    <button onclick="console.warn('This is a warning message.')">Warning</button>
    <button onclick="console.info('This is a info message.')">Info</button>
    <button onclick="console.debug('This is a debug message.')">Debug</button>
    <button onclick="console.log('This is a log message.')">Log</button>
</div>

</body>
</html>
''';

class WebViewExample extends StatefulWidget {
  const WebViewExample({super.key});

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('Toaster',
          onMessageReceived: (JavaScriptMessage message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      })
      ..addJavaScriptChannel('Print',
          onMessageReceived: (JavaScriptMessage message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Javascript executed: ${message.message}')),
        );
      });

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('Flutter WebView example'),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: <Widget>[
          SampleMenu(webViewController: _controller),
        ],
      ),
      body: WebViewWidget(controller: _controller),
      // body: const Text('data'),
      floatingActionButton: runJavascriptButton(),
    );
  }

  Widget runJavascriptButton() {
    return FloatingActionButton(
      onPressed: () async {
        const String evaluate = """
        var result = 'WebView Test channel Print'; 
        Print.postMessage(result);
        """;

        final result = await _controller.runJavaScript(evaluate) as String;

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result)),
          );
        }
      },
      child: const Icon(Icons.favorite),
    );
  }
}

enum MenuOptions {
  showUserAgent,
  logExample,
}

class SampleMenu extends StatelessWidget {
  SampleMenu({
    super.key,
    required this.webViewController,
  });

  final WebViewController webViewController;
  late final WebViewCookieManager cookieManager = WebViewCookieManager();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOptions>(
      key: const ValueKey<String>('ShowPopupMenu'),
      onSelected: (MenuOptions value) {
        switch (value) {
          case MenuOptions.showUserAgent:
            _onShowUserAgent();
          case MenuOptions.logExample:
            _onLogExample(context);
          default:
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.showUserAgent,
          child: Text('Show user agent'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.logExample,
          child: Text('Log example'),
        ),
      ],
    );
  }

  Future<void> _onShowUserAgent() {
    // Send a message with the user agent string to the Toaster JavaScript channel we registered
    // with the WebView.
    return webViewController.runJavaScript(
      'Toaster.postMessage("User Agent: " + navigator.userAgent);',
    );
  }

  Future<void> _onLogExample(BuildContext context) {
    webViewController
        .setOnConsoleMessage((JavaScriptConsoleMessage consoleMessage) {
      debugPrint(
          '== JS == ${consoleMessage.level.name}: ${consoleMessage.message}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('== JS == ${consoleMessage.message}')),
      );
    });

    return webViewController.loadHtmlString(kLogExamplePage);
  }
}
