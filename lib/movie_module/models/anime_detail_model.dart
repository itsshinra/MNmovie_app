// To parse this JSON data, do
//
//     final animeDetailModel = animeDetailModelFromMap(jsonString);

import 'dart:convert';

AnimeDetailModel animeDetailModelFromMap(String str) =>
    AnimeDetailModel.fromMap(json.decode(str));

String animeDetailModelToMap(AnimeDetailModel data) =>
    json.encode(data.toMap());

class AnimeDetailModel {
  int? id;
  String? title;
  AnimeDetailModelMainPicture? mainPicture;
  DateTime? startDate;
  String? synopsis;
  int? rank;
  String? mediaType;
  String? status;
  List<Genre>? genres;
  StartSeason? startSeason;
  String? rating;
  List<RelatedAnime>? relatedAnime;
  List<Recommendation>? recommendations;
  List<Genre>? studios;

  AnimeDetailModel({
    this.id,
    this.title,
    this.mainPicture,
    this.startDate,
    this.synopsis,
    this.rank,
    this.mediaType,
    this.status,
    this.genres,
    this.startSeason,
    this.rating,
    this.relatedAnime,
    this.recommendations,
    this.studios,
  });

  String get dateOnly {
    if (startDate == null) return "";
    return "${startDate!.day}/${startDate!.month}/${startDate!.year}";
  }

  factory AnimeDetailModel.fromMap(Map<String, dynamic> json) =>
      AnimeDetailModel(
        id: json["id"],
        title: json["title"],
        mainPicture: json["main_picture"] == null
            ? null
            : AnimeDetailModelMainPicture.fromMap(json["main_picture"]),
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        synopsis: json["synopsis"],
        rank: json["rank"],
        mediaType: json["media_type"],
        status: json["status"],
        genres: json["genres"] == null
            ? []
            : List<Genre>.from(json["genres"]!.map((x) => Genre.fromMap(x))),
        startSeason: json["start_season"] == null
            ? null
            : StartSeason.fromMap(json["start_season"]),
        rating: json["rating"],
        relatedAnime: json["related_anime"] == null
            ? []
            : List<RelatedAnime>.from(
                json["related_anime"]!.map((x) => RelatedAnime.fromMap(x))),
        recommendations: json["recommendations"] == null
            ? []
            : List<Recommendation>.from(
                json["recommendations"]!.map((x) => Recommendation.fromMap(x))),
        studios: json["studios"] == null
            ? []
            : List<Genre>.from(json["studios"]!.map((x) => Genre.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "main_picture": mainPicture?.toMap(),
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "synopsis": synopsis,
        "rank": rank,
        "media_type": mediaType,
        "status": status,
        "genres": genres == null
            ? []
            : List<dynamic>.from(genres!.map((x) => x.toMap())),
        "start_season": startSeason?.toMap(),
        "rating": rating,
        "related_anime": relatedAnime == null
            ? []
            : List<dynamic>.from(relatedAnime!.map((x) => x.toMap())),
        "recommendations": recommendations == null
            ? []
            : List<dynamic>.from(recommendations!.map((x) => x.toMap())),
        "studios": studios == null
            ? []
            : List<dynamic>.from(studios!.map((x) => x.toMap())),
      };
}

class Genre {
  int? id;
  String? name;

  Genre({
    this.id,
    this.name,
  });

  factory Genre.fromMap(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

class AnimeDetailModelMainPicture {
  String? medium;
  String? large;

  AnimeDetailModelMainPicture({
    this.medium,
    this.large,
  });

  factory AnimeDetailModelMainPicture.fromMap(Map<String, dynamic> json) =>
      AnimeDetailModelMainPicture(
        medium: json["medium"],
        large: json["large"],
      );

  Map<String, dynamic> toMap() => {
        "medium": medium,
        "large": large,
      };
}

class Recommendation {
  Node? node;
  int? numRecommendations;

  Recommendation({
    this.node,
    this.numRecommendations,
  });

  factory Recommendation.fromMap(Map<String, dynamic> json) => Recommendation(
        node: json["node"] == null ? null : Node.fromMap(json["node"]),
        numRecommendations: json["num_recommendations"],
      );

  Map<String, dynamic> toMap() => {
        "node": node?.toMap(),
        "num_recommendations": numRecommendations,
      };
}

class Node {
  int? id;
  String? title;
  NodeMainPicture? mainPicture;

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
            : NodeMainPicture.fromMap(json["main_picture"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "main_picture": mainPicture?.toMap(),
      };
}

class NodeMainPicture {
  String? medium;
  String? large;

  NodeMainPicture({
    this.medium,
    this.large,
  });

  factory NodeMainPicture.fromMap(Map<String, dynamic> json) => NodeMainPicture(
        medium: json["medium"],
        large: json["large"],
      );

  Map<String, dynamic> toMap() => {
        "medium": medium,
        "large": large,
      };
}

class RelatedAnime {
  Node? node;
  String? relationType;
  String? relationTypeFormatted;

  RelatedAnime({
    this.node,
    this.relationType,
    this.relationTypeFormatted,
  });

  factory RelatedAnime.fromMap(Map<String, dynamic> json) => RelatedAnime(
        node: json["node"] == null ? null : Node.fromMap(json["node"]),
        relationType: json["relation_type"],
        relationTypeFormatted: json["relation_type_formatted"],
      );

  Map<String, dynamic> toMap() => {
        "node": node?.toMap(),
        "relation_type": relationType,
        "relation_type_formatted": relationTypeFormatted,
      };
}

class StartSeason {
  int? year;
  String? season;

  StartSeason({
    this.year,
    this.season,
  });

  factory StartSeason.fromMap(Map<String, dynamic> json) => StartSeason(
        year: json["year"],
        season: json["season"],
      );

  Map<String, dynamic> toMap() => {
        "year": year,
        "season": season,
      };
}
