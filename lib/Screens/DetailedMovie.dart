import 'package:aflam/Widgets/movieDetail.dart';

import 'package:aflam/models/Movie.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailedMovieScreen extends StatefulWidget {
  final movie;
  const DetailedMovieScreen({required this.movie, super.key});

  @override
  State<DetailedMovieScreen> createState() => _DetailedMovieScreenState();
}

class _DetailedMovieScreenState extends State<DetailedMovieScreen> {
  final userCredential = FirebaseAuth.instance.currentUser;

  List<Object> favoriteMovies = [];
  late bool isMovieFavorite;
  bool isFav = false;
  late var ref;

  void checkFavorites() async {
    CollectionReference collection = FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential!.uid)
        .collection("favorites");

    QuerySnapshot snapshot = await collection.get();

    for (var doc in snapshot.docs) {
      favoriteMovies.add(doc.data()!);
    }
  }

  void addToFavorite() async {
    checkFavorites();
    if (!favoriteMovies.contains(widget.movie.title)) {
      if (isFav) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential!.uid)
            .collection("favorites")
            .doc(ref)
            .delete();

        return;
      } else if (widget.movie.runtimeType.toString() == "SearchedMovie") {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential!.uid)
            .collection("favorites")
            .add({
          "type": "SearchedMovie",
          "id": widget.movie.id,
          "title": widget.movie.title,
          "year": widget.movie.year,
          "stars": widget.movie.stars,
          "imageUrl": widget.movie.imageUrl
        });
      } else if (widget.movie.runtimeType.toString() == "Movie") {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential!.uid)
            .collection("favorites")
            .add({
          "type": "Movie",
          "id": widget.movie.id,
          "isAdult": widget.movie.isAdult,
          "orginalTitleText": widget.movie.orginalTitleText,
          "imageId": widget.movie.imageId,
          "imageUrl": widget.movie.imageUrl,
          "IMDBRate": widget.movie.IMDBRate,
          "worldRank": widget.movie.worldRank,
          "voters": widget.movie.voters,
          "releaseYear": widget.movie.releaseYear,
          "streamingOptions": widget.movie.streamingOptions,
          "plot": widget.movie.plot,
          "releaseDate": widget.movie.releaseDate
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential!.uid)
            .collection("favorite")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            final data = snapshot.data!.docs;

            for (int i = 0; i < data.length; i++) {
              if (data[i]["id"] == widget.movie.id) {
                ref = data[i].id;
                isFav = true;
              }
            }
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Movie Details"),
                  actions: [
                    StatefulBuilder(
                      builder: (context, setState) {
                        return IconButton(
                          icon: Icon(isFav ? Icons.star : Icons.star_border),
                          onPressed: () {
                            setState(() {
                              addToFavorite();
                              isFav = !isFav;
                            });
                          },
                        );
                      },
                    )
                  ],
                ),
                body: MovieDetail(
                  movieName: widget.movie.orginalTitleText,
                  imageUrl: widget.movie.imageUrl,
                  worldRank: widget.movie.worldRank,
                  yearReleased: widget.movie.releaseYear,
                ));
          } else {
            return Text("check your connection");
          }
        });
  }
}
