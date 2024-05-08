import 'package:dwatch/views/all_movie_card.dart';
import 'package:flutter/material.dart';

class AllMoviePage extends StatefulWidget {
  const AllMoviePage({super.key});

  @override
  State<AllMoviePage> createState() => _AllMoviePageState();
}

class _AllMoviePageState extends State<AllMoviePage> {
  final List<String> items = List.generate(100, (index) => "Item $index");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF070420),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFF070420),
        title: Text(
          "All Movies",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // İzgara sütun sayısı
          crossAxisSpacing: 1, // Sütunlar arası boşluk
          mainAxisSpacing: 5, // Satırlar arası boşluk
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return CategoryMovieCards(movieImage: '', movieID: 1, movieName: '',);
        },
      ),
    );
  }
}
