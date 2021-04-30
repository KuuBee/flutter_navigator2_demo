import 'package:navigator_2_test2/navigator/page.dart';
import 'package:navigator_2_test2/navigator/routes.dart';

class UriParser {
  final String uri;
  final String? rawUri;
  final Map<String, dynamic> _pathParameters = {};
  final Map<String, dynamic> _queryParameters = {};
  AppRouteMaterialPage? _current;
  UriParser(this.uri, {this.rawUri}) {
    final findIndex = routes.indexWhere((item) => _isThisRoutes(uri, item));
    if (findIndex != -1) {
      this._current = routes[findIndex].createPage(
        queryParameters: queryParameters,
        pathParameters: pathParameters,
      );
    }
  }

  /// 只考虑以下uri
  /// /
  /// /a
  /// /a/:id
  /// /a/:id/b
  /// /a?a=x
  /// /a?a=x&b=c

  /// 路径参数
  /// /a/:uid
  get pathParameters => _pathParameters;

  /// query参数
  /// /a?uid=x&cid=aa
  get queryParameters => _queryParameters;

  /// 通过路由判断出来的 AppRouteMaterialPage 实例
  AppRouteMaterialPage? get current => _current;

  /// 判断当前uri是否匹配路由表
  bool _isThisRoutes(String uri, RouteLocation route) {
    /// 先进行切片
    /// uri是实际再跑的url
    /// /a/1/b?xc=2
    /// route.path 是路由表内的
    /// /a/:id/b
    final uriParse = Uri.parse(uri);
    final currentParse = Uri.parse(route.path);
    final uriPathSegments = uriParse.pathSegments;
    final currentPathSegments = currentParse.pathSegments;

    if (uriPathSegments.length == currentPathSegments.length) {
      /// 如果长度相同则才有比较的必要 否则直接返回 false
      bool isThis = true;
      uriPathSegments.asMap().forEach((key, value) {
        if (!isThis) return;
        final currentPathValue = currentPathSegments[key];
        final pathParametersIndex = currentPathValue.indexOf(':');
        if (pathParametersIndex == -1) {
          /// 不当前分隔不存在 pathParameters
          isThis = currentPathValue == value;
        } else {
          /// 如果存在就往 _pathParameters 里面缓存
          _pathParameters[currentPathValue.substring(pathParametersIndex + 1, currentPathValue.length)] = value;
        }
      });

      /// 如果 isThis 是 false 就清空写入的缓存即使有部分匹配
      /// 反之就获取当前路由的 query 添加进去
      if (!isThis)
        _pathParameters.clear();
      else
        _queryParameters.addAll(uriParse.queryParameters);
      return isThis;
    } else
      return false;
  }
}
