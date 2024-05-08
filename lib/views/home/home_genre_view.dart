import 'package:flutter/material.dart';

class HomeGenreCard extends StatelessWidget {
  final String genreName;
  const HomeGenreCard({super.key, required this.genreName});

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color(0xFF1f1d39),
        border: Border.all(color: Colors.white),
      ),
      child:  Padding(
        padding:const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            genreName,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
