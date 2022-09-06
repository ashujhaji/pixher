import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:pixer/util/dictionary.dart';
import 'package:http/http.dart' as http;

import '../data/api/api_provider.dart';
import '../data/api/response_handler.dart';
import '../model/template.dart';
import '../screens/playground.dart';

class DynamicLinkHandler {
  DynamicLinkHandler._privateConstructor();

  static final DynamicLinkHandler instance =
      DynamicLinkHandler._privateConstructor();
  final _apiProvider = ApiProvider();

  retrieveDynamicLink(BuildContext context) async {
    try {
      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri? deepLink = data?.link;

      if (deepLink != null) {
        _handleDynamicLink(deepLink, context);
      }

      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData? dynamicLink) async {
        _handleDynamicLink(dynamicLink?.link, context);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handleDynamicLink(Uri? link, BuildContext context) async{
    if (link == null) return;
    if (link.toString().contains('templates')) {
      final templateId = link.queryParameters['template_id'];
      final width = link.queryParameters['width'];
      final height = link.queryParameters['height'];
      if (width == null || height == null) return;
      if(templateId==null) return;
      final dimension = TemplateDimension(
          width: double.tryParse(width), height: double.tryParse(height));
      final template = await fetchTemplatesById(templateId);
      if(template==null) return;
      Navigator.of(context).pushNamed(PlaygroundPage.tag, arguments: [
        dimension, template,
      ]);
      return;
    }
  }

  Future<Template?> fetchTemplatesById(String templateId) async {
    http.Response response = await _apiProvider.getTemplatesById(templateId);
    if (ResponseHandler.of(response) != null) {
      return templateFromJson(response.body).first;
    }
    return null;
  }
}
