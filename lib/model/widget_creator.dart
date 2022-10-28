import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixer/util/font_dictionary.dart';
import 'package:pixer/widget/image_widget.dart';
import 'package:pixer/widget/text_widget.dart';
import 'dart:math' as math;

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
const String kExpanded = 'expanded';
const String kRotationTransition = 'rotation_transition';
const String kClipRRect = 'clip_r_rect';
const String kCenter = 'center';
const String kOpacity = 'opacity';
const String kPhysicalModel = 'physical_model';
const String kPositioned = 'positioned';
const String kRow = 'row';
const String kText = 'text';

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
    case kExpanded:
      {
        return _getExpanded(json, context);
      }
    case kRotationTransition:
      {
        return _getRotationTransition(json, context);
      }
    case kClipRRect:
      {
        return _getClipRRect(json, context);
      }
    case kCenter:
      {
        return _getCenter(json, context);
      }
    case kOpacity:
      {
        return _getOpacity(json, context);
      }
    case kPositioned:
      {
        return _getPositioned(json, context);
      }
    case kPhysicalModel:
      {
        return _getPhysicalModel(json, context);
      }
    case kRow:
      {
        return _getRowWidget(json, context);
      }
    case kText:
      {
        return _getText(json, context);
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
  if (attributes['margin'] != null) {
    margin = getEdgeInsets(attributes['margin'], context);
  }

  EdgeInsets? padding;
  if (attributes['padding'] != null) {
    padding = getEdgeInsets(attributes['padding'], context);
  }
  return Container(
    color: color,
    child: child,
    width: width,
    height: height,
    margin: margin,
    padding: padding,
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
  EdgeInsets edgeInsets = EdgeInsets.zero;
  if (attributes == null) {
    return Padding(padding: edgeInsets);
  }
  edgeInsets = getEdgeInsets(attributes, context);

  Widget? child;
  if (json['child'] != null) {
    try {
      child = getWidgetFromJson(json['child'], context);
    } catch (e) {}
  }
  return Padding(
    padding: edgeInsets,
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
  double? height, width;

  if (attributes!= null && attributes['width'] != null) {
    final operators = attributes['width'].split('/');
    width = MediaQuery.of(context).size.width;
    if (operators.length > 1) {
      width = width / (double.parse(operators[1].trim()));
    }
  }

  if (attributes!= null && attributes['height'] != null) {
    final operators = attributes['height'].split('/');
    width = MediaQuery.of(context).size.width;
    if (operators.length > 1) {
      width = width / (double.parse(operators[1].trim()));
    }
  }

  ColorFilter? filter;
  if (attributes!= null && attributes['filter'] != null) {
    Color color = Colors.transparent;
    if (attributes['filter']['color'] != null) {
      color = Color(int.parse(attributes['filter']['color'].toString()));
    }
    if (attributes['filter']['opacity'] != null) {
      final opacity = double.parse(attributes['filter']['opacity'].toString());
      color = color.withOpacity(opacity);
    }
    filter = ColorFilter.mode(
      color,
      BlendMode.saturation,
    );
  }
  return ImageWidget(
    opacity: color,
    width: width,
    height: height,
    filter: filter,
  );
}

Card _getCard(Map<String, dynamic> json, BuildContext context) {
  Color color = Colors.white;
  Color shadowColor = Colors.white;
  double elevation = 0.0;
  Widget? widget;
  final attributes = json['attributes'];
  if (attributes != null) {
    try {
      color = Color(int.parse(attributes['color']));

      if (attributes['elevation'] != null) {
        elevation = attributes['elevation'];
      }
      if (attributes['shadow_color'] != null) {
        shadowColor = Color(int.parse(attributes['shadow_color']));
      }
    } catch (e) {}
  }

  if (json['child'] != null) {
    widget = getWidgetFromJson(json['child'], context);
  }

  //TODO : shape

  return Card(
    color: color,
    child: widget,
    elevation: elevation,
    shadowColor: shadowColor,
  );
}

Column _getColumnWidget(Map<String, dynamic> json, BuildContext context) {
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center;
  MainAxisSize mainAxisSize = MainAxisSize.max;

  final attributes = json['attributes'];
  if (attributes != null) {
    switch (attributes['main_axis_alignment']) {
      case 'end':
        {
          mainAxisAlignment = MainAxisAlignment.end;
          break;
        }
      case 'center':
        {
          mainAxisAlignment = MainAxisAlignment.center;
          break;
        }
      case 'space_between':
        {
          mainAxisAlignment = MainAxisAlignment.spaceBetween;
          break;
        }
      case 'space_around':
        {
          mainAxisAlignment = MainAxisAlignment.spaceAround;
          break;
        }
      case 'space_evenly':
        {
          mainAxisAlignment = MainAxisAlignment.spaceEvenly;
          break;
        }
    }

    switch (attributes['cross_axis_alignment']) {
      case 'end':
        {
          crossAxisAlignment = CrossAxisAlignment.end;
          break;
        }
      case 'center':
        {
          crossAxisAlignment = CrossAxisAlignment.center;
          break;
        }
      case 'baseline':
        {
          crossAxisAlignment = CrossAxisAlignment.baseline;
          break;
        }
      case 'stretch':
        {
          crossAxisAlignment = CrossAxisAlignment.stretch;
          break;
        }
    }

    switch (attributes['main_axis_size']) {
      case 'min':
        {
          mainAxisSize = MainAxisSize.min;
          break;
        }
    }
  }

  List<Widget> children = [];
  if (json['children'] != null) {
    for (var element in json['children']) {
      final widget = getWidgetFromJson(element, context);

      if (widget != null) children.add(widget);
    }
  }

  return Column(
    children: children,
    mainAxisAlignment: mainAxisAlignment,
    crossAxisAlignment: crossAxisAlignment,
    mainAxisSize: mainAxisSize,
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

  Widget? child;
  if (json['child'] != null) {
    child = getWidgetFromJson(json['child'], context);
  }

  return SizedBox(
    width: width,
    height: height,
    child: child,
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

  EdgeInsets edgeInsets =
      const EdgeInsets.symmetric(horizontal: 0, vertical: 10);
  if (attributes['padding'] != null) {
    edgeInsets = getEdgeInsets(attributes['padding'], context);
  }

  return TextWidget(
    hint: hint,
    textStyle: textStyle,
    textAlign: textAlign,
    edgeInsetsGeometry: edgeInsets,
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

Expanded _getExpanded(Map<String, dynamic> json, BuildContext context) {
  Widget? child;
  int flex = 1;
  if (json['child'] != null) {
    child = getWidgetFromJson(json['child'], context);
  }
  final attributes = json['attributes'];
  if (attributes != null) {
    if (attributes['flex'] != null) {
      flex = attributes['flex'];
    }
  }
  child ??= Container();
  return Expanded(
    child: child,
    flex: flex,
  );
}

RotationTransition _getRotationTransition(
    Map<String, dynamic> json, BuildContext context) {
  Widget? child;
  if (json['child'] != null) {
    child = getWidgetFromJson(json['child'], context);
  }
  final attributes = json['attributes'];
  int turns = 0;
  if (attributes != null) {
    if (attributes['turns'] != null) {
      turns = attributes['turns'];
    }
  }
  return RotationTransition(
    turns: AlwaysStoppedAnimation(turns / 360),
    child: child,
  );
}

ClipRRect _getClipRRect(Map<String, dynamic> json, BuildContext context) {
  Widget? child;
  if (json['child'] != null) {
    child = getWidgetFromJson(json['child'], context);
  }
  final attributes = json['attributes'];
  BorderRadius borderRadius = BorderRadius.zero;
  if (attributes != null) {
    if (attributes['radius'] != null) {
      borderRadius = getBorderRadius(attributes['radius'], context);
    }
  }
  return ClipRRect(
    borderRadius: borderRadius,
    child: child,
  );
}

Center _getCenter(Map<String, dynamic> json, BuildContext context) {
  Widget? child;
  if (json['child'] != null) {
    child = getWidgetFromJson(json['child'], context);
  }
  return Center(
    child: child,
  );
}

Opacity _getOpacity(Map<String, dynamic> json, BuildContext context) {
  Widget? child;
  if (json['child'] != null) {
    child = getWidgetFromJson(json['child'], context);
  }
  double opacity = 1;
  final attributes = json['attributes'];
  if (attributes != null) {
    opacity = attributes['opacity'] ?? 1;
  }
  return Opacity(
    child: child,
    opacity: opacity,
  );
}

Positioned _getPositioned(Map<String, dynamic> json, BuildContext context) {
  Widget? child;
  if (json['child'] != null) {
    child = getWidgetFromJson(json['child'], context);
  }
  child ??= Container();
  double? width, height, bottom, top, left, right;
  final attributes = json['attributes'];
  if (attributes != null) {
    if (attributes['width'] != null) {
      width = _dimensionExtractor(attributes['width'], context);
    }
    if (attributes['height'] != null) {
      height = _dimensionExtractor(attributes['height'], context);
    }
    if (attributes['top'] != null) {
      top = attributes['top'];
    }
    if (attributes['bottom'] != null) {
      bottom = attributes['bottom'];
    }
    if (attributes['left'] != null) {
      left = attributes['left'];
    }
    if (attributes['right'] != null) {
      right = attributes['right'];
    }
  }
  return Positioned(
    child: child,
    width: width,
    height: height,
    bottom: bottom,
    top: top,
    left: left,
    right: right,
  );
}

PhysicalModel _getPhysicalModel(Map<String, dynamic> json, BuildContext context) {
  Widget? child;
  if (json['child'] != null) {
    child = getWidgetFromJson(json['child'], context);
  }
  final attributes = json['attributes'];
  Color color = Colors.white;
  Color shadowColor = Colors.white;
  double elevation = 0.0;
  BoxShape boxShape = BoxShape.rectangle;
  BorderRadius borderRadius = BorderRadius.zero;
  if (attributes != null) {
    if (attributes['radius'] != null) {
      borderRadius = getBorderRadius(attributes['radius'], context);
    }
    if (attributes['color'] != null) {
      color = Color(int.parse(attributes['color']));
    }
    if (attributes['shadow_color'] != null) {
      shadowColor = Color(int.parse(attributes['shadow_color']));
    }
    if (attributes['elevation'] != null) {
      elevation = attributes['elevation'];
    }
    if (attributes['shape'] == 'circle') {
      boxShape = BoxShape.circle;
    }
  }
  return PhysicalModel(
    borderRadius: borderRadius,
    child: child,
    color: color,
    shadowColor: shadowColor,
    elevation: elevation,
    shape: boxShape,
  );
}

Row _getRowWidget(Map<String, dynamic> json, BuildContext context) {
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center;
  MainAxisSize mainAxisSize = MainAxisSize.max;

  final attributes = json['attributes'];
  if (attributes != null) {
    switch (attributes['main_axis_alignment']) {
      case 'end':
        {
          mainAxisAlignment = MainAxisAlignment.end;
          break;
        }
      case 'center':
        {
          mainAxisAlignment = MainAxisAlignment.center;
          break;
        }
      case 'space_between':
        {
          mainAxisAlignment = MainAxisAlignment.spaceBetween;
          break;
        }
      case 'space_around':
        {
          mainAxisAlignment = MainAxisAlignment.spaceAround;
          break;
        }
      case 'space_evenly':
        {
          mainAxisAlignment = MainAxisAlignment.spaceEvenly;
          break;
        }
    }

    switch (attributes['cross_axis_alignment']) {
      case 'end':
        {
          crossAxisAlignment = CrossAxisAlignment.end;
          break;
        }
      case 'center':
        {
          crossAxisAlignment = CrossAxisAlignment.center;
          break;
        }
      case 'baseline':
        {
          crossAxisAlignment = CrossAxisAlignment.baseline;
          break;
        }
      case 'stretch':
        {
          crossAxisAlignment = CrossAxisAlignment.stretch;
          break;
        }
    }

    switch (attributes['main_axis_size']) {
      case 'min':
        {
          mainAxisSize = MainAxisSize.min;
          break;
        }
    }
  }

  List<Widget> children = [];
  if (json['children'] != null) {
    for (var element in json['children']) {
      final widget = getWidgetFromJson(element, context);

      if (widget != null) children.add(widget);
    }
  }

  return Row(
    children: children,
    mainAxisAlignment: mainAxisAlignment,
    crossAxisAlignment: crossAxisAlignment,
    mainAxisSize: mainAxisSize,
  );
}

Text _getText(Map<String, dynamic> json, BuildContext context) {
  final attributes = json['attributes'];
  if (attributes == null) {
    return const Text('');
  }
  String data = '';
  if (attributes['data'] != null) {
    data = attributes['data'];
  }

  int? maxLines;

  if (attributes['max_lines'] != null) {
    maxLines = attributes['max_lines'];
  }

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

  return Text(
    data,
    style: textStyle,
    maxLines: maxLines,
    textAlign: textAlign,
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

BorderRadius getBorderRadius(
    Map<String, dynamic> attributes, BuildContext context) {
  double all = 0, topLeft = 0, topRight = 0, bottomRight = 0, bottomLeft = 0;
  if (attributes['all'] != null) {
    all = attributes['all'];
    return BorderRadius.circular(all);
  }
  if (attributes['top_left'] != null) {
    topLeft = attributes['top_left'];
  }
  if (attributes['top_right'] != null) {
    topRight = attributes['top_right'];
  }
  if (attributes['bottom_left'] != null) {
    bottomLeft = attributes['bottom_left'];
  }
  if (attributes['bottom_right'] != null) {
    bottomRight = attributes['bottom_right'];
  }
  return BorderRadius.only(
    topLeft: Radius.circular(topLeft),
    topRight: Radius.circular(topRight),
    bottomLeft: Radius.circular(bottomLeft),
    bottomRight: Radius.circular(bottomRight),
  );
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

EdgeInsets getEdgeInsets(
    Map<String, dynamic> attributes, BuildContext context) {
  double? all = 0,
      left = 0,
      top = 0,
      right = 0,
      bottom = 0,
      horizontal = 0,
      vertical = 0;
  if (attributes['all'] != null) {
    all = _dimensionExtractor(attributes['all'], context);
  }
  if (attributes['left'] != null) {
    left = _dimensionExtractor(attributes['left'], context);
  }
  if (attributes['top'] != null) {
    top = _dimensionExtractor(attributes['top'], context);
  }
  if (attributes['right'] != null) {
    right = _dimensionExtractor(attributes['right'], context);
  }
  if (attributes['bottom'] != null) {
    bottom = _dimensionExtractor(attributes['bottom'], context);
  }
  if (attributes['horizontal'] != null) {
    horizontal = _dimensionExtractor(attributes['horizontal'], context);
  }
  if (attributes['vertical'] != null) {
    vertical = _dimensionExtractor(attributes['vertical'], context);
  }
  if (all != 0) {
    return EdgeInsets.all(all);
  } else if (horizontal > 0 || vertical > 0) {
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  } else {
    return EdgeInsets.only(left: left, right: right, bottom: bottom, top: top);
  }
}

double _dimensionExtractor(dynamic data, BuildContext context,
    {List<Animation<double>>? animations}) {
  double dimen = 0;
  if(data is double){
    return data;
  }
  try {
    if (data.contains('width')) {
      final operators = data.split('/');
      dimen = MediaQuery.of(context).size.width;
      if (operators.length > 1) {
        dimen = dimen / (double.parse(operators[1].trim()));
      }
    }

    if (data.contains('height')) {
      final operators = data.split('/');
      dimen = MediaQuery.of(context).size.height;
      if (operators.length > 1) {
        dimen = dimen / (double.parse(operators[1].trim()));
      }
    }

    /*if (data.contains('animation') && animations!=null) {
      if(data.contains('[0]')){
        final animVal = animations[0].value;
      }else if(data.contains('[1]')){
        final animVal = animations[1].value;
      }
    }*/
  } catch (e) {
    dimen = double.tryParse(data) ?? 0.0;
  }

  return dimen;
}
