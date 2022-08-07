// To parse this JSON data, do
//
//     final template = templateFromJson(jsonString);

import 'dart:convert';

List<Template> templateFromJson(String str) =>
    List<Template>.from(json.decode(str).map((x) => Template.fromJson(x)));

class Template {
  Template({
    this.id,
    this.date,
    this.dateGmt,
    this.modified,
    this.modifiedGmt,
    this.slug,
    this.status,
    this.featuredMedia,
    this.tags,
    this.isNew = false,
    this.assetImage,
  });

  int? id;
  DateTime? date;
  DateTime? dateGmt;
  DateTime? modified;
  DateTime? modifiedGmt;
  String? slug;
  String? status;
  String? featuredMedia;
  List<dynamic>? tags;
  bool isNew;
  String? assetImage;

  factory Template.fromJson(Map<String, dynamic> json) => Template(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        dateGmt: DateTime.parse(json["date_gmt"]),
        modified: DateTime.parse(json["modified"]),
        modifiedGmt: DateTime.parse(json["modified_gmt"]),
        slug: json["slug"],
        status: json["status"],
        featuredMedia: json["jetpack_featured_media_url"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        isNew:
            DateTime.now().difference(DateTime.parse(json["date"])).inDays < 2,
        assetImage: _imageUrlFromHtml(json['content']['rendered']),
      );

  static String? _imageUrlFromHtml(String html) {
    final srcReg = RegExp('(?<=src=")[^"]*');
    return srcReg.stringMatch(html).toString();
  }
}
