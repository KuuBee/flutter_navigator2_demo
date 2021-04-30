import 'package:flutter/cupertino.dart';
import 'package:navigator_2_test2/navigator/page.dart';
import 'package:navigator_2_test2/navigator/uri_parser.dart';

class AppRouteInformationParser extends RouteInformationParser<UriParser> {
  @override
  Future<UriParser> parseRouteInformation(RouteInformation routeInformation) async {
    // TODO: implement parseRouteInformation
    return UriParser(routeInformation.location ?? "/");
  }

  @override
  RouteInformation? restoreRouteInformation(UriParser configuration) {
    // print('restoreRouteInformation--:${configuration.current!.runtimePath}');
    // TODO: implement restoreRouteInformation
    final AppRouteMaterialPage current = configuration.current!;
    current.pathParameters.clear();
    current.queryParameters.clear();
    current.pathParameters.addAll(configuration.pathParameters);
    current.queryParameters.addAll(configuration.queryParameters);
    final String location = current.runtimePath;
    return RouteInformation(location: location);
  }
}
