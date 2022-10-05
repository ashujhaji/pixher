import 'package:http/http.dart' as http;

import 'api_constant.dart';

class ApiProvider {
  static ApiProvider? _provider;

  static ApiProvider getInstance() {
    _provider ??= ApiProvider();
    return _provider!;
  }

  Future<http.Response> getCountry() => http.get(
    Uri.parse('http://ip-api.com/json'),
    headers: {ApiConstant.CONTENT_TYPE: ApiConstant.APPLICATION_JSON},
  );

  Future<http.Response> getCategories() => http.get(
        Uri.parse(ApiConstant.CATEGORIES+'?per_page=100'),
        headers: {ApiConstant.CONTENT_TYPE: ApiConstant.APPLICATION_JSON},
      );

  Future<http.Response> getTemplatesByCategory(categoryId,{String? tags}) => http.get(
        Uri.parse(
            '${ApiConstant.TEMPLATES}?categories=$categoryId&tags=$tags'),
        headers: {ApiConstant.CONTENT_TYPE: ApiConstant.APPLICATION_JSON},
      );

  Future<http.Response> getTemplatesById(templateId) => http.get(
    Uri.parse(
        '${ApiConstant.TEMPLATES}?include[]=$templateId'),
    headers: {ApiConstant.CONTENT_TYPE: ApiConstant.APPLICATION_JSON},
  );
  
  Future<http.Response> getRelevantTags(tag, appId, cookie) => http.get(
    Uri.parse('${ApiConstant.INSTAGRAM_API}?tag_name=$tag'),
    headers: {ApiConstant.CONTENT_TYPE: ApiConstant.APPLICATION_JSON,
    'x-ig-app-id':appId,
    'cookie':cookie,},
  );

  Future<http.Response> getRandomCaption(tags) => http.get(
    Uri.parse('${ApiConstant.CAPTION_API}?$tags'),
  );
}
