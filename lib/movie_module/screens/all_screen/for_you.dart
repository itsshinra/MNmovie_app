import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD:lib/movie_module/views/all_screen/for_you.dart
import 'package:get/get.dart';
import 'package:movie_app/movie_module/controllers/foryou_controller.dart';
import 'package:movie_app/movie_module/controllers/theme_controller.dart';
=======
>>>>>>> parent of 8dfca63 (Implement Getx State and DarkMode theme):lib/movie_module/screens/all_screen/for_you.dart
import 'package:movie_app/movie_module/models/anime_model.dart';
import 'package:movie_app/movie_module/models/movie_model.dart';
import 'package:movie_app/movie_module/models/top_rated_model.dart';
import 'package:movie_app/movie_module/models/upcoming_movie_model.dart';
import 'package:movie_app/movie_module/screens/screens_detail/anime_detail_screen.dart';
import 'package:movie_app/movie_module/screens/screens_detail/movie_detail_screen.dart';
import 'package:movie_app/movie_module/screens/screens_detail/toprate_detail_screen.dart';
import 'package:movie_app/movie_module/screens/screens_detail/upcoming_detail_screen.dart';
import 'package:movie_app/movie_module/servies/movie_service.dart';
import '../../skeleton/for_you_skeleton.dart';
import '../../skeleton/trending_skeleton.dart';

class ForYou extends StatefulWidget {
  const ForYou({super.key});

  @override
  State<ForYou> createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> {
<<<<<<< HEAD:lib/movie_module/views/all_screen/for_you.dart
  final _controller = Get.put(ForYouController());
  final controller = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RefreshIndicator(
        color: Colors.black,
        backgroundColor: Colors.white,
        onRefresh: _controller.refresh,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Trending',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:
                    controller.isDarkMode.value ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            _buildTrending(),
            const SizedBox(height: 16),
            Text(
              'Upcoming',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color:
                    controller.isDarkMode.value ? Colors.white : Colors.black,
              ),
=======
  late Future<MovieModel> trendingMovie;
  late Future<UpcomingMovieModel> upcomingMovies;
  late Future<TopRated> topRatedMovies;
  late Future<AnimeModel> seasonalAnimes;
  final int _limit = 50;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    setState(() {
      trendingMovie = MovieService.getTrendingMovies();
      upcomingMovies = MovieService.getUpcomingMovies();
      topRatedMovies = MovieService.getTopRated();
      seasonalAnimes = MovieService.getSeasonalAnimesApi(limit: _limit);
    });
  }

  Future<void> _refresh() async {
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.black,
      backgroundColor: Colors.white,
      onRefresh: _refresh,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Trending',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildTrending(),
          const SizedBox(height: 16),
          const Text(
            'Upcoming',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
>>>>>>> parent of 8dfca63 (Implement Getx State and DarkMode theme):lib/movie_module/screens/all_screen/for_you.dart
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 380,
            child: FutureBuilder<UpcomingMovieModel>(
              future: upcomingMovies,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                      'Error Movie Reading: ${snapshot.error.toString()}');
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return _buildUpcoming(snapshot.data);
                } else {
                  return const ForYouSkeleton();
                }
              },
            ),
<<<<<<< HEAD:lib/movie_module/views/all_screen/for_you.dart
            const SizedBox(height: 16),
            Text(
              'TopRated',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color:
                    controller.isDarkMode.value ? Colors.white : Colors.black,
              ),
=======
          ),
          const SizedBox(height: 16),
          const Text(
            'TopRated',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
>>>>>>> parent of 8dfca63 (Implement Getx State and DarkMode theme):lib/movie_module/screens/all_screen/for_you.dart
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 350,
            child: FutureBuilder<TopRated>(
              future: topRatedMovies,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                      'Errror Movie Reading: ${snapshot.error.toString()}');
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return _buildTopRatedBody(snapshot.data);
                } else {
                  return const ForYouSkeleton();
                }
              },
            ),
<<<<<<< HEAD:lib/movie_module/views/all_screen/for_you.dart
            const SizedBox(height: 16),
            Text(
              'Anime',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color:
                    controller.isDarkMode.value ? Colors.white : Colors.black,
              ),
