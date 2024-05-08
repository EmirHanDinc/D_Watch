import 'package:dwatch/pages/movie/movie_details_page.dart';
import 'package:flutter/material.dart';

class CategoryMovieCards extends StatelessWidget {
  final String movieImage;
  final int movieID;
  final String movieName;
  const CategoryMovieCards(
      {super.key,
      required this.movieImage,
      required this.movieID,
      required this.movieName});

  @override
  Widget build(BuildContext context) {
    String moviePosterUrl =
        "https://image.tmdb.org/t/p/original/4lhR4L2vzzjl68P1zJyCH755Oz4.jpg";
    String movieBaseURL = "https://image.tmdb.org/t/p/original$movieImage";
    return GestureDetector(
      onTap: () {
        print("object1");
      },
      child: Stack(
        children: [
          movieImage != ""
              ? Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    image: DecorationImage(
                      image: NetworkImage(movieBaseURL),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    image: DecorationImage(
                      image: NetworkImage(moviePosterUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          Positioned(
            bottom: 5,
            left: 5,
            child: Text(
              movieName,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
