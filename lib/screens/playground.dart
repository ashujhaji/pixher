import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../bloc/playground_bloc.dart';
import '../model/template.dart';
import '../repository/playground_repo.dart';
import '../util/dictionary.dart';
import '../widget/image_widget.dart';

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class PlaygroundPage extends StatefulWidget {
  final TemplateDimension? dimensions;
  final Template? template;
  static const tag = 'PlaygroundPage';

  const PlaygroundPage({Key? key, this.dimensions, this.template})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<PlaygroundPage>
    with SingleTickerProviderStateMixin {
  final PlaygroundRepo _repo = PlaygroundRepo();
  late Animation<double> animation;
  late AnimationController controller;
  late GlobalKey _repaintKey;

  bool isRendering = false;

  @override
  void initState() {
    super.initState();
    _repaintKey = GlobalKey();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0, end: 25).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    controller.forward();
  }
  
  File? file;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlaygroundBloc(InitialState(), _repo),
      child: BlocConsumer<PlaygroundBloc, PlaygroundState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 40,
              actions: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<PlaygroundBloc>(context).add(
                      StartRecordingEvent(
                        controller,
                        (value) {
                          setState(() {
                            controller.value = value;
                          });
                        },
                        _repaintKey
                      ),
                    );
                  },
                  icon: const Icon(FeatherIcons.share),
                ),
              ],
            ),
            body: file==null?Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: RepaintBoundary(
                  child: AspectRatio(
                    aspectRatio:
                        widget.dimensions!.width! / widget.dimensions!.height!,
                    child: Container(
                      color: Colors.white,
                      child: ImageWidget(),
                      padding: EdgeInsets.all(animation.value),
                    ),
                  ),
                  key: _repaintKey,
                ),
              ),
            ):Image.file(file!),
          );
        },
        listener: (context, state) {
          if(state is FileSavedState){
            print(state.file.path);
            file = state.file;
          }
        },
      ),
    );
  }

  Future<File> startRecording() async {
    double t = 0;
    int i = 1;

    setState(() {
      controller.value = 0.0;
    });

    Map<int, Uint8List> frames = {};
    double dt = (1 / 60) / controller.duration!.inSeconds.toDouble();
    final img.PngDecoder decoder = img.PngDecoder();
    final List<img.Image?> images = [];
    while (t <= 1.0) {
      var bytes = await _capturePngToUint8List();
      if (bytes != null) {
        frames[i] = bytes;

        images.add(decoder.decodeImage(bytes));
      }
      t += dt;
      setState(() {
        controller.value = t;
      });
      i++;
    }

    List<int>? gifData = generateGIF(images);
    final Directory temp = await getTemporaryDirectory();
    final file =
        await File('${temp.path}/images/' + "img.gif").writeAsBytes(gifData!);
    return file;
    //
    // List<Future<File?>> fileWriterFutures = [];
    // getTemporaryDirectory().then((temp){
    //   frames.forEach((key, value){
    //     //final Directory temp = await getTemporaryDirectory();
    //     final file = _writeFile('${temp.path}/images/' + "frame_$key.png",bytes: value);
    //     if(file != null) fileWriterFutures.add(file);
    //   });
    //   _runFFmpeg();
    // });

    //await Future.wait(fileWriterFutures);

    //print(fileWriterFutures.length);
    //_runFFmpeg();
  }

  List<int>? generateGIF(List<img.Image?> images) {
    final img.Animation animation = img.Animation();
    for (int i = 0; i < images.length; i++) {
      if (images[i] != null) animation.addFrame(images[i]!);
    }
    return img.encodeGifAnimation(animation);
  }

  Future<File?> _writeFile(String location,
      {@required Uint8List? bytes}) async {
    //if(location == null || bytes == null) return  File('');
    File file = File(location);
    if (await file.exists()) {
      // Use the cached images if it exists
    } else {
      // Image doesn't exist in cache
      await file.create(recursive: true);
      // Download the image and write to above file
    }
    if (bytes == null) return null;
    print('here======');
    return file.writeAsBytes(bytes);
  }

  void _runFFmpeg() async {
    // ffmpeg -y -r 60 -start_number 1 -i frame_%d.png -c:v libx264 -preset medium -tune animation -pix_fmt yuv420p test.mp4
    final Directory temp = await getTemporaryDirectory();
    var process = await Process.start(
        "ffmpeg",
        [
          "-y",
          // replace output file if it already exists
          "-r",
          "60",
          // framrate
          "-start_number",
          "1",
          "-i",
          r"/data/user/0/com.pixer.pixer/cache/images/frame_%d.png",
          // <- Change to location of images
          "-an",
          // don't expect audio
          "-c:v",
          "libx264rgb",
          // H.264 encoding
          "-preset",
          "medium",
          "-crf",
          "10",
          // Ranges 0-51 indicates lossless compression to worst compression. Sane options are 0-30
          "-tune",
          "animation",
          "-preset",
          "medium",
          "-pix_fmt",
          "yuv420p",
          r"./test/test.mp4"
          // <- Change to location of output
        ],
        mode: ProcessStartMode
            .inheritStdio // This mode causes some issues at times, so just remove it if it doesn't work. I use it mostly to debug the ffmpeg process' output
        );

    print("Done Rendering");
  }

  void render(BuildContext context, [double? pixelRatio]) async {
    // If already rendering, return
    //if (isRendering) return;

    String outputFileLocation = "final.mp4";

    setState(() {
      isRendering = true;
    });

    controller.stop();

    await controller.animateTo(0.0,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutQuad);
    setState(() {
      controller.value = 0.0;
    });

    await Future.delayed(const Duration(milliseconds: 100));

    try {
      int width = MediaQuery.of(context).size.width.toInt();
      int height = MediaQuery.of(context).size.height.toInt();
      int frameRate = 121;
      int numberOfFrames = frameRate * (controller.duration!.inSeconds);

      print("starting ffmpeg..");
      var process = await Process.start(
          "ffmpeg",
          [
            "-y",
            // replace output file if it already exists
            // "-f", "rawvideo",
            // "-pix_fmt", "rgba",
            "-s",
            "${width}x$height",
            // size
            "-r",
            "$frameRate",
            // framrate
            "-i",
            "-",
            "-frames",
            "$numberOfFrames",
            "-an",
            // don't expect audio
            "-c:v",
            "libx264rgb",
            // H.264 encoding
            "-preset",
            "medium",
            "-crf",
            "10",
            // Ranges 0-51 indicates lossless compression to worst compression. Sane options are 0-30
            "-tune",
            "animation",
            "-preset",
            "medium",
            "-pix_fmt",
            "yuv420p",
            "-vf",
            "pad=ceil(iw/2)*2:ceil(ih/2)*2",
            // ensure width and height is divisible by 2
            outputFileLocation
          ],
          mode: ProcessStartMode.detachedWithStdio,
          runInShell: true);

      print("writing to ffmpeg...");
      RenderRepaintBoundary boundary = _repaintKey.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;

      pixelRatio = pixelRatio ?? 1.0;
      print("Pixel Ratio: $pixelRatio");

      for (int i = 0; i <= numberOfFrames; i++) {
        Timeline.startSync("Render Video Frame");
        double t = (i.toDouble() / numberOfFrames.toDouble());
        // await timeline.animateTo(t, duration: Duration.zero);
        controller.value = t;

        ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
        ByteData? rawData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        var rawIntList = rawData!.buffer.asInt8List().toList();
        Timeline.finishSync();

        if (i % frameRate == 0) {
          print("${((t * 100.0) * 100).round() / 100}%");
        }

        process.stdin.add(rawIntList);

        image.dispose();
      }
      await process.stdin.flush();

      print("stopping ffmpeg...");
      await process.stdin.close();
      process.kill();
      print("done!");
    } catch (e) {
      print(e);
    } finally {
      await controller.animateTo(0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutQuad);
      setState(() {
        isRendering = false;
      });
    }
  }

  Future<Uint8List?> _capturePngToUint8List() async {
    // renderBoxKey is the global key of my RepaintBoundary
    RenderRepaintBoundary boundary =
        _repaintKey.currentContext?.findRenderObject() as RenderRepaintBoundary;

    // pixelratio allows you to render it at a higher resolution than the actual widget in the application.
    ui.Image image = await boundary.toImage(pixelRatio: 2.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();

    return pngBytes;
  }
}