=======
          ),
          const SizedBox(height: 16),
          const Text(
            'Anime',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
>>>>>>> parent of 8dfca63 (Implement Getx State and DarkMode theme):lib/movie_module/screens/all_screen/for_you.dart
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 350,
            child: FutureBuilder<AnimeModel>(
              future: seasonalAnimes,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                      'Errror Movie Reading: ${snapshot.error.toString()}');
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return _buildAnimeBody(snapshot.data);
                } else {
                  return const ForYouSkeleton();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrending() {
    return FutureBuilder<MovieModel>(
      future: trendingMovie,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Failed to load movies: ${snapshot.error.toString()}');
        } else if (snapshot.connectionState == ConnectionState.done) {
          return CarouselSlider(
            options: CarouselOptions(
              height: 500,
              enlargeCenterPage: true,
            ),
            items: snapshot.data!.results.map(
              (movie) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailPage(movie),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: movie.posterPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              },
            ).toList(),
          );
        } else {
          return const TrendingSkeleton();
        }
      },
    );
  }

  Widget _buildUpcoming(UpcomingMovieModel? upcomingMovieModel) {
    if (upcomingMovieModel == null) {
      return const ForYouSkeleton();
    }
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: upcomingMovieModel.results!.length,
      itemBuilder: (context, index) {
        return _buildUpcomingItem(upcomingMovieModel.results![index]);
      },
    );
  }

  Widget _buildUpcomingItem(UpcomingResult item) {
    return SizedBox(
      width: 250,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpcomingDetailPage(item),
            ),
          );
        },
        child: Card(
          margin: const EdgeInsets.all(8),
          color:
              controller.isDarkMode.value ? Colors.transparent : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: item.posterPath!,
                    child: CachedNetworkImage(
                      imageUrl: item.posterPath!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(
                item.title.toString(),
<<<<<<< HEAD:lib/movie_module/views/all_screen/for_you.dart
                style: TextStyle(
                  fontSize: 16,
                  color:
                      controller.isDarkMode.value ? Colors.white : Colors.black,
=======
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
>>>>>>> parent of 8dfca63 (Implement Getx State and DarkMode theme):lib/movie_module/screens/all_screen/for_you.dart
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopRatedBody(TopRated? topRated) {
    if (topRated == null) {
      return const ForYouSkeleton();
    }
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: topRated.results!.length,
      itemBuilder: (context, index) {
        return _buildTopRatedItem(topRated.results![index]);
      },
    );
  }

  Widget _buildTopRatedItem(TopRatedResult item) {
    return SizedBox(
      width: 250,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TopRatedDetailPage(item),
            ),
          );
        },
        child: Card(
          margin: const EdgeInsets.all(8),
          color:
              controller.isDarkMode.value ? Colors.transparent : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: item.posterPath!,
                    child: CachedNetworkImage(
                      imageUrl: item.posterPath!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(
                item.title.toString(),
<<<<<<< HEAD:lib/movie_module/views/all_screen/for_you.dart
                style: TextStyle(
                  fontSize: 16,
                  color:
                      controller.isDarkMode.value ? Colors.white : Colors.black,
                ),
=======
                style: const TextStyle(fontSize: 18, color: Colors.white),
>>>>>>> parent of 8dfca63 (Implement Getx State and DarkMode theme):lib/movie_module/screens/all_screen/for_you.dart
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimeBody(AnimeModel? animeModel) {
    if (animeModel == null) {
      return const ForYouSkeleton();
    }
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: animeModel.data!.length,
      itemBuilder: (context, index) {
        return _buildAnimeItem(animeModel.data![index]);
      },
    );
  }

  Widget _buildAnimeItem(Datum item) {
    return SizedBox(
      width: 250,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnimeDetailPage(item),
            ),
          );
        },
        child: Card(
          margin: const EdgeInsets.all(8),
          color:
              controller.isDarkMode.value ? Colors.transparent : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: item.node!.mainPicture!,
                    child: CachedNetworkImage(
                      imageUrl: item.node!.mainPicture!.large.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(
                item.node!.title.toString(),
<<<<<<< HEAD:lib/movie_module/views/all_screen/for_you.dart
                style: TextStyle(
                  fontSize: 16,
                  color:
                      controller.isDarkMode.value ? Colors.white : Colors.black,
                ),
=======
                style: const TextStyle(fontSize: 18, color: Colors.white),
>>>>>>> parent of 8dfca63 (Implement Getx State and DarkMode theme):lib/movie_module/screens/all_screen/for_you.dart
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
