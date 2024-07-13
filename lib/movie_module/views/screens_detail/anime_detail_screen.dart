// ignore_for_file: must_be_immutable
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movie_app/movie_module/models/anime_detail_model.dart';
import 'package:movie_app/movie_module/models/anime_model.dart';
import '../../servies/movie_service.dart';

class AnimeDetailPage extends StatefulWidget {
  Datum item;
  AnimeDetailPage(this.item, {super.key});

  @override
  State<AnimeDetailPage> createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  late Future<AnimeDetailModel> animeDetail;

  @override
  void initState() {
    super.initState();
    animeDetail = MovieService.getAnimeDetails(widget.item.node!.id!);
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
            image:
                NetworkImage(widget.item.node!.mainPicture!.large.toString()),
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
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                child: FutureBuilder<AnimeDetailModel>(
                  future: animeDetail,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData) {
                      return const Center(child: Text('No data available'));
                    } else {
                      AnimeDetailModel item = snapshot.data!;
                      return _buildBody(context, item);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, AnimeDetailModel item) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildAppBar(context),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster
              SizedBox(
                width: 150,
                height: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: widget.item.node!.mainPicture!,
                    child: CachedNetworkImage(
                      imageUrl: widget.item.node!.mainPicture!.large.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // title, date, status, rating, genre, studio
              _buildDetail(item),
            ],
          ),

          // Rating and Release date
          const SizedBox(height: 32),
          _buildButtons(),
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
            item.synopsis ?? 'N/A',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.start,
          ),

          // Recommendations
          const SizedBox(height: 32),
          const Text(
            'Recommendations',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          _buildRecommend(item),
        ],
      ),
    );
  }

  Widget _buildDetail(AnimeDetailModel item) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Original Title: ${widget.item.node!.title}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Release Date:  ${item.dateOnly}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Status:  ${item.status ?? 'N/A'}",
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
                  padding: const EdgeInsets.only(left: 6, right: 11),
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
                      ),
                      const SizedBox(width: 5),
                      Text(
                        item.rating ?? "N/A",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text(
                  'Genre: ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    item.genres?.isNotEmpty ?? false
                        ? item.genres!.map((genre) => genre.name).join(', ')
                        : 'N/A',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Studio:  ${item.studios?.isNotEmpty ?? false ? item.studios!.first.name : 'N/A'}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Media Type:  ${item.mediaType?.isNotEmpty ?? false ? item.mediaType! : 'N/A'}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
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
            widget.item.node!.title.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
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
    );
  }

  Widget _buildRecommend(AnimeDetailModel item) {
    return SizedBox(
      height: 200,
      child: item.recommendations?.isNotEmpty ?? false
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: item.recommendations?.length ?? 0,
              itemBuilder: (context, index) {
                var recommendation = item.recommendations![index];
                return Container(
                  width: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: recommendation.node!.mainPicture!.large!,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 150,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        recommendation.node!.title!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            )
          : const Center(
              child: Text(
                'No recommendations available',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
