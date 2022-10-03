import 'package:flutter/material.dart';

import 'package:pixer/util/dictionary.dart';
import 'package:http/http.dart' as http;

import '../data/api/api_provider.dart';
import '../data/api/response_handler.dart';
import '../model/template.dart';
import '../screens/playground.dart';

class NavigationHelper{
  NavigationHelper._privateConstructor();

  static final NavigationHelper instance =
  NavigationHelper._privateConstructor();
  final _apiProvider = ApiProvider();

  Future<void> onOpenTemplate(
      BuildContext context, dynamic width, dynamic height, dynamic templateId) async{
    final dimension = TemplateDimension(
        width: double.tryParse(width), height: double.tryParse(height));
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
}
