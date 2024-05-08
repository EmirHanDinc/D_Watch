import 'package:dwatch/pages/movie/actor_details.dart';
import 'package:flutter/material.dart';

class DetailsActorCard extends StatelessWidget {
  final String actorNames;
  final int actorID;
  final String actorImageURL;
  const DetailsActorCard(
      {super.key,
      required this.actorNames,
      required this.actorImageURL,
      required this.actorID});

  @override
  Widget build(BuildContext context) {
    String actorImage = "https://image.tmdb.org/t/p/original$actorImageURL";
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ActorDetailsPage(
              actorID: actorID,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: 125,
            height: 175,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                actorImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 5,
            child: Text(
              actorNames,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
