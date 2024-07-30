import 'package:flutter/material.dart';
import 'package:movie_app/movie_module/home_screen.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Fang',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        fontFamily: 'Poppins',
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
