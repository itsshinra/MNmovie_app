import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MovieSkeleton extends StatelessWidget {
  const MovieSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // mainAxisSpacing: 10,
          childAspectRatio: 1 / 1.7,
        ),
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://images-cdn.ubuy.co.id/633feb8bd279163476374ad1-japan-anime-manga-poster-jujutsu.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                const Text(
                  'Godzill x Kong: The New Empire',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
