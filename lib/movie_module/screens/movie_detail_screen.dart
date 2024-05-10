// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/movie_model.dart';

class MovieDetailPage extends StatefulWidget {
  Result item;
  MovieDetailPage(this.item, {super.key});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          title: Text(widget.item.titleOrName),
          centerTitle: true,
          bottom: TabBar(
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            indicatorColor: const Color.fromARGB(255, 238, 0, 0),
            labelColor: Colors.white,
            tabs: const [
              Tab(
                child: Text(
                  'About',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  'Reviews',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildBody(),
            Container(color: Colors.transparent),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.item.posterPath,
                  fit: BoxFit.cover,
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
                      'Original Title: ${widget.item.originalTitle}',
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
                      "Release Date: ${widget.item.dateOnly}",
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
                        RatingBar(
                          itemSize: 24,
                          allowHalfRating: true,
                          initialRating: widget.item.voteAverage / 2,
                          itemCount: 1,
                          ratingWidget: RatingWidget(
                            full: const Icon(
                              Icons.star_rounded,
                              color: Colors.yellow,
                            ),
                            half: const Icon(
                              Icons.star_half_rounded,
                              color: Colors.orange,
                            ),
                            empty: const Icon(
                              Icons.star_border_rounded,
                              color: Colors.white,
                            ),
                          ),
                          onRatingUpdate: (double value) {},
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.item.voteAverage.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
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

        // Rating and Release date
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: const BorderSide(
                  color: Colors.red,
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
                Icons.add,
                color: Colors.white,
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              child: Platform.isAndroid
                  ? const Icon(
                      Icons.share,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.ios_share_rounded,
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
          widget.item.overview,
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
      ],
    );
  }
}
