import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigator_2_test2/navigator/page.dart';
import 'package:navigator_2_test2/navigator/routes.dart';
import 'package:navigator_2_test2/navigator/uri_parser.dart';

/// 管理路由信息bloc

class NavigatorCubit extends Cubit<List<AppRouteMaterialPage>> {
  NavigatorCubit() : super([rootPage.createPage()]);

  AppRouteMaterialPage get current => state.last;

  /// 通过 path 往当前栈顶挤入一个页面
  pushNamed(String path, {Map<String, dynamic>? data}) {
    final UriParser parser = UriParser(path);
    final AppRouteMaterialPage? findRoute = parser.current;
    if (findRoute != null) {
      state.add(findRoute);
      findRoute.queryParameters.addAll(parser.queryParameters);
      findRoute.pathParameters.addAll(parser.pathParameters);
      findRoute.data.addAll(data ?? {});
    } else {
      state.add(notFoundPage.createPage());
    }
    emit([...state]);
  }

  /// 往当前栈顶挤入一个页面
  push(AppRouteMaterialPage page) {
    state.add(page);
    emit([...state]);
  }

  /// 移除当前栈顶的一个页面
  pop() {
    assert(state.length >= 1, '路由栈内必须保证至少又一个页面存在');
    state.removeLast();
    emit([...state]);
  }

  /// 移除当前栈顶的一个页面同时挤入一个新页面
  redirect() {}

  /// 清空栈只保留 root
  clear() {
    emit([rootPage.createPage()]);
  }

  /// 传递一个路径,清空除了 root 以外的路由再把新页面挤入
  clearAndTo() {}
}
