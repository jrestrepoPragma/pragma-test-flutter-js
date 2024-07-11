import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_post_message/js_chanel.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(
          child: Text('Test Web view!'),
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
          'origin': 'origin_name',
          'data': {
            'param1': 'value1',
            'param2': 'value2',
            'param3': 'value3',
          },
        };
        final dataString = json.encode(transferData);
        flutterWebViewChannel(dataString);
      },
      child: const Icon(Icons.favorite),
    );
  }
}
