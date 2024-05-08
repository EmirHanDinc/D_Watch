import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../views/home/home_movie_view.dart';
import 'movie_details_page.dart';

class UpComingMoviesPage extends StatefulWidget {
  const UpComingMoviesPage({super.key});

  @override
  State<UpComingMoviesPage> createState() => _UpComingMoviesPageState();
}

class _UpComingMoviesPageState extends State<UpComingMoviesPage> {
  List<dynamic> upComingMovieList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/upcoming'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZTg4YTZjMWVkZmY4YTkxYWE4ZmY3NDhhYmI5OGJiNSIsInN1YiI6IjYxNzg3Y2ExZjJjZjI1MDA2MTkzYjFjYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.beKrG7wS3yZQVXOpAebeUtBPvi9xNzT2oCLkzvG7CYI',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        var jsonResponse = json.decode(response.body);
        upComingMovieList = jsonResponse['results'];
      });
    } else {
      throw Exception('Failed to load data');
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
        title: const Text(
          "UpComing Movies",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 5,
        ),
        itemCount: upComingMovieList.length,
        itemBuilder: (context, index) {
          return HomeMovieCard(
            moviePosterURL: upComingMovieList[index]['poster_path'],
          );
        },
      ),
    );
  }
}
