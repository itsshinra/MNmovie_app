import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../servies/movie_service.dart';
import 'screens_detail/movie_detail_screen.dart';

class TopRatedScreen extends StatefulWidget {
  const TopRatedScreen({super.key});

  @override
  State<TopRatedScreen> createState() => _TopRatedScreenState();
}

class _TopRatedScreenState extends State<TopRatedScreen> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Center(
      child: FutureBuilder<MovieModel>(
        future: MovieService.getTopRated(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error Movie Reading : ${snapshot.error.toString()}");
          } else if (snapshot.connectionState == ConnectionState.done) {
            return _buildGridView(snapshot.data);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _buildGridView(MovieModel? movieModel) {
    if (movieModel == null) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.7,
        ),
        itemCount: movieModel.results.length,
        itemBuilder: (context, index) {
          return _buildItem(movieModel.results[index]);
        },
      ),
    );
  }

  Widget _buildItem(Result item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailPage(item),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                item.posterPath,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              item.titleOrName,
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
}
