import 'dart:js_interop';

@JS('flutterWebViewChannel')
external void flutterWebViewChannel(String msg);

@JS('flutterIframeChannel')
external void flutterIframeChannel(String msg);
