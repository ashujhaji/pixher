import 'package:event_bus/event_bus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pixer/firebase/dynamic_link_creator.dart';
import 'package:pixer/model/playground_model.dart';
import 'package:pixer/screens/home/home.dart';
import 'package:pixer/util/events.dart';
import 'package:pixer/widget/snackbar.dart';
import 'package:share_extend/share_extend.dart';
import '../bloc/playground_bloc.dart';
import '../model/template.dart';
import '../model/widget_creator.dart';
import '../repository/playground_repo.dart';
import '../util/dictionary.dart';
import 'dart:io';

import '../util/permission_handler.dart';

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
            resizeToAvoidBottomInset: true,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              toolbarHeight: 40,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leading: playground.available
                  ? Container(
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
                    )
                  : null,
              actions: [
                if (playground.available)
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black45,
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (isRendering) return;
                        if (file != null) {
                          _shareImage(file!);
                          return;
                        }
                        final fileName =
                            '${widget.template?.id.toString()}-${widget.template?.slug.toString()}';
                        if (playground.animated) {
                          BlocProvider.of<PlaygroundBloc>(context).add(
                            StartRecordingEvent(controller, (value) {
                              controller.value = value;
                            }, _repaintKey, fileName: fileName),
                          );
                        } else {
                          BlocProvider.of<PlaygroundBloc>(context).add(
                            CaptureScreenEvent(_repaintKey, fileName: fileName),
                          );
                        }
                        setState(() {
                          isRendering = true;
                        });
                      },
                      icon: const Icon(Icons.share),
                      iconSize: 18,
                    ),
                  )
                else
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black45,
                    ),
                    child: IconButton(
                      icon: const Icon(FeatherIcons.x),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
              ],
            ),
            body: Container(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: /*file == null
                        ? */
                        Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: RepaintBoundary(
                          child: AspectRatio(
                            aspectRatio: widget.dimensions!.width! /
                                widget.dimensions!.height!,
                            child: /*widget.template!.jsonBody != null
                                ? getWidgetFromJson(
                                    widget.template!.jsonBody!, context)
                                : */playgroundWidget(
                                    context,
                                    widget.template!.id!,
                                    (available) {
                                      if (!available) {
                                        playground.available = available;
                                      }
                                    },
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
                    /*: Center(
                            child: Image.file(file!),
                          )*/
                    ,
                  ),
                  if (isRendering)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black.withOpacity(0.6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: ClipRRect(
                              child: LinearProgressIndicator(
                                backgroundColor: Colors.white,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Creating your design...',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                      ),
                    ),
                ],
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            floatingActionButton: !playground.available
                ? null
                : FloatingActionButton.extended(
                    onPressed: () {
                      checkStoragePermission().then((value) {
                        if (value) {
                          if (isRendering) return;
                          if (file != null) {
                            BlocProvider.of<PlaygroundBloc>(context)
                                .add(DownloadFileEvent(file!));
                            return;
                          }
                          final fileName =
                              '${widget.template?.id.toString()}-${widget.template?.slug.toString()}';
                          if (playground.animated) {
                            BlocProvider.of<PlaygroundBloc>(context).add(
                              StartRecordingEvent(
                                controller,
                                (value) {
                                  controller.value = value;
                                },
                                _repaintKey,
                                fileName: fileName,
                                download: true,
                              ),
                            );
                          } else {
                            BlocProvider.of<PlaygroundBloc>(context).add(
                              CaptureScreenEvent(
                                _repaintKey,
                                fileName: fileName,
                                download: true,
                              ),
                            );
                          }
                          setState(() {
                            isRendering = true;
                          });
                        }
                      });
                      return;
                    },
                    backgroundColor: const Color(0xff282828),
                    label: Text(
                      'Download',
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    icon: const Icon(
                      FeatherIcons.download,
                      size: 20,
                    ),
                    /*Image.asset(
                      'assets/images/hashtag.png',
                      height: 25,
                    ),*/
                  ),
          );
        },
        listener: (context, state) {
          if (state is FileSavedState) {
            //isRendering = false;
            if (state.file == null) return;
            file = state.file;
            if (kDebugMode) _repo.uploadFile(file);
            if (state.download) {
              BlocProvider.of<PlaygroundBloc>(context)
                  .add(DownloadFileEvent(file!));
              /*EventBusHelper.instance
                  .getEventBus()
                  .fire(GenerateHashtagEvent(state.file));
              Navigator.of(context).popUntil(ModalRoute.withName(HomePage.tag));*/
              return;
            }
            _shareImage(file!, showProgress: false);
          } else if (state is DownloadFileState) {
            isRendering = false;
            if (state.status == 'ok') {
              showSuccessSnackbar(context, 'Design saved in your gallery');
            } else {
              showErrorSnackbar(context, state.status);
            }
          }
        },
      ),
    );
  }

  _shareImage(File file, {bool showProgress = false}) async {
    if (showProgress) {
      setState(() {
        isRendering = true;
      });
    }
    /*final link = await DynamicLinkCreator.instance.createTemplateLink(
        widget.template!.id.toString(),
        widget.dimensions!.width!,
        widget.dimensions!.height!);*/
    const message =
        'Hey! Try this awesome template to create your next post. Download the app now https://bit.ly/pixher';
    ShareExtend.share(
      file.path,
      "file",
      extraText: message,
    );
    setState(() {
      isRendering = false;
    });
  }
}
