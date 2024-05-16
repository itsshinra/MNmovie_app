import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TrendingSkeleton extends StatelessWidget {
  const TrendingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SizedBox(
        height: 550,
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => DetailScreen(
                  //       movie: snapshot.data[index], // Removed 'const' from here
                  //     ),
                  //   ),
                  // );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://images-cdn.ubuy.co.id/633feb8bd279163476374ad1-japan-anime-manga-poster-jujutsu.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
