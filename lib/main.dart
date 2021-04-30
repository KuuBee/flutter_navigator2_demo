import 'package:flutter/material.dart';
import 'package:navigator_2_test2/navigator/app_route_information_parser.dart';
import 'package:navigator_2_test2/navigator/app_router_delegate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: AppRouteInformationParser(),
      routerDelegate: AppRouterDelegate(),
    );
  }
}
