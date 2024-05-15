import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movie_app/movie_module/screens/top_rated_screen.dart';
import 'package:movie_app/movie_module/screens/tv_show.dart';
import '../models/movie_model.dart';
import '../servies/movie_service.dart';
import 'for_you.dart';
import 'screens_detail/movie_detail_screen.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
            SizedBox(
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  'https://i.pinimg.com/736x/2c/9e/0f/2c9e0f0f72943eb8585a1c0ef9f44689.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
          bottom: TabBar(
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            indicatorColor: const Color.fromARGB(255, 238, 0, 0),
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
                  'Top Rated',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const ForYou(),
            _buildBody(),
            const TvShowScreen(),
            const TopRatedScreen(),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: FutureBuilder<MovieModel>(
        future: MovieService.getMovies(),
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

  Widget _buildGridView(MovieModel? movieModel) {
    if (movieModel == null) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // mainAxisSpacing: 10,
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
        // child: ListTile(
        //   title: Image.network(item.posterPath),
        //   subtitle: Text(
        //     item.titleOrName,
        //     style: const TextStyle(
        //       fontSize: 20,
        //     ),
        //     textAlign: TextAlign.center,
        //   ),
        // ),
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
