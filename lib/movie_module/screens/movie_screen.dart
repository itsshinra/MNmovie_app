import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../models/movie_model.dart';
import '../servies/movie_service.dart';
import 'movie_detail_screen.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text(
            'N',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 238, 0, 0),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.search_normal),
            ),
            CircleAvatar(
              child: Image.network(
                'https://i.pinimg.com/736x/2c/9e/0f/2c9e0f0f72943eb8585a1c0ef9f44689.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            indicatorColor: Color.fromARGB(255, 238, 0, 0),
            labelColor: Colors.white,
            tabs: const [
              Tab(
                child: Text(
                  'For You',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  'Trending',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  'Movies',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  'TV Shows',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  'Recommend',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  'Anime',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _container(),
            _buildBody(),
            Container(
              color: Colors.blue,
            ),
            Container(
              color: Colors.green,
            ),
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.pink,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: FutureBuilder<MovieModel>(
        future: MovieService.getAPI(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error Movie Reading : ${snapshot.error.toString()}");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return _buildGridView(snapshot.data);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _container() {
    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          width: 300,
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://images-cdn.ubuy.co.id/6355c8013cefba3a8d6dc4e7-dune-movie-poster-27-x-40.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGridView(MovieModel? movieModel) {
    if (movieModel == null) {
      return const SizedBox();
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // mainAxisSpacing: 10,
        childAspectRatio: 1 / 1.5,
      ),
      itemCount: movieModel.results.length,
      itemBuilder: (context, index) {
        return _buildItem(movieModel.results[index]);
      },
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
        child: ListTile(
          title: Image.network(item.posterPath),
          subtitle: Text(
            item.titleOrName,
            style: const TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
