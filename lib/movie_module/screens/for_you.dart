import 'package:flutter/material.dart';
import 'package:movie_app/movie_module/models/movie_model.dart';
import 'package:movie_app/movie_module/models/upcoming_movie_model.dart';
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
  UpcomingResult? _model;

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
        _buildBody(),
        const SizedBox(height: 16),

        // Upcoming Movies
        const Text(
          'Upcoming Movies',
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
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://images-cdn.ubuy.co.id/633feb8bd279163476374ad1-japan-anime-manga-poster-jujutsu.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Trending body
  Widget _buildBody() {
    return Center(
      child: FutureBuilder<MovieModel>(
        future: MovieService.getTrendingMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error Movie Reading : ${snapshot.error.toString()}");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return _buildListView(snapshot.data);
          } else {
            return const TrendingSkeleton();
          }
        },
      ),
    );
  }

  Widget _buildListView(MovieModel? movieModel) {
    if (movieModel == null) {
      return const SizedBox();
    }
    return SizedBox(
      height: 550,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: movieModel.results.length,
        itemBuilder: (context, index) {
          return _buildMovieSlider(movieModel.results[index]);
        },
      ),
    );
  }

  Widget _buildMovieSlider(Result item) {
    return SizedBox(
      height: 550,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailPage(item),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.posterPath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
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
    return Card(
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
    );
  }
  // Upcoming end
}
