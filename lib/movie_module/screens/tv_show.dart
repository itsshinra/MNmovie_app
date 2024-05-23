import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/movie_module/screens/screens_detail/tv_show_detail_screen.dart';
import '../models/movie_model.dart';
import '../servies/movie_service.dart';
import '../skeleton/movie_skeloton.dart';

class TvShowScreen extends StatefulWidget {
  const TvShowScreen({super.key});

  @override
  State<TvShowScreen> createState() => _TvShowScreenState();
}

class _TvShowScreenState extends State<TvShowScreen> {
  List<Result> _movies = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchMovies();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.9 &&
        !_isLoading &&
        _hasMore) {
      _fetchMovies();
    }
  }

  Future<void> _fetchMovies() async {
    setState(() {
      _isLoading = true;
    });

    try {
      MovieModel movieModel = await MovieService.getTvShow(page: _currentPage);
      setState(() {
        _currentPage++;
        _movies.addAll(movieModel.results);
        _hasMore = movieModel.results.isNotEmpty;
      });
    } catch (e) {
      log("Error fetching movies: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Center(
      child: _isLoading && _movies.isEmpty
          ? const MovieSkeleton()
          : RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              color: Colors.black,
              backgroundColor: Colors.white,
              onRefresh: () async {
                setState(() {
                  _movies.clear();
                  _currentPage = 1;
                  _hasMore = true;
                });
                await _fetchMovies();
              },
              child: GridView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.7,
                ),
                itemCount: _movies.length + (_hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _movies.length) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return _buildItem(_movies[index]);
                },
              ),
            ),
    );
  }

  Widget _buildItem(Result item) {
    return InkWell(
      onTap: () {
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
