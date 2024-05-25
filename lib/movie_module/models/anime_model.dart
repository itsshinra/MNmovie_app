// To parse this JSON data, do
//
//     final animeModel = animeModelFromMap(jsonString);

import 'dart:convert';

AnimeModel animeModelFromMap(String str) =>
    AnimeModel.fromMap(json.decode(str));

String animeModelToMap(AnimeModel data) => json.encode(data.toMap());

class AnimeModel {
  List<Datum>? data;
  Paging? paging;
  Season? season;

  AnimeModel({
    this.data,
    this.paging,
    this.season,
  });

  factory AnimeModel.fromMap(Map<String, dynamic> json) => AnimeModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        paging: json["paging"] == null ? null : Paging.fromMap(json["paging"]),
        season: json["season"] == null ? null : Season.fromMap(json["season"]),
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "paging": paging?.toMap(),
        "season": season?.toMap(),
      };
}

class Datum {
  Node? node;

  Datum({
    this.node,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        node: json["node"] == null ? null : Node.fromMap(json["node"]),
      );

  Map<String, dynamic> toMap() => {
        "node": node?.toMap(),
      };
}

class Node {
  int? id;
  String? title;
  MainPicture? mainPicture;

  Node({
    this.id,
    this.title,
    this.mainPicture,
  });

  factory Node.fromMap(Map<String, dynamic> json) => Node(
        id: json["id"],
        title: json["title"],
        mainPicture: json["main_picture"] == null
            ? null
            : MainPicture.fromMap(json["main_picture"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "main_picture": mainPicture?.toMap(),
      };
}

class MainPicture {
  String? medium;
  String? large;

  MainPicture({
    this.medium,
    this.large,
  });

  factory MainPicture.fromMap(Map<String, dynamic> json) => MainPicture(
        medium: json["medium"],
        large: json["large"],
      );

  Map<String, dynamic> toMap() => {
        "medium": medium,
        "large": large,
      };
}

class Paging {
  String? next;

  Paging({
    this.next,
  });

  factory Paging.fromMap(Map<String, dynamic> json) => Paging(
        next: json["next"],
      );

  Map<String, dynamic> toMap() => {
        "next": next,
      };
}

class Season {
  int? year;
  String? season;

  Season({
    this.year,
    this.season,
  });

  factory Season.fromMap(Map<String, dynamic> json) => Season(
        year: json["year"],
        season: json["season"],
      );

  Map<String, dynamic> toMap() => {
        "year": year,
        "season": season,
      };
}
