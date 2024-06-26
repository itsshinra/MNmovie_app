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
          return SizedBox(
            width: 150,
            height: 300,
            child: Card(
              shadowColor: Colors.transparent,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        'https://archive.org/download/default_profile/default-avatar.png',
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
                    'As',
                    style: TextStyle(fontSize: 16),
                  ),
                  const Text(
                    'Jujutsu Kaisen 1',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
