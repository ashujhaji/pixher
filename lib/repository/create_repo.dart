import 'dart:io';

import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

class CreateRepo{
  Future<List<String>> getLabels(File image) async{
    final List<String> list = [];

    final ImageLabelerOptions options =
    ImageLabelerOptions(confidenceThreshold: 0.5);
    final imageLabeler = ImageLabeler(options: options);
    imageLabeler
        .processImage(InputImage.fromFile(image))
        .then((labels) {
      for (ImageLabel label in labels) {
        final String text = label.label;
        list.add(text);
      }
    });

    return list;
  }
}