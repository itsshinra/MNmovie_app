import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  void changeTheme(bool isDark) {
    isDarkMode.value = isDark;
    Get.changeTheme(
      Get.isDarkMode
          ? ThemeData(
              fontFamily: 'Poppins',
              brightness: Brightness.light,
              appBarTheme: const AppBarTheme(
                foregroundColor: Colors.black,
              ),
              tabBarTheme: const TabBarTheme(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
              ),
              inputDecorationTheme: InputDecorationTheme(
                fillColor: Colors.white,
                filled: true,
              ),
              textTheme: const TextTheme(
                bodyMedium: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                bodyLarge: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                bodySmall: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          : ThemeData(
              fontFamily: 'Poppins',
              brightness: Brightness.dark,
              appBarTheme: const AppBarTheme(),
              tabBarTheme: const TabBarTheme(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.white),
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
