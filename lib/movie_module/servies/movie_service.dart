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
          "https://api.themoviedb.org/3/trending/all/day?api_key=$global_Api"));
      return compute(movieModelFromMap, response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Up Coming Movies
  static Future<MovieModel> getMovies() async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/trending/movie/day?api_key=$global_Api"));
      return compute(movieModelFromMap, response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Up Coming Movies
  static Future<MovieModel> getTvShow() async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/trending/tv/day?api_key=$global_Api"));
      return compute(movieModelFromMap, response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // TopRated Movies
  static Future<MovieModel> getTopRated() async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc?api_key=$global_Api"));
      return compute(movieModelFromMap, response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
