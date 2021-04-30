import 'package:navigator_2_test2/navigator/page.dart';
import 'package:navigator_2_test2/page/not_found.dart';
import 'package:navigator_2_test2/page/one.dart';
import 'package:navigator_2_test2/page/two.dart';
import 'package:navigator_2_test2/page/three.dart';

final routes = <RouteLocation>[
  rootPage,
  RouteLocation('/two', Two()),
  RouteLocation('/three/:id', Three()),
  notFoundPage
];
final rootPage = RouteLocation('/', One());
final notFoundPage = RouteLocation('/404', NotFound());
