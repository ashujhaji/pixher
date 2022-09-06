import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkCreator {
  DynamicLinkCreator._privateConstructor();

  static final DynamicLinkCreator instance =
      DynamicLinkCreator._privateConstructor();

  Future<Uri> createTemplateLink(String templateId, double width, double height) async {
    final uri = await _createDynamicLink(Uri.parse(
        'https://pixher.app/templates?template_id=$templateId&width=$width&height=$height'));
    return uri;
  }

  Future<Uri> _createDynamicLink(Uri uri) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://pixher.page.link',
      link: uri,
      androidParameters: AndroidParameters(
        packageName: 'com.pixher.android',
        minimumVersion: 1,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.pixher.pixher',
        minimumVersion: '0',
      ),
    );
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    return shortLink.shortUrl;
  }
}
