import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../views/search_movie_card.dart';

class SearchPage extends StatefulWidget {
  final String searchText;
  const SearchPage({super.key, required this.searchText});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchURL = "";
  late List<dynamic> searchData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      searchURL =
          "https://api.themoviedb.org/3/search/movie?query=${widget.searchText}&include_adult=false&language=tr-tr&page=1";
    });
    fetchSearchData();
  }

  void fetchSearchData() async {
    final response = await http.get(
      Uri.parse(searchURL),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZTg4YTZjMWVkZmY4YTkxYWE4ZmY3NDhhYmI5OGJiNSIsInN1YiI6IjYxNzg3Y2ExZjJjZjI1MDA2MTkzYjFjYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.beKrG7wS3yZQVXOpAebeUtBPvi9xNzT2oCLkzvG7CYI',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        if (mounted) {
          setState(() {
            searchData = jsonResponse['results'];
          });
        }
      } else {
        throw Exception('Empty or null response');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF070420),
      appBar: AppBar(
        backgroundColor: Color(0xFF070420),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          widget.searchText,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Movies",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // İzgara sütun sayısı
                  crossAxisSpacing: 1, // Sütunlar arası boşluk
                  mainAxisSpacing: 5, // Satırlar arası boşluk
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return SearchMovieCard(
                    movieImage: searchData[index]['poster_path'],
                    movieName: searchData[index]['original_title'],
                    movieID: searchData[index]['id'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
