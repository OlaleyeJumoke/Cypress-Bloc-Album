// To parse this JSON data, do
//
//     final album = albumFromJson(jsonString);

import 'dart:convert';

import 'package:cypress_assessment/model/photo_model.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

Album albumFromJson(String str) => Album.fromJson(json.decode(str));

String albumToJson(Album data) => json.encode(data.toJson());

class Album extends Equatable {
  Album({
    this.userId,
    this.id,
    this.title,
    this.photos = const [],
  });

  int? userId;
  int? id;
  String? title;
  List<Photo> photos;

  Album copyWith(
          {int? userId,
          int? id,
          String? title,
          List<Photo>? photos = const []}) =>
      Album(
          userId: userId ?? this.userId,
          id: id ?? this.id,
          title: title ?? this.title,
          photos: photos ?? this.photos);

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
  @override
  List<Object?> get props => [
        userId,
        id,
        title,
        photos,
      ];
}

class AlbumService {
  Future<List<Album>> albumApiService() async {
    List<int> albumId = [1, 2, 3, 4];
    List<Album> filteredData = [];
    final response =
        await get(Uri.parse("https://jsonplaceholder.typicode.com/albums"));
    if (response.statusCode.toString().startsWith("2")) {
      final decoded = json.decode(response.body);
      final data = List<Album>.from(decoded.map((e) => Album.fromJson(e)));

      for (var i in albumId) {
        filteredData.add(data.firstWhere((element) => element.userId == i));
      }
      return filteredData;
    } else {
      return [];
    }
  }
}
