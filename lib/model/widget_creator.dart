import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixer/util/font_dictionary.dart';
import 'package:pixer/widget/image_widget.dart';
import 'package:pixer/widget/text_widget.dart';
import 'dart:math' as math;

//const WIDGETS = [
const String kContainer = "container";
const String kImageWidget = "image_widget";
const String kStack = "stack";
const String kPadding = "padding";
const String kCachedNetworkImage = "cached_network_image";
const String kAlign = "align";
const String kCard = "card";
const String kColumn = "column";
const String kSizedBox = "sized_box";
const String kTransform = "transform";
const String kTextWidget = 'text_widget';

Widget? getWidgetFromJson(Map<String, dynamic> json, BuildContext context) {
  final widgetType = json['type'];
  if (widgetType == null) return null;
  switch (widgetType) {
    case kContainer:
      {
        return _getContainerFromJson(json, context);
      }
    case kStack:
      {
        return _getStackFromJson(json, context);
      }
    case kPadding:
      {
        return _getPaddingFromJson(json, context);
      }
    case kCachedNetworkImage:
      {
        return _getCachedNetworkImage(json, context);
      }
    case kAlign:
      {
        return _getAlignWidget(json, context);
      }
    case kImageWidget:
      {
        return _getImageWidget(json, context);
      }
    case kCard:
      {
        return _getCard(json, context);
      }
    case kColumn:
      {
        return _getColumnWidget(json, context);
      }
    case kSizedBox:
      {
        return _getSizedBox(json, context);
      }
    case kTextWidget:
      {
        return _getTextWidget(json, context);
      }
    case kTransform:
      {
        return _getTransform(json, context);
      }
  }
  return Container();
}

Container _getContainerFromJson(
    Map<String, dynamic> json, BuildContext context) {
  final attributes = json['attributes'];
  if (attributes == null) return Container();
  Color? color;
  if (attributes['color'] != null &&
      attributes['color'].toString().isNotEmpty) {
    try {
      color = Color(int.parse(attributes['color']));
    } catch (e) {}
  }

  double? width, height;
  final _width = attributes['width'];
  if (_width != null && _width.toString().contains('/')) {
    final _params = _width.toString().split('/');
    if (_params[0].trim() == 'width') {
      width = MediaQuery.of(context).size.width;
      width = MediaQuery.of(context).size.width;
    }
    if (_params[0].trim() == 'height') {
      width = MediaQuery.of(context).size.height;
    }
    try {
      width = width! / double.parse(_params[1].trim());
    } catch (e) {}
  } else {
    try {
      width = double.parse(_width.toString().trim());
    } catch (e) {}
  }
  final _height = attributes['height'];
  if (_height != null && _height.toString().contains('/')) {
    final _params = _height.toString().split('/');
    if (_params[0].trim() == 'width') {
      height = MediaQuery.of(context).size.width;
    }
    if (_params[0].trim() == 'height') {
      height = MediaQuery.of(context).size.height;
    }
    try {
      height = height! / double.parse(_params[1].toString().trim());
    } catch (e) {}
  } else {}

  Widget? child;
  if (json['child'] != null) {
    try {
      child = getWidgetFromJson(json['child'], context);
    } catch (e) {}
  }
  EdgeInsets? margin;
  if(attributes['margin'] != null){
    margin = getEdgeInsets(attributes['margin']);
  }
  return Container(
    color: color,
    child: child,
    width: width,
    height: height,
    margin: margin,
  );
}

Stack _getStackFromJson(Map<String, dynamic> json, BuildContext context) {
  List<Widget> children = [];
  if (json['children'] != null) {
    for (var element in (json['children'])) {
      final widget = getWidgetFromJson(element, context);

      if (widget != null) children.add(widget);
    }
  }

  return Stack(
    children: children,
  );
}

Padding _getPaddingFromJson(Map<String, dynamic> json, BuildContext context) {
  final attributes = json['attributes'];
  double all = 0, left = 0, top = 0, right = 0, bottom = 0;

  if (attributes['all'] != null) {
    all = double.parse(attributes['all'].toString());
  }
  if (attributes['left'] != null) {
    left = double.parse(attributes['left'].toString());
  }
  if (attributes['top'] != null) {
    top = double.parse(attributes['top'].toString());
  }
  if (attributes['right'] != null) {
    right = double.parse(attributes['right'].toString());
  }
  if (attributes['bottom'] != null) {
    bottom = double.parse(attributes['bottom'].toString());
  }

  Widget? child;
  if (json['child'] != null) {
    try {
      child = getWidgetFromJson(json['child'], context);
    } catch (e) {}
  }
  return Padding(
    padding: all > 0
        ? EdgeInsets.all(all)
        : EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
    child: child,
  );
}

