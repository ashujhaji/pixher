import 'package:http/http.dart' as http;

import 'api_constant.dart';

class ApiProvider {
  static ApiProvider? _provider;

  static ApiProvider getInstance() {
    _provider ??= ApiProvider();
    return _provider!;
  }

  Future<http.Response> getCategories() => http.get(
        Uri.parse(ApiConstant.CATEGORIES),
        headers: {ApiConstant.CONTENT_TYPE: ApiConstant.APPLICATION_JSON},
      );

  Future<http.Response> getTemplatesByCategory(categoryId) => http.get(
        Uri.parse(
            '${ApiConstant.TEMPLATES}?categories=$categoryId'),
        headers: {ApiConstant.CONTENT_TYPE: ApiConstant.APPLICATION_JSON},
      );
}
