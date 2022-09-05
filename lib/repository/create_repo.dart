import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../data/api/api_provider.dart';
import '../data/api/response_handler.dart';
import '../model/caption.dart';
import '../model/hashtags.dart';

class CreateRepo {
  final _apiProvider = ApiProvider();
  String? captionList;

  Future<List<String>> getLabels(File image) async {
    final List<String> list = [];

    MethodChannel _methodChannel = const MethodChannel('flutter.native/helper');
    List<dynamic> documentList=[""];
    try {
      documentList = await _methodChannel.invokeMethod(
          "fetchLabels",{"uri":image.uri.toString()});
    } on PlatformException catch(e){
      print("exceptiong");
    }
    for (var document in documentList) {
      list.add(document);
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

  Future<String> getRandomCaption(List<String> tags) async {
    String query = '';
    String caption = '';
    for(int i=0; i<tags.length ; i++){
      query +='option$i=${tags[i]}';
    }
    http.Response response =
        await _apiProvider.getRandomCaption(query);
    if (ResponseHandler.of(response) != null) {
      final data = captionResponseFromJson(response.body);
      if(data.isNotEmpty){
        caption += '${data[0].q.toString()}\n-${data[0].a.toString()}';
      }
    }
    return caption;
  }
}
