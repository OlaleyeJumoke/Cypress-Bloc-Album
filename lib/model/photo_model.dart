import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

Photo photoFromJson(String str) => Photo.fromJson(json.decode(str));

String photoToJson(Photo data) => json.encode(data.toJson());

class Photo extends Equatable {
  Photo({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  Photo copyWith({
    int? albumId,
    int? id,
    String? title,
    String? url,
    String? thumbnailUrl,
  }) =>
      Photo(
        albumId: albumId ?? this.albumId,
        id: id ?? this.id,
        title: title ?? this.title,
        url: url ?? this.url,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      );

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };
  @override
  List<Object?> get props => [
        albumId,
        id,
        title,
        url,
        thumbnailUrl,
      ];
}

class PhotoService {
  Future<List<Photo>> photoApiService(int id) async {
    final response = await get(Uri.https(
        "jsonplaceholder.typicode.com", "/photos", {"albumId": id.toString()}));
    if (response.statusCode.toString().startsWith("2")) {
      final decoded = json.decode(response.body);
      final data = List<Photo>.from(decoded.map((e) => Photo.fromJson(e)));

      return data;
    } else {
      return [];
    }
  }
}
