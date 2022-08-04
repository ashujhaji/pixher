import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../model/template.dart';
import '../util/dictionary.dart';
import '../widget/image_widget.dart';

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
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    animation = Tween<double>(begin: 0, end: 25).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FeatherIcons.share),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: widget.dimensions!.width! / widget.dimensions!.height!,
            child: Container(
              color: Colors.white,
              child: ImageWidget(),
              padding: EdgeInsets.all(animation.value),
            ),
          ),
        ),
      ),
    );
  }
}
