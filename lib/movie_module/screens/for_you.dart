import 'package:flutter/material.dart';
import 'package:movie_app/movie_module/models/movie_model.dart';
import 'package:movie_app/movie_module/servies/movie_service.dart';

class ForYou extends StatefulWidget {
  const ForYou({super.key});

  @override
  State<ForYou> createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> {
  @override
  Widget build(BuildContext context) {
    return ListView(
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

        // Anime
        const Text(
          'Anime',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
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
            return const CircularProgressIndicator();
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
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => DetailScreen(
            //       movie: snapshot.data[index], // Removed 'const' from here
            //     ),
            //   ),
            // );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              '${item.posterPath}',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
  // Trending end

  // Anime body
}
