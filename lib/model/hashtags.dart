import 'dart:convert';

Hashtag hashtagFromJson(String str) => Hashtag.fromJson(json.decode(str));


class Hashtag {
  Hashtag({
    this.count,
    this.data,
  });

  int? count;
  List<TopSection>? data;

  factory Hashtag.fromJson(Map<String, dynamic> json) => Hashtag(
    count: json["count"],
    data: List<TopSection>.from(json['data']['top']["sections"].map((x) => TopSection.fromJson(x)))
  );
}

class TopSection {
  TopSection({
    this.layoutContent,
  });

  List<TentacledMedia>? layoutContent;

  factory TopSection.fromJson(Map<String, dynamic> json) => TopSection(
    layoutContent: List<TentacledMedia>.from(json['layout_content']["medias"].map((x) => TentacledMedia.fromJson(x))),
  );
}

class TentacledMedia {
  TentacledMedia({
    this.caption,
  });

  String? caption;

  factory TentacledMedia.fromJson(Map<String, dynamic> json) => TentacledMedia(
    caption: json["media"]['caption']['text'],
  );
}