import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../servies/movie_service.dart';
import '../skeleton/movie_skeloton.dart';
import 'screens_detail/movie_detail_screen.dart';

class TvShowScreen extends StatefulWidget {
  const TvShowScreen({super.key});

  @override
  State<TvShowScreen> createState() => _TvShowScreenState();
}

class _TvShowScreenState extends State<TvShowScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Result> _movies = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

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
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
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
      final movieModel = await MovieService.getTvShow(page: _currentPage);
      setState(() {
        _movies.addAll(movieModel.results);
        _currentPage++;
        _hasMore = movieModel.results.isNotEmpty;
      });
    } catch (error) {
      // Handle error here
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: _movies.isEmpty && _isLoading
          ? const MovieSkeleton()
          : _buildGridView(),
    );
  }

  Widget _buildGridView() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.7,
        ),
        itemCount: _movies.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _movies.length) {
            return Center(child: CircularProgressIndicator());
          }
          return _buildItem(_movies[index]);
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
