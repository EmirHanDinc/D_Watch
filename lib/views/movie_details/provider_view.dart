import 'package:flutter/material.dart';

class MovieProvierCard extends StatelessWidget {
  final String provName;
  final String provImage;
  const MovieProvierCard(
      {super.key, required this.provName, required this.provImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(
              "https://image.tmdb.org/t/p/original$provImage",
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              provName,
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
