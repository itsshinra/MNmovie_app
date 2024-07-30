import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ForYouSkeleton extends StatefulWidget {
  const ForYouSkeleton({super.key});

  @override
  State<ForYouSkeleton> createState() => _ForYouSkeletonState();
}

class _ForYouSkeletonState extends State<ForYouSkeleton> {
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://images-cdn.ubuy.co.id/633feb8bd279163476374ad1-japan-anime-manga-poster-jujutsu.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Text(
                  'Jujutsu Kaisen 1',
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
