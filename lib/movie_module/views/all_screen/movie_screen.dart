import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/movie_module/controllers/movie_controller.dart';
import '../../models/movie_model.dart';
import '../../skeleton/movie_skeloton.dart';
import '../screens_detail/movie_detail_screen.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  // ignore: prefer_final_fields
  // List<Result> _movies = [];
  // int _currentPage = 1;
  // bool _isLoading = false;
  // bool _hasMore = true;
  // final ScrollController _scrollController = ScrollController();

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchMovies();
  //   _scrollController.addListener(_onScroll);
  // }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  // void _onScroll() {
  //   if (_scrollController.position.pixels >=
  //           _scrollController.position.maxScrollExtent * 0.9 &&
  //       !_isLoading &&
  //       _hasMore) {
  //     _fetchMovies();
  //   }
  // }

  // Future<void> _fetchMovies() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     MovieModel newMovies = await MovieService.getMovies(page: _currentPage);
  //     setState(() {
  //       _currentPage++;
  //       _movies.addAll(newMovies.results);
  //       _hasMore = newMovies.results.isNotEmpty;
  //     });
  //   } catch (e) {
  //     log("Error fetching movies: $e");
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
  final _controller = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Obx(
      () => Center(
        child: _controller.isLoading.value && _controller.movies.isEmpty
            ? const MovieSkeleton()
            : RefreshIndicator(
                color: Colors.black,
                backgroundColor: Colors.white,
                onRefresh: () async {
                  setState(() {
                    _controller.movies.clear();
                    _controller.currentPage.value = 1;
                    _controller.hasMore.value = true;
                  });
                  await _controller.fetchMovies;
                },
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _controller.scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.7,
                  ),
                  itemCount: _controller.movies.length +
                      (_controller.hasMore.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _controller.movies.length) {
                      return const SizedBox();
                    }
                    return _buildItem(_controller.movies[index]);
                  },
                ),
              ),
      ),
    );
  }

  Widget _buildItem(Result item) {
    return InkWell(
      onTap: () {
        debugPrint('Movie ID: ${item.id}');
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Hero(
                tag: item.posterPath,
                child: CachedNetworkImage(
                  imageUrl: item.posterPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              item.titleOrName,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
