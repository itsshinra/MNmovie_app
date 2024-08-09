import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax/iconsax.dart';

class MyListScreen extends StatefulWidget {
  const MyListScreen({super.key});

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  List<dynamic> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(context),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: 6,
        itemBuilder: (context, index) {
          return _buildItemCard();
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Iconsax.arrow_left_2),
      ),
      title: const Text(
        'My List',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildItemCard() {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(10),
            onPressed: (context) {},
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Iconsax.trash,
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
        shadowColor: Colors.white.withOpacity(0.11),
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: InkWell(
            onTap: () {
              // final route = result['media_type'] == 'movie'
              //     ? MaterialPageRoute(
              //         builder: (context) => MovieDetailPage(
              //           Result.fromMap(
              //             result,
              //           ),
              //         ),
              //       )
              //     : MaterialPageRoute(
              //         builder: (context) =>
              //             TvShowDetailPage(TvShowResult.fromMap(result)));
              // Navigator.push(context, route);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://m.media-amazon.com/images/M/MV5BYTY2ZjYyNGUtZGVkZS00MDNhLWIwMjMtZDk4MmQ5ZWI0NTY4XkEyXkFqcGdeQXVyMTY3MDE5MDY1._V1_.jpg",
                    // 'https://image.tmdb.org/t/p/w500${result['poster_path']}',
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "The Boys Season 3",
                        // result['name'] ?? result['title'] ?? 'N/A',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "A group of vigilantes set out to take down corrupt superheroes who abuse their superpowers.",
                        // result['overview'] ?? 'N/A',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "TV Series",
                        // 'Media Type: ${result['media_type']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Text(
                            'Rating: ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            height: 20,
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 5,
                              children: [
                                Icon(
                                  Iconsax.star1,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                                Text("8.7"
                                    // result['vote_average'].toStringAsFixed(1),
                                    ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// // List Movie results
// Widget _buildListResult() {
//   return Expanded(
//     child: ListView.builder(
//       physics: const BouncingScrollPhysics(),
//       keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//       itemCount: searchResults.length,
//       itemBuilder: (context, index) {
//         final result = searchResults[index];
//         return ;
//       },
//     ),
//   );
// }
}
