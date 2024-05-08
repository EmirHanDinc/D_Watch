import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ActorDetailsPage extends StatefulWidget {
  final int actorID;
  const ActorDetailsPage({super.key, required this.actorID});

  @override
  State<ActorDetailsPage> createState() => _ActorDetailsPageState();
}

class _ActorDetailsPageState extends State<ActorDetailsPage> {
  late Map<String, dynamic> actorDetailsList;
  late Map<String, dynamic> actorImagesList;

  void fetchActorDetails() async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/person/${widget.actorID}?language=tr-tr'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZTg4YTZjMWVkZmY4YTkxYWE4ZmY3NDhhYmI5OGJiNSIsInN1YiI6IjYxNzg3Y2ExZjJjZjI1MDA2MTkzYjFjYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.beKrG7wS3yZQVXOpAebeUtBPvi9xNzT2oCLkzvG7CYI',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          actorDetailsList = jsonResponse;
        });
        print(actorDetailsList);
      } else {
        throw Exception('Empty or null response');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  void fetchActorImages() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/person/${widget.actorID}/images'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZTg4YTZjMWVkZmY4YTkxYWE4ZmY3NDhhYmI5OGJiNSIsInN1YiI6IjYxNzg3Y2ExZjJjZjI1MDA2MTkzYjFjYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.beKrG7wS3yZQVXOpAebeUtBPvi9xNzT2oCLkzvG7CYI',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          actorImagesList = jsonResponse;
        });
        print(actorImagesList['profiles']);
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
    fetchActorDetails();
    fetchActorImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070420),
      appBar: AppBar(
        backgroundColor: const Color(0xFF070420),
        title: Text(
          actorDetailsList['name'],
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                        'https://image.tmdb.org/t/p/original${actorDetailsList['profile_path']}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      const Text(
                        "Name",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        actorDetailsList['name'],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      const Text(
                        "Birthday",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      actorDetailsList['birthday'] != null
                          ? Text(
                              actorDetailsList['birthday'],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "No Info",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                      const SizedBox(height: 5),
                      const Text(
                        "IMDB ID",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        actorDetailsList['imdb_id'],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                actorDetailsList['name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                actorDetailsList['biography'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              height: 175,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: actorImagesList['profiles'].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Container(
                      width: 125,
                      height: 175,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/original${actorImagesList['profiles'][index]['file_path']}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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
