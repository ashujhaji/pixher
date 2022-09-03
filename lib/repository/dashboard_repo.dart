import 'package:http/http.dart' as http;

import '../data/api/api_provider.dart';
import '../data/api/response_handler.dart';
import '../model/categories.dart';
import '../model/template.dart';

class DashboardRepo {
  DashboardRepo._privateConstructor();

  static final DashboardRepo instance = DashboardRepo._privateConstructor();

  final _apiProvider = ApiProvider();
  List<Category> categories = [];

  Future<List<Category>?> fetchCategories() async {
    if (categories.isNotEmpty) return categories;
    http.Response response = await _apiProvider.getCategories();
    if (ResponseHandler.of(response) != null) {
      final list = categoryFromJson(response.body)
          .where((element) =>
              element.id != 1 &&
              element.parent != 1 &&
              element.name != 'featured')
          .toList();
      list.sort((b, a) => a.parent!.compareTo(b.parent ?? 0));
      return list;
    }
    return null;
  }

  Future<List<Template>?> fetchTemplatesByCategory(String categoryId) async {
    http.Response response =
        await _apiProvider.getTemplatesByCategory(categoryId);
    if (ResponseHandler.of(response) != null) {
      return templateFromJson(response.body);
    }
    return null;
  }
}
