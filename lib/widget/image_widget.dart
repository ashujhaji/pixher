import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';

class ImageWidget extends StatefulWidget {
  Function? animationCallback;

  ImageWidget({Key? key, this.animationCallback}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  File? file;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (file != null) {
      return Image.file(
        file!,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      );
    }
    return DottedBorder(
      dashPattern: const [8, 4],
      strokeWidth: 1,
      color: theme.disabledColor,
      child: Container(
        color: theme.disabledColor.withOpacity(0.4),
        alignment: Alignment.center,
        child: IconButton(
          onPressed: () {
            imgFromGallery().then((xFile) {
              if (xFile != null) {
                setState(() {
                  file = File(xFile.path);
                });
                if (widget.animationCallback != null) {
                  widget.animationCallback!();
                }
              }
            }).onError((error, stackTrace) {
              debugPrint(error.toString());
            });
          },
          icon: const Icon(
            FeatherIcons.plusSquare,
            color: Colors.black45,
            size: 40,
          ),
        ),
      ),
    );
  }

  Future<XFile?> imgFromGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    return image;
  }
}
