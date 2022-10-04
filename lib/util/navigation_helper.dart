import 'package:flutter/material.dart';
import 'package:pixer/model/categories.dart';

import 'package:pixer/util/dictionary.dart';
import 'package:http/http.dart' as http;

import '../data/api/api_provider.dart';
import '../data/api/response_handler.dart';
import '../model/template.dart';
import '../screens/playground.dart';
import '../screens/stories.dart';

class NavigationHelper{
  NavigationHelper._privateConstructor();

  static final NavigationHelper instance =
  NavigationHelper._privateConstructor();
  final _apiProvider = ApiProvider();

  Future<void> onOpenTemplate(
      BuildContext context, dynamic dimension, dynamic templateId) async{
    final template = await _fetchTemplatesById(templateId);
    if(template==null) return;
    Navigator.of(context).pushNamed(PlaygroundPage.tag, arguments: [
      dimension, template,
    ]);
    return;
  }

  Future<Template?> _fetchTemplatesById(String templateId) async {
    http.Response response = await _apiProvider.getTemplatesById(templateId);
    if (ResponseHandler.of(response) != null) {
      return templateFromJson(response.body).first;
    }
    return null;
  }


  Future<void> onOpenCategory(
      BuildContext context, dynamic dimension, dynamic categoryId) async{
    final category = Category(
      id: categoryId,
      templateDimension: dimension,
    );
    final templates = await _fetchTemplatesByCategory(categoryId);
    if(templates==null) return;
    category.templates = templates;
    Navigator.of(context).pushNamed(StoriesPage.tag, arguments: [category]);
    return;
  }

  Future<List<Template>?> _fetchTemplatesByCategory(String categoryId) async {
    http.Response response =
    await _apiProvider.getTemplatesByCategory(categoryId);
    if (ResponseHandler.of(response) != null) {
      return templateFromJson(response.body);
    }
    return null;
  }
}
