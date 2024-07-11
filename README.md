<h1 align="center">
  <br>
  <a href="http://www.amitmerchant.com/electron-markdownify"><img src="https://f.hubspotusercontent20.net/hubfs/2829524/Copia%20de%20LOGOTIPO_original-2.png"></a>
  <br>
  Pragma
  <br>
</h1>

<h4 align="center">Pruebas ejecución Javascript Flutter.</h4>

<p align="center">
  <a href="https://github.com/invertase/melos#readme-badge">
    <img src="https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square" alt="Melos" />
  </a>
</p>

Proyecto para pruebas de ejecución Javascript en Aplicaciones Flutter.

<p align="center">
  <a href="#topicos">Topicos</a> •
  <a href="#instalación-y-ejecución">Instalación y ejecución</a> •
  <a href="#descarga">Descarga</a> •
  <a href="#consideraciones">Consideraciones</a> •
  <a href="#tecnologias">Tecnologias</a> •
  <a href="#autores">Autores</a> •
  <a href="#relacionados">Relacionados</a> •
  <a href="#roadmap">Roadmap</a>
</p>

## Topicos

* Flutter
* JavaScript
* Webview
* Plugins Flutter

## Instalación y ejecución

Para clonar y ejecutar está aplicación, necesitas [Git](https://git-scm.com) [Melos](https://melos.invertase.dev/) y [Flutter](https://flutter.dev/) instalados en tu equipo. Desde la linea de comando:

```bash
# Clone this repository
$ git clone https://github.com/jrestrepoPragma/pragma-test-flutter-js

# Go into the repository
$ cd pragma-test-flutter-js

# Install dependencies
$ melos bootstrap
 
# Go into the repository
$ cd apps/[APP]

# Run the app
$ flutter run
```

## Descarga

Puedes descargar el proyecto en el enlace [download](https://github.com/jrestrepoPragma/pragma-test-flutter-js) 

## Consideraciones

  ### Web y App webView para comunicación con postMessage:
  
  - #### web_post_message ✅
    Se utiliza javascript vanilla para lograr la comunicación entre la webView y la App.
  
  - #### app_post_message ✅
    Se utiliza webview_flutter package 

  ### Apps webView para ejecutar javascript:

  - #### test_flutter_webview ✅
    Se utiliza webview_flutter package
    https://pub.dev/packages/webview_flutter/example

    _"No agrega peso al tamaño de la aplicación, pero una vista web significa que hay un navegador completo en la mmoria solo para evaluar el código JavaScript."_

    En la revisión y pruebas es la mejor opción, ya que, simplifica la implementación y es un package oficial que se actualiza constantemente.

    4.8.0 > hace 11 días actualizada
    
    **72M**	*apps/test_flutter_webview.apk*  En promedio una app sin nada pesa 70M ~ 80M

  - #### test-flutter-js ⚠️
    Aplicación con package flutter_js actualizado para flutter 3.0 >
    
    0.8.0 > hace 10 meses actualizada

    **139M**	*apps/test-flutter-js-debug.apk*

  - #### flutter_liquidcore 💀
    **DISCONTINUED** replaced by: **flutter_js**

  - #### test_flutter_qjs 🚫
    Aplicación con fluttter < 3.0, no recomendada
    Se devio añadir fvm para realizar pruebas con flutter 2.10.x
    Se avanzo en el error, pero se presenta incompativilidad con la versión de gradle y no se puede compilar
    
    **[CXX1300] CMake '3.10.2' was not found in SDK, PATH, or by cmake.dir property.**

    0.3.7 > hace 2 años sin actualizar

  - #### flutter_jscore 🚫
    Aplicación con fluttter < 3.0, no recomendada
    No se implementa, debido a que se genera error al compilar el ejemplo del proyecto y genera error de versión deprecada.

    **Build failed due to use of deprecated Android v1 embedding.**

    1.0.0 > hace 2 años sin actualizar

## Tecnologias
-   [Dart]
-   [Flutter]

## Autores

- Juan David Restrepo

## Relacionados

- [webview_flutter](https://github.com/flutter/packages/tree/main/packages/webview_flutter/webview_flutter)
- [flutter_js](https://github.com/abner/flutter_js)
- [flutter_jscore](https://github.com/xuelongqy/flutter_jscore)
- [flutter_qjs](https://github.com/ekibun/flutter_qjs)


## Roadmap

- N/A
