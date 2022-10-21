import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;
import 'package:pixer/widget/snackbar.dart';

import '../data/api/api_provider.dart';
import '../data/api/response_handler.dart';
import '../model/categories.dart';
import '../model/playground_model.dart';
import '../model/template.dart';
import '../util/dictionary.dart';
import 'dart:io' show Platform;

class DashboardRepo {
  DashboardRepo._privateConstructor();

  static final DashboardRepo instance = DashboardRepo._privateConstructor();

  final _apiProvider = ApiProvider();
  List<Category> categories = [];
  String? country;

  Future<List<Category>?> fetchCategories() async {

    //================For development only============
    /*if(foundation.kDebugMode){
      return debugCategory;
    }*/
    //================================================
    
    http.Response countryResp = await _apiProvider.getCountry();
    if (ResponseHandler.of(countryResp) != null) {
      Map data = json.decode(countryResp.body);
      country = data['countryCode'];
    }
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

  Future<List<Template>?> fetchTemplatesByCategory(
      String categoryId, BuildContext context) async {
    final tags = [localeTagId['global']];
    if(country!=null){
      tags.add(localeTagId[country]);
    }
    http.Response response = await _apiProvider
        .getTemplatesByCategory(categoryId, tags: tags.join(','));
    if (ResponseHandler.of(response) != null) {
      return templateFromJson(response.body);
    }
    return null;
  }
}
