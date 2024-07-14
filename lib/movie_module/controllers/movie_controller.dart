// ignore_for_file: prefer_final_fields

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/movie_module/servies/movie_service.dart';

import '../models/movie_model.dart';

class MovieController extends GetxController {
  var movies = <Result>[].obs;
  var currentPage = 1.obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
    scrollController.addListener(onScroll);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.9 &&
        !isLoading.value &&
        hasMore.value) {
      fetchMovies();
    }
  }

  Future<void> fetchMovies() async {
    isLoading.value = true;

    try {
      MovieModel newMovies =
          await MovieService.getMovies(page: currentPage.value);
      if (newMovies.results.isNotEmpty) {
        update();
        currentPage.value++;
        movies.addAll(newMovies.results);
      } else {
        hasMore.value = false;
      }
    } catch (e) {
      log('Error fetching movies: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
