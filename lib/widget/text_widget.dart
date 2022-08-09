import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  final Function? animationCallback;
  final TextStyle? textStyle;
  final String hint;
  final TextAlign textAlign;

  const TextWidget({
    Key? key,
    this.animationCallback,
    this.textStyle,
    this.hint = 'Text Here',
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  bool enableControls = false;
  bool _isEditingText = false;
  String initialText = '';
  late TextEditingController _editingController;

  @override
  void initState() {
    _editingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (_isEditingText) {
      return TextField(
        onSubmitted: (newValue) {
          setState(() {
            initialText = newValue;
            _isEditingText = false;
          });
        },
        autofocus: true,
        controller: _editingController,
        style: widget.textStyle,
        textAlign: widget.textAlign,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          border: InputBorder.none,
        ),
      );
    }
    return InteractiveViewer(
      panEnabled: true,
      constrained: true,
      boundaryMargin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width,
          right: MediaQuery.of(context).size.width),
      minScale: 0.5,
      maxScale: 2,
      child: GestureDetector(
        onTap: () {
          setState(() {
            enableControls = !enableControls;
          });
        },
        onDoubleTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: DottedBorder(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              initialText.isNotEmpty ? initialText : widget.hint,
              style: widget.textStyle,
              textAlign: widget.textAlign,
            ),
          ),
          dashPattern: const [8, 4],
          strokeWidth: 1,
          color: enableControls ? theme.disabledColor : Colors.transparent,
        ),
      ),
    );
  }
}
