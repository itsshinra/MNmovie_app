import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/movie_module/models/anime_model.dart';
import 'package:movie_app/movie_module/models/upcoming_movie_model.dart';

import '../models/anime_detail_model.dart';
import '../models/cast_movie_model.dart';
import '../models/movie_model.dart';
import '../models/top_rated_model.dart';
import '../models/tv_show_model.dart';
import '../util/util.dart';

// movie apiKey
const globalApi = "1f1fbd508b3f8698eb1751a2a4dfe98f";
//anime apiKey
const clientId = "a202af558073a9bfb0b53e9738bfcabc";

class MovieService {
  // Trending Movies
  static Future<MovieModel> getTrendingMovies() async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/trending/all/week?api_key=$globalApi"));
      return compute(movieModelFromMap, response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Cast Movies Details
  static Future<CastModel> fetchMovieCast(int movieId) async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$globalApi"));
      return compute(castMovieModelFromMap, response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Cast Series Details
  static Future<CastModel> fetchSeriesCast(int movieId) async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/tv/$movieId/credits?api_key=$globalApi"));
      return compute(castMovieModelFromMap, response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Upcoming Movies
  static Future<UpcomingMovieModel> getUpcomingMovies() async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/movie/upcoming?api_key=$globalApi"));
      return compute(upcomingMovieModelFromMap, response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // TopRated Movies
  static Future<TopRated> getTopRated() async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/movie/top_rated?api_key=$globalApi"));
      return compute(topRatedFromMap, response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //Movies
  static Future<MovieModel> getMovies({required int page}) async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/trending/movie/day?page=$page&api_key=$globalApi"));

      // log("TV Shows Response: ${response.body}");

      return compute(movieModelFromMap, response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Tv Show
  static Future<TvShow> getTvShow({required int page}) async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/trending/tv/week?page=$page&api_key=$globalApi"));

      // log("TV Shows Response: ${response.body}");

      return compute(tvShowFromMap, response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Anime
  static Future<AnimeModel> getSeasonalAnimesApi({required int limit}) async {
    final year = DateTime.now().year;
    final season = getCurrentSeason();
    final baseUrl =
        "https://api.myanimelist.net/v2/anime/season/$year/$season?limit=$limit";

    // Make a GET request
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'X-MAL-CLIENT-ID': clientId,
        },
      );
      return compute(animeModelFromMap as ComputeCallback<String, AnimeModel>,
          response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Anime Details
  static Future<AnimeDetailModel> getAnimeDetails(int animeId) async {
    final baseUrl =
        "https://api.myanimelist.net/v2/anime/$animeId?fields=id,title,main_picture,start_date,synopsis,rank,media_type,status,genres,start_season,rating,related_anime,recommendations,studios?api_key=$clientId";
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'X-MAL-CLIENT-ID': clientId,
        },
      );
      return compute(
          animeDetailModelFromMap as ComputeCallback<String, AnimeDetailModel>,
          response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
