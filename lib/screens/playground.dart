import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pixer/model/playground_model.dart';
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
  late Animation<double> animation;
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
      animation = playground.animation!
        ..addListener(() {
          setState(() {
            // The state that has changed here is the animation object’s value.
          });
        });
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
            appBar: AppBar(
              toolbarHeight: 40,
              actions: [
                IconButton(
                  onPressed: () {
                    if(playground.animated){
                      BlocProvider.of<PlaygroundBloc>(context).add(
                        StartRecordingEvent(controller, (value) {
                          setState(() {
                            controller.value = value;
                          });
                        }, _repaintKey),
                      );
                    }else{
                      BlocProvider.of<PlaygroundBloc>(context).add(
                        CaptureScreenEvent(_repaintKey),
                      );
                    }
                  },
                  icon: const Icon(FeatherIcons.share),
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
                                value: playground.animated ? animation.value : 0.0,
                                assetUrl: widget.template?.assetImage,
                              ),
                            ),
                            key: _repaintKey,
                          ),
                        ),
                      )
                    : const CircularProgressIndicator()
                : Image.file(file!),
          );
        },
        listener: (context, state) {
          if (state is FileSavedState) {
            if(state.file == null) return;
            file = state.file;
            ShareExtend.share(file!.path, "file");
          }
        },
      ),
    );
  }
}
