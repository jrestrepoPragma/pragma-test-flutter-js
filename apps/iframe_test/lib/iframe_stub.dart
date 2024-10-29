import 'package:flutter/material.dart';

class IFrameScreen extends StatefulWidget {
  const IFrameScreen({super.key});

  @override
  State<IFrameScreen> createState() => _IFrameScreenState();
}

class _IFrameScreenState extends State<IFrameScreen> {
  @override
  void initState() {
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
    );
  }
}
