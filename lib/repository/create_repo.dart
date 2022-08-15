import 'dart:io';

import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:http/http.dart' as http;

import '../data/api/api_provider.dart';
import '../data/api/response_handler.dart';
import '../model/hashtags.dart';

class CreateRepo {
  final _apiProvider = ApiProvider();

  Future<List<String>> getLabels(File image) async {
    final List<String> list = [];

    final ImageLabelerOptions options =
        ImageLabelerOptions(confidenceThreshold: 0.5);
    final imageLabeler = ImageLabeler(options: options);
    final labels = await imageLabeler.processImage(InputImage.fromFile(image));

    for (ImageLabel label in labels) {
      final String text = label.label;
      list.add(text);
    }

    return list;
  }

  Future<Map<String, bool>> getTags(String tag) async {
    Map<String, bool> res = {};
    http.Response response = await _apiProvider.getRelevantTags(tag);
    if (ResponseHandler.of(response) != null) {
      final sections = hashtagFromJson(response.body).data;
      if (sections == null) return {};
      for (var element1 in sections) {
        if (element1.layoutContent != null) {
          for (var element2 in element1.layoutContent!) {
            RegExp regex = RegExp("#[a-zA-Z]+");
            regex.allMatches(element2.caption.toString()).forEach((element) {
              res[element.group(0).toString()] = false;
            });
          }
        }
      }
    }
    return res;
  }
}
