// To parse this JSON data, do
//
//     final movieModel = movieModelFromMap(jsonString);

import 'dart:convert';

MovieModel movieModelFromMap(String str) =>
    MovieModel.fromMap(json.decode(str));

String movieModelToMap(MovieModel data) => json.encode(data.toMap());

class MovieModel {
  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  MovieModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieModel.fromMap(Map<String, dynamic> json) => MovieModel(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };

  @override
  String toString() {
    return "MovieModel[page=$page, results=${results.length}]";
  }
}

class Result {
  final bool adult;
  final String backdropPath;
  final int id;
  final String? title;
  final String originalLanguage;
  final String? originalTitle;
  final String overview;
  final String posterPath;
  final String mediaType;
  final List<int> genreIds;
  final double popularity;
  final DateTime? releaseDate;
  final bool? video;
  final double voteAverage;
  final int voteCount;
  final String? name;
  final String? originalName;
  final DateTime? firstAirDate;
  final List<String>? originCountry;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.id,
    this.title,
    required this.originalLanguage,
    this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.genreIds,
    required this.popularity,
    this.releaseDate,
    this.video,
    required this.voteAverage,
    required this.voteCount,
    this.name,
    this.originalName,
    this.firstAirDate,
    this.originCountry,
  });

  String get titleOrName {
    if (title == null) {
      return name ?? "no name";
    } else {
      return title ?? "no title";
    }
  }

  String get dateOnly {
    if (releaseDate == null) return "";
    return "${releaseDate!.day}/${releaseDate!.month}/${releaseDate!.year}";
  }

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        title: json["title"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: "https://image.tmdb.org/t/p/w500/" + json["poster_path"],
        mediaType: json["media_type"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"]?.toDouble(),
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        name: json["name"],
        originalName: json["original_name"],
        firstAirDate: json["first_air_date"] == null
            ? null
            : DateTime.parse(json["first_air_date"]),
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "title": title,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaType,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "popularity": popularity,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "name": name,
        "original_name": originalName,
        "first_air_date":
            "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "origin_country": originCountry == null
            ? []
            : List<dynamic>.from(originCountry!.map((x) => x)),
      };

  @override
  String toString() {
    return "Result[title=$title]";
  }
}
