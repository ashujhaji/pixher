import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pixer/model/playground_model.dart';
import 'package:pixer/screens/home/home.dart';
import 'package:pixer/util/events.dart';
import 'package:share_extend/share_extend.dart';
import '../bloc/playground_bloc.dart';
import '../model/template.dart';
import '../repository/playground_repo.dart';
import '../util/dictionary.dart';
import 'dart:io';

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
  late Playground playground;
  late List<Animation<double>> animation;
  late AnimationController controller;
  late GlobalKey _repaintKey;
  bool isRendering = false;

  @override
  void initState() {
    super.initState();
    _repaintKey = GlobalKey();
    playground = Playground.getParamsFromKey(widget.template!.id, this);
    if (playground.animated) {
      controller = playground.animationController!;
      animation = playground.animation!;
      for (Animation anim in animation) {
        anim.addListener(() {
          setState(() {});
        });
      }
      controller.forward();
    }
  }

  File? file;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlaygroundBloc(InitialState(), _repo),
      child: BlocConsumer<PlaygroundBloc, PlaygroundState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              toolbarHeight: 40,
              backgroundColor: Colors.transparent,
              leading: Container(
                margin: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black45,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black45,
                  ),
                  child: IconButton(
                    onPressed: () {
                      final fileName =
                          '${widget.template?.id.toString()}-${widget.template?.slug.toString()}';
                      if (playground.animated) {
                        BlocProvider.of<PlaygroundBloc>(context).add(
                          StartRecordingEvent(controller, (value) {
                            setState(() {
                              controller.value = value;
                            });
                          }, _repaintKey, fileName: fileName),
                        );
                      } else {
                        BlocProvider.of<PlaygroundBloc>(context).add(
                          CaptureScreenEvent(_repaintKey, fileName: fileName),
                        );
                      }
                    },
                    icon: const Icon(FeatherIcons.share),
                    iconSize: 18,
                  ),
                ),
              ],
            ),
            body: file == null
                ? playground != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: RepaintBoundary(
                            child: AspectRatio(
                              aspectRatio: widget.dimensions!.width! /
                                  widget.dimensions!.height!,
                              child: playgroundWidget(
                                context,
                                widget.template!.id!,
                                animations:
                                    playground.animated ? animation : null,
                                assetUrl: widget.template?.assetImage,
                                animated: playground.animated,
                              ),
                            ),
                            key: _repaintKey,
                          ),
                        ),
                      )
                    : const CircularProgressIndicator()
                : Center(
                    child: Image.file(file!),
                  ),
            floatingActionButton: playground.animated
                ? null
                : FloatingActionButton(
                    onPressed: () {
                      if (playground.animated) {
                        BlocProvider.of<PlaygroundBloc>(context).add(
                          StartRecordingEvent(controller, (value) {
                            setState(() {
                              controller.value = value;
                            });
                          }, _repaintKey, generateHashtag: true),
                        );
                      } else {
                        BlocProvider.of<PlaygroundBloc>(context).add(
                          CaptureScreenEvent(_repaintKey,
                              generateHashtag: true),
                        );
                      }
                    },
                    backgroundColor: const Color(0xff282828),
                    child: Image.asset(
                      'assets/images/hashtag.png',
                      height: 35,
                    ),
                  ),
          );
        },
        listener: (context, state) {
          if (state is FileSavedState) {
            if (state.file == null) return;
            file = state.file;
            _repo.uploadFile(file);
            if (state.generateHashtag) {
              EventBusHelper.instance
                  .getEventBus()
                  .fire(GenerateHashtagEvent(state.file));
              Navigator.of(context).popUntil(ModalRoute.withName(HomePage.tag));
              return;
            }
            ShareExtend.share(file!.path, "file");
          }
        },
      ),
    );
  }
}
