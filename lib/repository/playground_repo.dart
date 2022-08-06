import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class PlaygroundRepo {
  Future<File> startRecording(AnimationController controller,
      ValueChanged<double> onAnimationChanged, GlobalKey repaintKey) async {
    double t = 0;
    int i = 1;
    onAnimationChanged(0);
    Map<int, Uint8List> frames = {};
    double dt = (1 / 60) / controller.duration!.inSeconds.toDouble();
    final img.PngDecoder decoder = img.PngDecoder();
    final List<img.Image?> images = [];
    while (t <= 1.0) {
      var bytes = await _capturePngToUint8List(repaintKey);
      if (bytes != null) {
        frames[i] = bytes;

        images.add(decoder.decodeImage(bytes));
      }
      t += dt;
      onAnimationChanged(t);
      i++;
    }

    List<int>? gifData = generateGIF(images);
    final Directory temp = await getTemporaryDirectory();
    final file =
        await File('${temp.path}/images/' + "img.mov").writeAsBytes(gifData!);
    return file;
  }

  List<int>? generateGIF(List<img.Image?> images) {
    final img.Animation animation = img.Animation();
    for (int i = 0; i < images.length; i++) {
      if (images[i] != null) animation.addFrame(images[i]!);
    }
    return img.encodeGifAnimation(animation);
  }

  Future<Uint8List?> _capturePngToUint8List(GlobalKey repaintKey) async {
    // renderBoxKey is the global key of my RepaintBoundary
    RenderRepaintBoundary boundary =
        repaintKey.currentContext?.findRenderObject() as RenderRepaintBoundary;

    // pixelratio allows you to render it at a higher resolution than the actual widget in the application.
    ui.Image image = await boundary.toImage(pixelRatio: 2.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();

    return pngBytes;
  }
}
