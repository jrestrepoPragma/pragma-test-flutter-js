# Proyecto web para pruebas de [postMessage](https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage)

## Descripción
Flutter web con ejemplo de comunicación bidireccional entre App flutter y Web flutter, la implementación es con Javascript vanilla.

## Empezar
- Compilar web 
```bash
$ cd web_post_message
$ flutter build web
# web_post_message/build/web es la ruta del compilado web
```
- Cambiar http://localhost:8080 en el proyecto **app_post_message** por la URL donde se despliegue el proyecto **web_post_message**.

- Compilar o ejecutar proyecto **app_post_message**.

## Estructura

### Web

```
.
├── lib
│     ├── main.dart
│     └── js_chanel.dart           # exponer a dart funciones js
└── web
       ├── flutter_postmessage.js  # funciones de comunicación js
       └── index.html              # importar flutter_postmessage.js
```

### App

```
.
├── lib
│     └── main.dart                # WebView http://localhost:8080
└── android…/main
       └── AndroidManifest.xml     # android:usesCleartextTraffic="true"
```

## Dependencias 

### Web
- web

### App
- webview_flutter
- webview_flutter_android
- webview_flutter_wkwebview
- webview_flutter_platform_interface


## Consideraciones 
- Con el nuevo paquete de Flutter [web](https://pub.dev/packages/web) se genera error y no se logró la comunicación desde la Web Flutter.
- La implementación del webView es con el paquete oficial [webview_flutter](https://pub.dev/packages/webview_flutter).
- La función del package de webView addJavaScriptChannel es **Future\<void\>**, por ende no se puede retornar por la misma función información para hacer la comunicación bidireccional.
- Se implementan dos funciones en Javascript para realizar la comunicación bidireccional **flutterWebViewChannel - fromFlutterWebViewChannel**.


