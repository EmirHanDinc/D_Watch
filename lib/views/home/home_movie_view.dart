import 'package:flutter/material.dart';

class HomeMovieCard extends StatelessWidget {
  final String moviePosterURL;
  const HomeMovieCard({super.key, required this.moviePosterURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          "https://image.tmdb.org/t/p/original$moviePosterURL",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
