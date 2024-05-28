// To parse this JSON data, do
//
//     final topRated = topRatedFromMap(jsonString);

import 'dart:convert';

TopRated topRatedFromMap(String str) => TopRated.fromMap(json.decode(str));

String topRatedToMap(TopRated data) => json.encode(data.toMap());

class TopRated {
  int? page;
  List<TopRatedResult>? results;
  int? totalPages;
  int? totalResults;

  TopRated({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory TopRated.fromMap(Map<String, dynamic> json) => TopRated(
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<TopRatedResult>.from(
                json["results"]!.map((x) => TopRatedResult.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toMap())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class TopRatedResult {
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;
  String? title;
  double? voteAverage;
  int? voteCount;

  TopRatedResult({
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.voteCount,
  });

  String get dateOnly {
    if (releaseDate == null) return "";
    return "${releaseDate!.day}/${releaseDate!.month}/${releaseDate!.year}";
  }

  factory TopRatedResult.fromMap(Map<String, dynamic> json) => TopRatedResult(
        backdropPath: json["backdrop_path"],
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: "https://image.tmdb.org/t/p/w500/" + json["poster_path"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        title: json["title"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toMap() => {
        "backdrop_path": backdropPath,
        "genre_ids":
            genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "title": title,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
