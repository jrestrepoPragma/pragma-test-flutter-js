function flutterWebViewChannel(msg) {
    ReactNativeWebView.postMessage(msg);
}

function flutterIframeChannel(msg) {
    window.parent.postMessage(msg, '*');
}
