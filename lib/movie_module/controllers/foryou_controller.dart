import 'package:get/get.dart';
import '../models/anime_model.dart';
import '../models/movie_model.dart';
import '../models/top_rated_model.dart';
import '../models/upcoming_movie_model.dart';
import '../servies/movie_service.dart';

class ForYouController extends GetxController {
  var trendingMovie = Future<MovieModel?>.value(null).obs;
  var upcomingMovies = Future<UpcomingMovieModel?>.value(null).obs;
  var topRatedMovies = Future<TopRated?>.value(null).obs;
  var seasonalAnimes = Future<AnimeModel?>.value(null).obs;
  final int limit = 50;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    trendingMovie.value = MovieService.getTrendingMovies();
    upcomingMovies.value = MovieService.getUpcomingMovies();
    topRatedMovies.value = MovieService.getTopRated();
    seasonalAnimes.value = MovieService.getSeasonalAnimesApi(limit: limit);
  }

  Future<void> refresh() async {
    fetchData();
  }
}
