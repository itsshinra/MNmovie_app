import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/movie_module/models/movie_model.dart';
import 'package:movie_app/movie_module/models/tv_show_model.dart';
import 'package:movie_app/movie_module/screens/screens_detail/movie_detail_screen.dart';
import 'package:movie_app/movie_module/screens/screens_detail/tv_show_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];
  Timer? _debounce;

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults.clear();
      });
      return;
    }

    final String apiUrl =
        'https://api.themoviedb.org/3/search/multi?include_adult=true&query=$query';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZjFmYmQ1MDhiM2Y4Njk4ZWIxNzUxYTJhNGRmZTk4ZiIsInN1YiI6IjY1Y2Q3ZmJjODdmM2YyMDE3YmY0ODVmYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1tGroYT26mFHm3VzxJx6XH2kwJf_IT6-ugrgHFrydlQ',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        searchResults = data['results'];
      });
    } else {
      throw Exception('Failed to load search results');
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          searchResults.clear();
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Iconsax.arrow_left_2),
        ),
        title: const Text(
          'Search your Movies',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              autofocus: true,
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 238, 0, 0),
                    width: 1.1,
                  ),
                ),
                labelText: 'Search here...',
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade500,
                ),
                fillColor: Colors.grey.shade700,
                filled: true,
                suffixIcon: IconButton(
                  icon: const Icon(Iconsax.search_normal_1),
                  onPressed: () {
                    _performSearch(_searchController.text);
                  },
                ),
              ),
              onChanged: _onSearchChanged,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final result = searchResults[index];
                  return Card(
                    color: Colors.grey.shade800,
                    child: ListTile(
                      onTap: () {
                        if (result['media_type'] == 'movie') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailPage(Result.fromMap(result)),
                            ),
                          );
                        } else if (result['media_type'] == 'tv') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TvShowDetailPage(
                                  TvShowResult.fromMap(result)),
                            ),
                          );
                        }
                      },
                      leading: result['poster_path'] != null
                          ? SizedBox(
                              width: 50,
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w92${result['poster_path']}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      title: Text(
                        result['name'] ?? result['title'] ?? 'N/A',
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        result['overview'] ?? 'N/A',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
