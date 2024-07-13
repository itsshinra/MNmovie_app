import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movie_app/movie_module/views/all_screen/movie_screen.dart';
import 'package:movie_app/movie_module/views/all_screen/profile_screen.dart';
import 'package:movie_app/movie_module/views/all_screen/wistlist_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'views/all_screen/for_you.dart';
import 'views/all_screen/search_screen.dart';
import 'views/all_screen/tv_show.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          // foregroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.bottomToTop,
                  duration: const Duration(milliseconds: 450),
                  reverseDuration: const Duration(milliseconds: 300),
                  child: const ProfileScreen(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFe6e6dd),
                    width: 2,
                  ),
                ),
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/logos/me.1.JPG'),
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 300),
                    child: const SearchScreen(),
                  ),
                );
              },
              icon: const Icon(Iconsax.search_normal_1),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.topToBottom,
                    duration: const Duration(milliseconds: 450),
                    reverseDuration: const Duration(milliseconds: 300),
                    child: const MyListScreen(),
                  ),
                );
              },
              icon: const Icon(Iconsax.save_2),
            ),
          ],
          bottom: const TabBar(
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            tabs: [
              Tab(
                child: Text(
                  'For You',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  'Movies',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  'TV Shows',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            ForYou(),
            MovieScreen(),
            TvShowScreen(),
          ],
        ),
      ),
    );
  }
}
