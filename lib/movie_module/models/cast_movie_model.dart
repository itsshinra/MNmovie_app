// To parse this JSON data, do
//
//     final castMovieModel = castMovieModelFromMap(jsonString);

import 'dart:convert';

CastModel castMovieModelFromMap(String str) =>
    CastModel.fromMap(json.decode(str));

String castMovieModelToMap(CastModel data) => json.encode(data.toMap());

class CastModel {
  int? id;
  List<Cast>? cast;

  CastModel({
    this.id,
    this.cast,
  });

  factory CastModel.fromMap(Map<String, dynamic> json) => CastModel(
        id: json["id"],
        cast: json["cast"] == null
            ? []
            : List<Cast>.from(json["cast"]!.map((x) => Cast.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "cast":
            cast == null ? [] : List<dynamic>.from(cast!.map((x) => x.toMap())),
      };
}

class Cast {
  int? id;
  String? name;
  String? profilePath;
  int? castId;
  String? character;

  Cast({
    this.id,
    this.name,
    this.profilePath,
    this.castId,
    this.character,
  });

  factory Cast.fromMap(Map<String, dynamic> json) => Cast(
        id: json["id"],
        name: json["name"],
        profilePath: json["profile_path"] != null
            // ignore: prefer_interpolation_to_compose_strings
            ? "https://image.tmdb.org/t/p/w500/" + json["profile_path"]
            : 'https://archive.org/download/default_profile/default-avatar.png', // Default profile path
        castId: json["cast_id"],
        character: json["character"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
      };
}
