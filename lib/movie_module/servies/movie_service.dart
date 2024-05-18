import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

// ignore: constant_identifier_names
const global_Api = "1f1fbd508b3f8698eb1751a2a4dfe98f";

class MovieService {
  // Trending Movies
  static Future<MovieModel> getTrendingMovies() async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/trending/all/week?api_key=$global_Api"));
      return compute(movieModelFromMap, response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //Movies
  static Future<MovieModel> getMovies({required int page}) async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/trending/movie/day?page=$page&api_key=$global_Api"));

      // log("TV Shows Response: ${response.body}");

      return compute(movieModelFromMap, response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Tv Show
  static Future<MovieModel> getTvShow({required int page}) async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/trending/tv/week?page=$page&api_key=$global_Api"));

      // log("TV Shows Response: ${response.body}");

      return compute(movieModelFromMap, response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
