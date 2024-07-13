import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/movie_module/home_screen.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Movie Fang',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