CachedNetworkImage _getCachedNetworkImage(
    Map<String, dynamic> json, BuildContext context) {
  final attributes = json['attributes'];
  String url = '';
  double? width, height;
  if (attributes != null) {
    url = attributes['url'];
    final _width = attributes['width'];
    if (_width != null && _width.toString().contains('/')) {
      final _params = _width.toString().split('/');
      if (_params[0].trim() == 'width') {
        width = MediaQuery.of(context).size.width;
      }
      if (_params[0].trim() == 'height') {
        width = MediaQuery.of(context).size.height;
      }
      try {
        width = width! / double.parse(_params[1].trim());
      } catch (e) {}
    } else {
      try {
        width = double.parse(_width.toString().trim());
      } catch (e) {}
    }
    final _height = attributes['height'];
    if (_height != null && _height.toString().contains('/')) {
      final _params = _height.toString().split('/');
      if (_params[0].trim() == 'width') {
        height = MediaQuery.of(context).size.width;
      }
      if (_params[0].trim() == 'height') {
        height = MediaQuery.of(context).size.height;
      }
      try {
        height = double.parse(_height.toString().trim());
      } catch (e) {}
    } else {}
  }
  return CachedNetworkImage(
    imageUrl: url,
    width: width,
    height: height,
  );
}

Align _getAlignWidget(Map<String, dynamic> json, BuildContext context) {
  final attributes = json['attributes'];
  Alignment alignment = Alignment.center;
  if (attributes != null && attributes['alignment'] != null) {
    alignment = alignmentGeometry(attributes['alignment']);
  }
  Widget? widget;
  final child = json['child'];
  if (child != null) {
    widget = getWidgetFromJson(child, context);
  }
  return Align(
    alignment: alignment,
    child: widget,
  );
}

ImageWidget _getImageWidget(Map<String, dynamic> json, BuildContext context) {
  final attributes = json['attributes'];
  Color color = Colors.transparent;
  if (attributes != null && attributes['opacity'] != null) {
    if (attributes['opacity']['color'] != null) {
      color = Color(int.parse(attributes['opacity']['color'].toString()));
    }
    if (attributes['opacity']['opacity'] != null) {
      final opacity = double.parse(attributes['opacity']['opacity'].toString());
      color = color.withOpacity(opacity);
    }
  }
  return ImageWidget(
    opacity: color,
  );
}

Card _getCard(Map<String, dynamic> json, BuildContext context) {
  Color color = Colors.transparent;
  Widget? widget;
  final attributes = json['attributes'];
  if (attributes != null) {
    try {
      color = Color(int.parse(attributes['color']));
    } catch (e) {}
  }

  if (json['child'] != null) {
    widget = getWidgetFromJson(json['child'], context);
  }

  return Card(
    color: color,
    child: widget,
  );
}

Column _getColumnWidget(Map<String, dynamic> json, BuildContext context) {
  List<Widget> children = [];
  if (json['children'] != null) {
    for (var element in json['children']) {
      final widget = getWidgetFromJson(element, context);

      if (widget != null) children.add(widget);
    }
  }

  return Column(
    children: children,
  );
}

SizedBox _getSizedBox(Map<String, dynamic> json, BuildContext context) {
  final attributes = json['attributes'];
  if (attributes == null) return const SizedBox();
  double width = 0.0, height = 0.0;
  final _width = attributes['width'];
  if (_width != null && _width.toString().contains('/')) {
    final _params = _width.toString().split('/');
    if (_params[0].trim() == 'width') {
      width = MediaQuery.of(context).size.width;
    }
    if (_params[0].trim() == 'height') {
      width = MediaQuery.of(context).size.height;
    }
    try {
      width = width / double.parse(_params[1].trim());
    } catch (e) {}
  } else {
    try {
      width = double.parse(_width.toString().trim());
    } catch (e) {}
  }
  final _height = attributes['height'];
  if (_height != null && _height.toString().contains('/')) {
    final _params = _height.toString().split('/');
    if (_params[0].trim() == 'width') {
      height = MediaQuery.of(context).size.width;
    }
    if (_params[0].trim() == 'height') {
      height = MediaQuery.of(context).size.height;
    }
    try {
      height = double.parse(_height.toString().trim());
    } catch (e) {}
  } else {}

  return SizedBox(
    width: width,
    height: height,
  );
}

