// ignore_for_file: must_be_immutable
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movie_app/movie_module/models/tv_show_model.dart';

import '../../models/cast_movie_model.dart';
import '../../servies/movie_service.dart';
import '../../skeleton/cast_details.dart';

class TvShowDetailPage extends StatefulWidget {
  TvShowResult item;
  TvShowDetailPage(this.item, {super.key});

  @override
  State<TvShowDetailPage> createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  late Future<CastModel> futureCast;

  @override
  void initState() {
    super.initState();
    futureCast = MovieService.fetchSeriesCast(widget.item.id!);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.item.posterPath!),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                child: _buildBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                  backgroundColor: Colors.black.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Icon(
                  Iconsax.arrow_left_2,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Text(
                  widget.item.name!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: widget.item.posterPath!,
                    child: CachedNetworkImage(
                      imageUrl: widget.item.posterPath!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Original Title: ${widget.item.originalName}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        // overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Original Langugae: ${widget.item.originalLanguage}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Air Date: ${widget.item.firstAirDate}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'Rating: ',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 6, right: 6),
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Iconsax.star1,
                                  color: Colors.amber,
                                  size: 26,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.item.voteAverage!.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(
                    width: 1.5,
                    color: Color(0xFFe6e6dd),
                  ),
                ),
                child: const Text(
                  'Watch Trailer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Icon(
                  Iconsax.save_2,
                  color: Colors.white,
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Icon(
                  Iconsax.send_2,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(),

          // Overview
          const SizedBox(height: 16),
          const Text(
            'Overview',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            widget.item.overview!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.start,
          ),

          // Cast
          const SizedBox(height: 16),
          const Text(
            'Cast',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 250,
            child: FutureBuilder<CastModel>(
              future: futureCast,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                        ' Error Cast Reading: ${snapshot.error.toString()}'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  final castList = snapshot.data!.cast!;
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: castList.length,
                    itemBuilder: (context, index) {
                      return _buildCastTile(context, castList[index]);
                    },
                  );
                } else {
                  return const CastDetailsSkeleton();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCastTile(BuildContext context, Cast cast) {
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
              width: double.infinity,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: cast.profilePath != null
                    ? CachedNetworkImage(
                        imageUrl: cast.profilePath.toString(),
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl:
                            'https://archive.org/download/default_profile/default-avatar.png',
                      ),
              ),
            ),
            Text(
              cast.name.toString(),
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            const Text(
              'As',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              cast.character.toString(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
