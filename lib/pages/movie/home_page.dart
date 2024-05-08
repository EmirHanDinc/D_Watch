import 'dart:convert';

import 'package:dwatch/pages/movie/movie_details_page.dart';
import 'package:dwatch/pages/movie/movie_category_page.dart';
import 'package:dwatch/pages/movie/search_page.dart';
import 'package:dwatch/pages/movie/upcoming_movies_page.dart';
import 'package:dwatch/views/home/home_genre_view.dart';
import 'package:dwatch/views/home/home_movie_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF070420)),
              child: Center(
                child: Text(
                  "Drawer",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ListTile(
              title: const Text('Movies'),
              leading: const Icon(Icons.movie),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Series'),
              leading: const Icon(Icons.local_movies),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Bookmarks'),
              leading: const Icon(Icons.bookmark),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Film Dizi AI'),
              leading: const Icon(Icons.settings_suggest),
              onTap: () {},
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF070420),
      appBar: AppBar(
        backgroundColor: Color(0xFF070420),
        title: const Text(
          "D Watch",
          style: TextStyle(color: Colors.white),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SearchBarWidget(),
            SizedBox(height: 8),
            GenreWidget(),
            SizedBox(height: 8),
            UpComingMovieWidget(),
            SizedBox(height: 8),
            PopularMovieWidget(),
            SizedBox(height: 8),
            LatestMovieWidget(),
            SizedBox(height: 8),
            TopRatedMovieWidget(),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Find a Movie',
              suffixIcon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SearchPage(
                        searchText: searchController.text,
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PopularMovieWidget extends StatefulWidget {
  const PopularMovieWidget({super.key});

  @override
  State<PopularMovieWidget> createState() => _PopularMovieWidgetState();
}

class _PopularMovieWidgetState extends State<PopularMovieWidget> {
  List<dynamic> popularMovieList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/popular'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZTg4YTZjMWVkZmY4YTkxYWE4ZmY3NDhhYmI5OGJiNSIsInN1YiI6IjYxNzg3Y2ExZjJjZjI1MDA2MTkzYjFjYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.beKrG7wS3yZQVXOpAebeUtBPvi9xNzT2oCLkzvG7CYI',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        var jsonResponse = json.decode(response.body);
        popularMovieList = jsonResponse['results'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Popular Movies",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    fetchData();
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MovieDetailsPage(
                                  movieID: popularMovieList[index]['id'],
                                )));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: HomeMovieCard(
                      moviePosterURL: popularMovieList[index]['poster_path'],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GenreWidget extends StatefulWidget {
  const GenreWidget({super.key});

  @override
  State<GenreWidget> createState() => _GenreWidget2State();
}

class _GenreWidget2State extends State<GenreWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  List<dynamic> genreList = [];

  void fetchData() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/genre/movie/list?language=tr'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZTg4YTZjMWVkZmY4YTkxYWE4ZmY3NDhhYmI5OGJiNSIsInN1YiI6IjYxNzg3Y2ExZjJjZjI1MDA2MTkzYjFjYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.beKrG7wS3yZQVXOpAebeUtBPvi9xNzT2oCLkzvG7CYI',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        var jsonResponse = json.decode(response.body);
        genreList = jsonResponse['genres'];
      });
      print(genreList);
    } else {
      // Başarısız yanıt durumunda hata göster
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Genres",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: genreList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieCategoryPage(
                            name: genreList[index]['name'],
                            genreID: genreList[index]['id'],
                          ),
                        ),
                      );
                    },
                    child: HomeGenreCard(
                      genreName: genreList[index]['name'],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LatestMovieWidget extends StatelessWidget {
  const LatestMovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Latest Movies",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: HomeMovieCard(
                      moviePosterURL: '/fdZpvODTX5wwkD0ikZNaClE4AoW.jpg',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UpComingMovieWidget extends StatefulWidget {
  const UpComingMovieWidget({super.key});

  @override
  State<UpComingMovieWidget> createState() => _UpComingMovieWidgetState();
}

class _UpComingMovieWidgetState extends State<UpComingMovieWidget> {
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
      // Başarısız yanıt durumunda hata göster
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Upcoming Movies",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => UpComingMoviesPage()));
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MovieDetailsPage(
                                  movieID: upComingMovieList[index]['id'],
                                )));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: HomeMovieCard(
                      moviePosterURL: upComingMovieList[index]['poster_path'],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TopRatedMovieWidget extends StatelessWidget {
  const TopRatedMovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Rated Movies",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: HomeMovieCard(
                      moviePosterURL: '/fdZpvODTX5wwkD0ikZNaClE4AoW.jpg',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
