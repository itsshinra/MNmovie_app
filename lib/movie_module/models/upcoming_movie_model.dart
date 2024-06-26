// To parse this JSON data, do
//
//     final upcomingMovieModel = upcomingMovieModelFromMap(jsonString);

// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

UpcomingMovieModel upcomingMovieModelFromMap(String str) =>
    UpcomingMovieModel.fromMap(json.decode(str));

String upcomingMovieModelToMap(UpcomingMovieModel data) =>
    json.encode(data.toMap());

class UpcomingMovieModel {
  Dates? dates;
  int? page;
  List<UpcomingResult>? results;
  int? totalPages;
  int? totalResults;

  UpcomingMovieModel({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory UpcomingMovieModel.fromMap(Map<String, dynamic> json) =>
      UpcomingMovieModel(
        dates: json["dates"] == null ? null : Dates.fromMap(json["dates"]),
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<UpcomingResult>.from(
                json["results"]!.map((x) => UpcomingResult.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toMap() => {
        "dates": dates?.toMap(),
        "page": page,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toMap())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Dates {
  DateTime? maximum;
  DateTime? minimum;

  Dates({
    this.maximum,
    this.minimum,
  });

  factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum:
            json["maximum"] == null ? null : DateTime.parse(json["maximum"]),
        minimum:
            json["minimum"] == null ? null : DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toMap() => {
        "maximum":
            "${maximum!.year.toString().padLeft(4, '0')}-${maximum!.month.toString().padLeft(2, '0')}-${maximum!.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum!.year.toString().padLeft(4, '0')}-${minimum!.month.toString().padLeft(2, '0')}-${minimum!.day.toString().padLeft(2, '0')}",
      };
}

class UpcomingResult {
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

  UpcomingResult({
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

  factory UpcomingResult.fromMap(Map<String, dynamic> json) => UpcomingResult(
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
