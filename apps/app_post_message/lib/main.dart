import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

void main() {
  runApp(const MainApp());
}

///
class MainApp extends StatefulWidget {
  ///
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainApp();
}

///
class _MainApp extends State<MainApp> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'FlutterWebViewChannel',
        onMessageReceived: (JavaScriptMessage message) {
          final response = json.decode(message.message) as Map;
          debugPrint('FlutterWebViewChannel:\n $response');

          final operation = response['operation'];

          if (operation == 'operation_name') {
            // Respuesta al webView
            response['origin'] = 'app_post_message';
            response['data'] = {
              'param1': 'value1',
              'param2': 'value2',
            };

            final responseString = json.encode(response);

            _controller.runJavaScript(
              'window.postMessage(JSON.stringify($responseString));',
            );
          }
        },
      )
      ..addJavaScriptChannel(
        'AnyChannel',
        onMessageReceived: (JavaScriptMessage message) {
          debugPrint('AnyChannel: ${message.message}');
        },
      )
      ..addJavaScriptChannel(
        'ReactNativeWebView',
        onMessageReceived: (JavaScriptMessage message) {
          debugPrint('👻👻👻 ReactNativeWebView 👻👻👻: ${message.message}');

          // Obtener objeto de la web
          final request = json.decode(message.message) as Map;

          // Crear objeto de resputa para la web
          final response = request;
          response['op'] = 'sendDataLogin';
          response['origin'] = 'react-chasis';
          response['payload'] = {
            'isLastVersion': true,
          };

          /* final responseString = json.encode(response);

          // ignore: cast_nullable_to_non_nullable
          _controller.runJavaScript('''
          window.postMessage(JSON.stringify($responseString));
          ''') as String; */
        },
      )
      ..loadRequest(
        Uri.parse('https://wbv.itau.co/contactenos-ppublic/?app=pn'),
      );
    // change http://localhost:8080 by web_post_message URL

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: WebViewWidget(controller: _controller),
        floatingActionButton: runJavascriptButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget runJavascriptButton() {
    return FloatingActionButton(
      onPressed: () {
        _controller.runJavaScript('''
          var Android = window;

          function openExternalBrowser(url, state) {
            let map = {
                'op': 'goToCallKeyboard',
                'origin': 'ContactUs',
                'syncmode' : false,
                'payload': {
                'url' : url,
                'state' : state,
              }
            };  
            ReactNativeWebView.postMessage(JSON.stringify(map));
            console.log('openExternalBrowser', JSON.stringify(map));
          }

          function callPhone(phone) {
            let map = {
                'op': 'goToCallKeyboard',
                'origin': 'ContactUs',
                'syncmode' : false,
                'payload': {
                'numberPhoneFull' : phone,
              }
            };  
            ReactNativeWebView.postMessage(JSON.stringify(map));
            console.log('callPhone', JSON.stringify(map));
          }
        ''');
      },
      child: const Icon(Icons.share),
    );
  }
}
