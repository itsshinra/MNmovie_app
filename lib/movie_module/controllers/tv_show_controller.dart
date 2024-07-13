import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/tv_show_model.dart';
import '../servies/movie_service.dart';

class TvShowController extends GetxController {
  var movies = <TvShowResult>[].obs;
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
    update();
    isLoading.value = true;

    try {
      TvShow movieModel = await MovieService.getTvShow(page: currentPage.value);
      if (movieModel.results!.isNotEmpty) {
        update();
        currentPage.value++;
        movies.addAll(movieModel.results!);
      } else {
        hasMore.value = false;
      }
    } catch (e) {
      log("Error fetching movies: $e");
    } finally {
      update();
      isLoading.value = false;
    }
  }
}
