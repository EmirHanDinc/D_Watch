import '../pages/movie/movie_details_page.dart';
import 'package:flutter/material.dart';

class SearchMovieCard extends StatelessWidget {
  final String? movieImage;
  final String movieName;
  final int movieID;
  const SearchMovieCard(
      {super.key,
      required this.movieImage,
      required this.movieName,
      required this.movieID});

  @override
  Widget build(BuildContext context) {
    String moviePosterUrl = "https://image.tmdb.org/t/p/original$movieImage";
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailsPage(
              movieID: movieID,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(),
              image: DecorationImage(
                image: moviePosterUrl !=
                        "https://image.tmdb.org/t/p/originalnull"
                    ? NetworkImage(moviePosterUrl)
                    : const NetworkImage(
                        "https://static.thenounproject.com/png/4595376-200.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 5,
            child: movieName != null
                ? Text(
                    movieName,
                    style: const TextStyle(color: Colors.white),
                  )
                : const Text(
                    "movieName",
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ],
      ),
    );
  }
}
