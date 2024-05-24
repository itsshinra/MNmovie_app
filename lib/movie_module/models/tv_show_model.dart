// To parse this JSON data, do
//
//     final tvShow = tvShowFromMap(jsonString);

import 'dart:convert';

TvShow tvShowFromMap(String str) => TvShow.fromMap(json.decode(str));

String tvShowToMap(TvShow data) => json.encode(data.toMap());

class TvShow {
  int? page;
  List<TvShowResult>? results;
  int? totalPages;
  int? totalResults;

  TvShow({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory TvShow.fromMap(Map<String, dynamic> json) => TvShow(
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<TvShowResult>.from(
                json["results"]!.map((x) => TvShowResult.fromMap(x))),
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

class TvShowResult {
  String? backdropPath;
  int? id;
  String? originalName;
  String? overview;
  String? posterPath;
  String? mediaType;
  bool? adult;
  String? name;
  String? originalLanguage;
  List<int>? genreIds;
  double? popularity;
  String? firstAirDate;
  double? voteAverage;
  int? voteCount;
  List<String>? originCountry;

  TvShowResult({
    this.backdropPath,
    this.id,
    this.originalName,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.adult,
    this.name,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.firstAirDate,
    this.voteAverage,
    this.voteCount,
    this.originCountry,
  });

  factory TvShowResult.fromMap(Map<String, dynamic> json) => TvShowResult(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        originalName: json["original_name"],
        overview: json["overview"],
        posterPath: "https://image.tmdb.org/t/p/w500/" + json["poster_path"],
        mediaType: json["media_type"],
        adult: json["adult"],
        name: json["name"],
        originalLanguage: json["original_language"],
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        popularity: json["popularity"]?.toDouble(),
        firstAirDate: json["first_air_date"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "backdrop_path": backdropPath,
        "id": id,
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaType,
        "adult": adult,
        "name": name,
        "original_language": originalLanguage,
        "genre_ids":
            genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "popularity": popularity,
        "first_air_date": firstAirDate,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "origin_country": originCountry == null
            ? []
            : List<dynamic>.from(originCountry!.map((x) => x)),
      };
}
