import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class IFrameScreen extends StatefulWidget {
  const IFrameScreen({super.key});

  @override
  State<IFrameScreen> createState() => _IFrameScreenState();
}

class _IFrameScreenState extends State<IFrameScreen> {
  final IFrameElement _iFrameElement = IFrameElement();

  @override
  void initState() {
    _iFrameElement.style.height = '80%';
    _iFrameElement.style.width = '80%';
    _iFrameElement.src = 'http://localhost:8080/';
    _iFrameElement.style.border = 'none';

    window.addEventListener('message', (Event event) {
      String? data = (event as MessageEvent).data.toString();
      debugPrint('👻👻👻 :: $data');
    });

// ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iFrameElement',
      (int viewId) => _iFrameElement,
    );

    super.initState();
  }

  final Widget _iFrameWidget = HtmlElementView(
    viewType: 'iFrameElement',
    key: UniqueKey(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: _iFrameWidget,
            )
          ],
        ),
      ),
      floatingActionButton: runJavascriptButton(),
    );
  }

  Widget runJavascriptButton() {
    return FloatingActionButton(
      onPressed: () {
        _iFrameElement.contentWindow?.postMessage('message', '*');
      },
      child: const Icon(Icons.favorite),
    );
  }
}
