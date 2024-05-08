import 'dart:convert';

import 'package:dwatch/views/all_movie_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'movie_details_page.dart';

class MovieCategoryPage extends StatefulWidget {
  final String name;
  final int genreID;
  const MovieCategoryPage(
      {super.key, required this.name, required this.genreID});

  @override
  State<MovieCategoryPage> createState() => _AllMoviePageState();
}

class _AllMoviePageState extends State<MovieCategoryPage> {
  String apiKey = "0e88a6c1edff8a91aa8ff748abb98bb5";
  List<dynamic> movieCategoryList = [];
  int actorID = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=${widget.genreID}'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        if (mounted) {
          setState(() {
            movieCategoryList = jsonResponse['results'];
          });
        }
        setState(() {
          print(movieCategoryList);
        });
      } else {
        throw Exception('Cast list is empty or null');
      }
    } else {
      throw Exception('Empty or null response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070420),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: const Color(0xFF070420),
        title: Text(
          widget.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 5,
        ),
        itemCount: movieCategoryList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print("object");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => MovieDetailsPage(
                          movieID: movieCategoryList[index]['id'])));
            },
            child: CategoryMovieCards(
              movieImage: movieCategoryList[index]['poster_path'],
              movieID: movieCategoryList[index]['id'],
              movieName: movieCategoryList[index]['original_title'],
            ),
          );
        },
      ),
    );
  }
}
