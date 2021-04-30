import 'package:flutter/material.dart';

class AppRouteMaterialPage extends MaterialPage {
  /// path 是 /a/:id
  final String path;
  final Widget child;
  final Map<String, dynamic> queryParameters = {};
  final Map<String, dynamic> pathParameters = {};
  final Map<String, dynamic> data = {};
  AppRouteMaterialPage(
    this.path,
    this.child, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? pathParameters,
    Map<String, dynamic>? data,
  }) : super(
          child: child,
        ) {
    this.queryParameters.addAll(queryParameters ?? {});
    this.pathParameters.addAll(pathParameters ?? {});
    this.data.addAll(data ?? {});
  }

  /// runtimePath 是 /a/2229
  String get runtimePath {
    final _path = path.replaceAllMapped(RegExp(':[a-zA-Z]*'), (m) {
      return pathParameters[m[0]?.substring(1, m[0]!.length)];
    });
    if (queryParameters.isEmpty)
      return Uri(path: _path).toString();
    else
      return Uri(path: _path, queryParameters: queryParameters).toString();
  }

  @override
  Route createRoute(BuildContext context) {
    // TODO: implement createRoute
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return child;
      },
    );
  }
}

class RouteLocation {
  final String path;
  final Widget child;

  RouteLocation(this.path, this.child);

  AppRouteMaterialPage createPage({queryParameters, pathParameters}) {
    return AppRouteMaterialPage(
      path,
      child,
      queryParameters: queryParameters,
      pathParameters: pathParameters,
    );
  }
}
