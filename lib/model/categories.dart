// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

import '../util/dictionary.dart';
import 'template.dart';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.id,
    this.count,
    this.description,
    this.link,
    this.name,
    this.slug,
    this.parent,
    this.templates,
    this.templateDimension,
    this.featured = false,
  });

  int? id;
  int? count;
  String? description;
  String? link;
  String? name;
  String? slug;
  int? parent;
  List<Template>? templates;
  TemplateDimension? templateDimension;
  bool featured;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      id: json["id"],
      count: json["count"],
      description: json["description"],
      link: json["link"],
      name: json["name"],
      slug: json["slug"],
      parent: json["parent"],
      featured: json['parent']>0,
      templateDimension: TemplateDimension.fromName(json["description"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
        "description": description,
        "link": link,
        "name": name,
        "slug": slug,
        "parent": parent,
      };
}
