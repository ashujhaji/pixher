import 'dart:convert';

List<CaptionResponse> captionResponseFromJson(String str) => List<CaptionResponse>.from(json.decode(str).map((x) => CaptionResponse.fromJson(x)));

class CaptionResponse {
  CaptionResponse({
    this.q,
    this.a,
    this.c,
    this.h,
  });

  String? q;
  String? a;
  String? c;
  String? h;

  factory CaptionResponse.fromJson(Map<String, dynamic> json) => CaptionResponse(
    q: json["q"],
    a: json["a"],
    c: json["c"],
    h: json["h"],
  );
}
