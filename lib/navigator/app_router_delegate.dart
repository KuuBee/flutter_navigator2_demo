import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigator_2_test2/cubit/navigator.dart';
import 'package:navigator_2_test2/navigator/page.dart';
import 'package:navigator_2_test2/navigator/uri_parser.dart';

class AppRouterDelegate extends RouterDelegate<UriParser>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<UriParser> {
  NavigatorCubit? _navigatorCubit;

  @override
  // TODO: implement currentConfiguration
  UriParser get currentConfiguration {
    if (_navigatorCubit != null) {
      final String path = _navigatorCubit!.current.runtimePath;
      return UriParser(path);
    }
    return UriParser('/');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (context) => NavigatorCubit(),
      child: BlocListener<NavigatorCubit, List<AppRouteMaterialPage>>(
        listener: (context, pages) {
          _navigatorCubit = context.read<NavigatorCubit>();
          notifyListeners();
        },
        child: Builder(
          builder: (context) {
            return Navigator(
              pages: context.read<NavigatorCubit>().state,
              onPopPage: (route, result) {
                if (!route.didPop(result)) return false;
                _navigatorCubit?.pop();
                return true;
              },
            );
          },
        ),
      ),
    );
  }

  @override
  // TODO: implement navigatorKey
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(UriParser configuration) async {
    // TODO: implement setNewRoutePath
    if (_navigatorCubit != null) {
      final NavigatorCubit _cubit = _navigatorCubit!;
      if (configuration.uri == '/') {
        _cubit.clear();
        return;
      }
      if (configuration.current != null) {
        final bool havePage = _cubit.state.any((page) => page.runtimePath == configuration.uri);
        if (havePage)
          _cubit.pop();
        else {
          _cubit.push(configuration.current!);
        }
      } else
        _cubit.pushNamed('/404');
    }
  }
}
