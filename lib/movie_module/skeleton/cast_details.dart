import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CastDetailsSkeleton extends StatefulWidget {
  const CastDetailsSkeleton({super.key});

  @override
  State<CastDetailsSkeleton> createState() => _CastDetailsSkeletonState();
}

class _CastDetailsSkeletonState extends State<CastDetailsSkeleton> {
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            shadowColor: Colors.transparent,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 250,
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
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                const Text(
                  'Jujutsu Kaisen 1',
                  style: TextStyle(fontSize: 16),
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
