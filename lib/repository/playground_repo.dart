import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class PlaygroundRepo {
  Future<File> startRecording(
    AnimationController controller,
    ValueChanged<double> onAnimationChanged,
    GlobalKey repaintKey, {
    String fileName = 'img',
  }) async {
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
    final file = File('${temp.path}/images/' + "$fileName.gif");
    final status = await file.exists();
    if(!status){
      await file.create(recursive: true);
    }
    file.writeAsBytes(gifData!);
    return file;
  }

  RenderRepaintBoundary? boundary;
  Future<File?> captureScreen(GlobalKey repaintKey,
      {String fileName = 'img'}) async {
   // try{
      boundary ??=
      repaintKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      if (boundary!.debugNeedsPaint) {
        await Future.delayed(const Duration(milliseconds: 20));
        return captureScreen(repaintKey,fileName: fileName);
      }
      final image = await boundary?.toImage(pixelRatio: 1);
      final byteData = await image?.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return null;
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final Directory temp = await getTemporaryDirectory();
      final file = File('${temp.path}/images/' + "$fileName.png");
      if (!file.existsSync()) {
        file.create(recursive: true);
      }
      file.writeAsBytes(pngBytes);
      return file;
    /*}catch(e){
      return null;
    }*/
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
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();

    return pngBytes;
  }

  Future<UploadTask?> uploadFile(File? file) async {
    //return null;
    if (file == null) {
      return null;
    }

    UploadTask uploadTask;

    // Create a Reference to the file
    final fileName = file.path.split('/').last;
    Reference ref =
        FirebaseStorage.instance.ref().child('assets').child(fileName);

    final metadata = SettableMetadata(
      contentType: 'image/${fileName.split('.').last}',
      customMetadata: {'picked-file-path': file.path},
    );

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(file, metadata);
    }

    return Future.value(uploadTask);
  }
}
