function flutterWebViewChannel(msg) {
    FlutterWebViewChannel.postMessage(msg);
}

window.fromFlutterWebViewChannel = function(data) {
    console.log('fromFlutterWebViewChannel', JSON.stringify(data));
}
