import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pixer/model/categories.dart';

import 'package:http/http.dart' as http;
import 'package:pixer/screens/home/create.dart';

import '../data/api/api_provider.dart';
import '../data/api/response_handler.dart';
import '../model/template.dart';
import '../screens/playground.dart';
import '../screens/stories.dart';
import 'circle_transition_clipper.dart';

class NavigationHelper {
  NavigationHelper._privateConstructor();

  static final NavigationHelper instance =
      NavigationHelper._privateConstructor();
  final _apiProvider = ApiProvider();

  Future<void> onOpenTemplate(
      BuildContext context, dynamic dimension, dynamic templateId) async {
    final template = await _fetchTemplatesById(templateId);
    if (template == null) return;
    Navigator.of(context).pushNamed(PlaygroundPage.tag, arguments: [
      dimension,
      template,
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
      BuildContext context, dynamic dimension, dynamic categoryId) async {
    final category = Category(
      id: categoryId,
      templateDimension: dimension,
    );
    final templates = await _fetchTemplatesByCategory(categoryId);
    if (templates == null) return;
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

  Future<void> onOpenSuggestionPage(
      BuildContext context, String? imageUrl) async {
    CreatePage page = CreatePage();
    Route route = PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var screenSIze = MediaQuery.of(context).size;
          var centerCircleClipper =
          Offset(screenSIze.width / 2, screenSIze.height - 60);

          double beginRadius = 0.0;
          double endRadius = screenSIze.height * 1.2;

          var radiusTween = Tween(begin: beginRadius, end: endRadius);
          var radiusTweenAnimation = animation.drive(radiusTween);

          return ClipPath(
            child: child,
            clipper: CircleTransitionClipper(
              radius: radiusTweenAnimation.value,
              center: centerCircleClipper,
            ),
          );
        });
    if(imageUrl!=null){
      final file = await _getFileFromUrl(imageUrl);
      Navigator.of(context).push(route);
      page.getLabels(file);
    }else{
      Navigator.of(context).push(route);
    }
    return;
  }

  Future<File> _getFileFromUrl(String url) async {
    final http.Response responseData = await http.get(Uri.parse(url));
    final uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    var tempDir = await getTemporaryDirectory();
    File file = File('${tempDir.path}/img');
    final status = await file.exists();
    if (!status) {
      await file.create(recursive: true);
    }
    await file.writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }
}
