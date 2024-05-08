import 'dart:convert';

import 'package:dwatch/views/details_actor_view.dart';
import 'package:dwatch/views/movie_details/provider_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../views/home/home_genre_view.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieID;
  const MovieDetailsPage({super.key, required this.movieID});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  List<dynamic> movieDetailsList = [];
  List<dynamic> movieGenreList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    print(widget.movieID);
  }

  void fetchData() async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/${widget.movieID}?language=tr-tr'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZTg4YTZjMWVkZmY4YTkxYWE4ZmY3NDhhYmI5OGJiNSIsInN1YiI6IjYxNzg3Y2ExZjJjZjI1MDA2MTkzYjFjYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.beKrG7wS3yZQVXOpAebeUtBPvi9xNzT2oCLkzvG7CYI',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse != null) {
        if (mounted) {
          setState(() {
            movieDetailsList = [jsonResponse];
          });
          setState(() {
            movieGenreList = movieDetailsList[0]['genres'];
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
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/original${movieDetailsList[0]['backdrop_path']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 150,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/original${movieDetailsList[0]['poster_path']}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      const Text(
                        "Status",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        movieDetailsList[0]['status'],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      const Text(
                        "Revenue",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        movieDetailsList[0]['revenue'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      const Text(
                        "Release Date",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        movieDetailsList[0]['release_date'],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movieGenreList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: HomeGenreCard(
                      genreName: movieGenreList[index]['name'],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movieDetailsList[0]['original_title'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            movieDetailsList[0]['overview'] != ""
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      movieDetailsList[0]['overview'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Film Açıklama Bilgisi Bulunamadı",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
            SizedBox(height: 10),
            MovieTrailerWidget(),
            SizedBox(height: 10),
            WatchProviderWidget(),
            SizedBox(height: 10),
            MovieActorWidget(id: widget.movieID)
          ],
        ),
      ),
    );
  }
}

class WatchProviderWidget extends StatefulWidget {
  const WatchProviderWidget({super.key});

  @override
  State<WatchProviderWidget> createState() => _WatchProviderWidgetState();
}

class _WatchProviderWidgetState extends State<WatchProviderWidget> {
  List<dynamic> movieProviderList = [];

  void fetchProvider() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/1041613/watch/providers'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZTg4YTZjMWVkZmY4YTkxYWE4ZmY3NDhhYmI5OGJiNSIsInN1YiI6IjYxNzg3Y2ExZjJjZjI1MDA2MTkzYjFjYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.beKrG7wS3yZQVXOpAebeUtBPvi9xNzT2oCLkzvG7CYI',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          movieProviderList = jsonResponse['results']['AU']['rent'];
          print(movieProviderList);
        });
      } else {
        throw Exception('Empty or null response');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProvider();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: size.width,
        height: 240,
        color: Colors.black,
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              "Watch Provider",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            const SizedBox(height: 10),
            Container(
              height: 156,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movieProviderList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: MovieProvierCard(
                        provName: movieProviderList[index]['provider_name'],
                        provImage: movieProviderList[index]['logo_path'],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "From JustWatch",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieTrailerWidget extends StatefulWidget {
  const MovieTrailerWidget({super.key});

  @override
  State<MovieTrailerWidget> createState() => _MovieTrailerWidgetState();
}

class _MovieTrailerWidgetState extends State<MovieTrailerWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Trailer",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 200,
              width: size.width,
              color: Colors.black,
            )),
      ],
    );
  }
}

class MovieActorWidget extends StatefulWidget {
  final int id;
  const MovieActorWidget({super.key, required this.id});

  @override
  State<MovieActorWidget> createState() => _MovieActorWidgetState();
}

class _MovieActorWidgetState extends State<MovieActorWidget> {
  //
  List<dynamic> movieCreditList = [];
  int actorID = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/${widget.id}/credits'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZTg4YTZjMWVkZmY4YTkxYWE4ZmY3NDhhYmI5OGJiNSIsInN1YiI6IjYxNzg3Y2ExZjJjZjI1MDA2MTkzYjFjYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.beKrG7wS3yZQVXOpAebeUtBPvi9xNzT2oCLkzvG7CYI',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        var castList = jsonResponse['cast'];
        if (castList != null) {
          if (mounted) {
            setState(() {
              movieCreditList = castList;
            });
          }
        } else {
          throw Exception('Cast list is empty or null');
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
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Actors",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        movieCreditList.length != 0
            ? SizedBox(
                height: 175,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movieCreditList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:const EdgeInsets.all(5.0),
                      child: DetailsActorCard(
                        actorNames: movieCreditList[index]['name'],
                        actorImageURL: movieCreditList[index]['profile_path'],
                        actorID: movieCreditList[index]['id'],
                      ),
                    );
                  },
                ),
              )
            : const Center(
                child: Text(
                  "Oyuncular Bilgisi Bulunamadı",
                  style: TextStyle(color: Colors.white),
                ),
              )
      ],
    );
  }
}
