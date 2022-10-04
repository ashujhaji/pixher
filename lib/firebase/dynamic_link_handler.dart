import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import '../util/dictionary.dart';
import '../util/navigation_helper.dart';

class DynamicLinkHandler {
  DynamicLinkHandler._privateConstructor();

  static final DynamicLinkHandler instance =
      DynamicLinkHandler._privateConstructor();

  retrieveDynamicLink(BuildContext context) async {
    try {
      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri? deepLink = data?.link;

      if (deepLink != null) {
        _handleDynamicLink(deepLink, context);
      }

      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData? dynamicLink) async {
        _handleDynamicLink(dynamicLink?.link, context);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handleDynamicLink(Uri? link, BuildContext context) async {
    if (link == null) return;
    if (link.toString().contains('templates')) {
      final templateId = link.queryParameters['template_id'];
      final width = link.queryParameters['width'];
      final height = link.queryParameters['height'];
      if (width == null || height == null) return;
      if (templateId == null) return;
      NavigationHelper.instance.onOpenTemplate(
          context,
          TemplateDimension(
            width: double.parse(width),
            height: double.parse(height),
          ),
          templateId);
      return;
    }
  }
}
