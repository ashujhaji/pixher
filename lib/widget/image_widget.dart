import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';

class ImageWidget extends StatefulWidget {
  Function? animationCallback;
  Color? opacity;
  ValueChanged<File>? onFileChanged;
  ColorFilter? filter;
  File? file;
  double? height, width;

  ImageWidget(
      {Key? key,
      this.animationCallback,
      this.opacity,
      this.onFileChanged,
      this.filter,
      this.file,
      this.height,
      this.width,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ImageWidgetState(file);
}

class _ImageWidgetState extends State<ImageWidget> {
  File? file;
  bool enableControls = false;

  _ImageWidgetState(this.file);

  @override
  Widget build(BuildContext context) {
    if(widget.width==null || widget.height==null){
      widget.width = MediaQuery.of(context).size.width;
      widget.height = MediaQuery.of(context).size.height;
    }
    final theme = Theme.of(context);
    if (file != null) {
      return Stack(
        children: [
          InteractiveViewer(
            child: ColorFiltered(
              colorFilter: widget.filter == null
                  ? ColorFilter.mode(
                      Colors.black.withOpacity(0.15),
                      BlendMode.srcOver,
                    )
                  : widget.filter!,
              child: Image.file(
                file!,
                fit: BoxFit.cover,
                width: widget.width,
                height: widget.height,
              ),
            ),
            constrained: false,
            boundaryMargin: const EdgeInsets.all(100),
            minScale: 0.5,
            maxScale: 2,
            onInteractionEnd: (details) {
              setState(() {
                enableControls = !enableControls;
              });
            },
          ),
          /*Visibility(
            child: Container(
              color: widget.opacity,
            ),
            visible: widget.opacity != null,
          ),*/
          Visibility(
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                child: Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(2),
                  child: const Icon(
                    FeatherIcons.x,
                    color: Colors.white,
                    size: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black45,
                  ),
                ),
                onTap: () {
                  setState(() {
                    file = null;
                  });
                },
              ),
            ),
            visible: enableControls,
          ),
        ],
      );
    }
    return DottedBorder(
      dashPattern: const [8, 4],
      strokeWidth: 1,
      color: theme.disabledColor,
      child: InkWell(
        child: Container(
          color: theme.disabledColor.withOpacity(0.4),
          alignment: Alignment.center,
          child: const Icon(
            FeatherIcons.plusSquare,
            color: Colors.black45,
            size: 40,
          ),
        ),
        onTap: () {
          imgFromGallery().then((xFile) {
            if (xFile != null) {
              setState(() {
                file = File(xFile.path);
              });
              if (widget.animationCallback != null) {
                widget.animationCallback!();
              }
              if (widget.onFileChanged != null) {
                widget.onFileChanged!(file!);
              }
            }
          }).onError((error, stackTrace) {
            debugPrint(error.toString());
          });
        },
      ),
    );
  }

  Future<XFile?> imgFromGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    return image;
  }
}
