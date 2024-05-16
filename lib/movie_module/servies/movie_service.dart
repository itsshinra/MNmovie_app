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

  //Movies
  static Future<MovieModel> getMovies() async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/trending/movie/day?api_key=$global_Api"));
      return compute(movieModelFromMap, response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Tv Show
  static Future<MovieModel> getTvShow() async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/trending/tv/day?api_key=$global_Api"));
      return compute(movieModelFromMap, response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
