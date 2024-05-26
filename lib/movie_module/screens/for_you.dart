import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/movie_module/models/anime_model.dart';
import 'package:movie_app/movie_module/models/movie_model.dart';
import 'package:movie_app/movie_module/models/top_rated_model.dart';
import 'package:movie_app/movie_module/models/upcoming_movie_model.dart';
import 'package:movie_app/movie_module/screens/screens_detail/anime_detail_screen.dart';
import 'package:movie_app/movie_module/screens/screens_detail/movie_detail_screen.dart';
import 'package:movie_app/movie_module/servies/movie_service.dart';
import '../skeleton/for_you_skeleton.dart';
import '../skeleton/trending_skeleton.dart';

class ForYou extends StatefulWidget {
  const ForYou({super.key});

  @override
  State<ForYou> createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> {
  late Future<MovieModel> trendingMovie;
  final int _limit = 50;

  @override
  void initState() {
    super.initState();
    trendingMovie = MovieService.getTrendingMovies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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

        // Trending Movies
        const SizedBox(height: 16),
        _buildTrending(),
        const SizedBox(height: 16),

        // Upcoming Movies
        const Text(
          'Upcoming',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),

        const SizedBox(height: 16),
        SizedBox(
          height: 380,
          child: FutureBuilder<UpcomingMovieModel>(
            future: MovieService.getUpcomingMovies(),
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
        ),
        const SizedBox(height: 16),

        // TopRated
        const Text(
          'TopRated',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 350,
          child: FutureBuilder<TopRated>(
            future: MovieService.getTopRated(),
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
        ),

        // Anime
        const SizedBox(height: 16),
        const Text(
          'Anime',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 350,
          child: FutureBuilder<AnimeModel>(
            future: MovieService.getSeasonalAnimesApi(limit: _limit),
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
    );
  }

  // Trending body
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
            items: snapshot.data!.results.map((movie) {
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
                      child: Image.network(
                        movie.posterPath,
                        fit: BoxFit.cover,
                        width: 1000,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        } else {
          return const TrendingSkeleton();
        }
      },
    );
  }
  // Trending end

  // _upcoming body
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
      width: MediaQuery.sizeOf(context).width * 0.55,
      child: Card(
        margin: const EdgeInsets.all(8),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  item.posterPath!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              item.title.toString(),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
  // Upcoming end

  // TopRated body
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
      width: MediaQuery.sizeOf(context).width * 0.55,
      child: Card(
        margin: const EdgeInsets.all(8),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  item.posterPath!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              item.title.toString(),
              style: const TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
  // TopRated end

  // anime body
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
      width: MediaQuery.sizeOf(context).width * 0.55,
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
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    item.node!.mainPicture!.medium.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                item.node!.title.toString(),
                style: const TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
  // anime end
}
