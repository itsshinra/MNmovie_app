
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

const global_api = "1f1fbd508b3f8698eb1751a2a4dfe98f";

class MovieService{
  static Future<MovieModel> getAPI() async{
    try{
      http.Response response = await http.get(Uri.parse("https://api.themoviedb.org/3/trending/all/day?language=en-US&api_key=$global_api"));
      return compute(movieModelFromMap, response.body);
    } catch (e){
      throw Exception(e.toString());
    }
  }
}