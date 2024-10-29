import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:web_post_message/js_chanel.dart';

void main() {
  runApp(const WebView());
}

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  @override
  void initState() {
    window.addEventListener('message', (Event event) {
      final currentEvent = event as MessageEvent;

      debugPrint(
          '👽👽👽 event::\norigin: ${currentEvent.origin}\ncurrentTarget: ${currentEvent.currentTarget.toString()}');
      String? data = currentEvent.data.toString();
      debugPrint('👽👽👽 data:: $data');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(
          child: Text('Test Web view and Iframe Web!'),
        ),
        floatingActionButton: runJavascriptButton(),
      ),
    );
  }

  Widget runJavascriptButton() {
    return FloatingActionButton(
      onPressed: () {
        final transferData = {
          'operation': 'operation_name',
          'origin': 'web_post_message',
          'data': {
            'param1': 'value1',
            'param2': 'value2',
            'param3': 'value3',
          },
        };
        final dataString = json.encode(transferData);

        flutterIframeChannel(dataString);
        flutterWebViewChannel(dataString);
      },
      child: const Icon(Icons.favorite),
    );
  }
}
