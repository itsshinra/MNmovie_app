import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/movie_module/controllers/tv_show_controller.dart';
import 'package:movie_app/movie_module/views/screens_detail/tv_show_detail_screen.dart';
import '../../models/tv_show_model.dart';
import '../../skeleton/movie_skeloton.dart';

class TvShowScreen extends StatefulWidget {
  const TvShowScreen({super.key});

  @override
  State<TvShowScreen> createState() => _TvShowScreenState();
}

class _TvShowScreenState extends State<TvShowScreen> {
  final _controller = Get.put(TvShowController());

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
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                color: Colors.black,
                backgroundColor: Colors.white,
                onRefresh: () async {
                  setState(() {
                    _controller.movies.clear();
                    _controller.currentPage.value = 1;
                    _controller.hasMore.value = true;
                  });
                  await _controller.fetchMovies();
                },
                child: GridView.builder(
                  controller: _controller.scrollController,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.7,
                  ),
                  itemCount: _controller.movies.length +
                      (_controller.hasMore.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _controller.movies.length) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return _buildItem(_controller.movies[index]);
                  },
                ),
              ),
      ),
    );
  }

  Widget _buildItem(TvShowResult item) {
    return InkWell(
      onTap: () {
        debugPrint(item.id.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TvShowDetailPage(item),
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
                tag: item.posterPath!,
                child: CachedNetworkImage(
                  imageUrl: item.posterPath!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              item.name!,
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