TextWidget _getTextWidget(Map<String, dynamic> json, BuildContext context) {
  final attributes = json['attributes'];
  if (attributes == null) return TextWidget();
  String hint = '';
  hint = attributes['hint'].toString();


  TextStyle? textStyle;
  TextAlign textAlign = TextAlign.center;

  final style = attributes['text_style'];
  if (style != null) {
    final font = style['font'];
    final fontSize = style['font_size'];
    Color color = Colors.black;
    try {
      color = Color(int.parse(style['color']));
    } catch (e) {}
    textStyle = getTextStyle(font: font, fontSize: fontSize, color: color);

    final align = style['text_align'];
    switch (align) {
      case 'left':
        {
          textAlign = TextAlign.left;
          break;
        }
      case 'right':
        {
          textAlign = TextAlign.right;
          break;
        }
      case 'justify':
        {
          textAlign = TextAlign.justify;
          break;
        }
      case 'start':
        {
          textAlign = TextAlign.start;
          break;
        }
      case 'end':
        {
          textAlign = TextAlign.end;
          break;
        }
    }
  }

  return TextWidget(
    hint: hint,
    textStyle: textStyle,
    textAlign: textAlign,
  );
}

Transform? _getTransform(Map<String, dynamic> json, BuildContext context) {
  final attributes = json['attributes'];
  if (attributes == null) return null;
  AlignmentGeometry alignment = Alignment.center;
  alignment = alignmentGeometry(attributes['alignment']);
  final transform = attributes['transform'];
  Widget? widget;
  if (json['child'] != null) {
    widget = getWidgetFromJson(json['child'], context);
  }
  double radian = getRadian(attributes['radian']);
  return Transform(
    alignment: alignment,
    transform: transform == 'rotationX'
        ? Matrix4.rotationX(radian)
        : Matrix4.rotationY(radian),
    child: widget,
  );
}

Alignment alignmentGeometry(String alignmentText) {
  Alignment alignment;
  switch (alignmentText) {
    case 'topRight':
      {
        alignment = Alignment.topRight;
        break;
      }
    case 'topLeft':
      {
        alignment = Alignment.topLeft;
        break;
      }
    case 'topCenter':
      {
        alignment = Alignment.topCenter;
        break;
      }
    case 'centerLeft':
      {
        alignment = Alignment.centerLeft;
        break;
      }
    case 'centerRight':
      {
        alignment = Alignment.centerRight;
        break;
      }
    case 'bottomLeft':
      {
        alignment = Alignment.bottomLeft;
        break;
      }
    case 'bottomCenter':
      {
        alignment = Alignment.bottomCenter;
        break;
      }
    case 'bottomRight':
      {
        alignment = Alignment.bottomRight;
        break;
      }
    default:
      {
        alignment = Alignment.center;
      }
  }
  return alignment;
}

double getRadian(String radian) {
  switch (radian) {
    case 'pi':
      {
        return math.pi;
      }
    default:
      {
        return math.pi;
      }
  }
}

EdgeInsets getEdgeInsets(Map<String, dynamic> attributes) {
  double? all = 0, left = 0, top = 0, right = 0, bottom = 0;
  if (attributes['all'] != null) {
    all = double.parse(attributes['all'].toString());
  }
  if (attributes['left'] != null) {
    left = double.parse(attributes['left'].toString());
  }
  if (attributes['top'] != null) {
    top = double.parse(attributes['top'].toString());
  }
  if (attributes['right'] != null) {
    right = double.parse(attributes['right'].toString());
  }
  if (attributes['bottom'] != null) {
    bottom = double.parse(attributes['bottom'].toString());
  }
  if (all != 0) {
    return EdgeInsets.all(all);
  } else {
    return EdgeInsets.only(left: left, right: right, bottom: bottom, top: top);
  }
}
