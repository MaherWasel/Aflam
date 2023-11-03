import 'package:aflam/Screens/DetailedMovie.dart';
import 'package:aflam/models/Movie.dart';
import 'package:aflam/models/SearchedMovie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteMoviesScreen extends StatelessWidget{
  final userCredential=FirebaseAuth.instance.currentUser;

   FavoriteMoviesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("favoriteMovies").doc(userCredential!.uid).collection("movie").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: SizedBox(
                height: 100,
                width: 120,
                child: CircularProgressIndicator()));
          }
          if (snapshot.hasData){
            final data=snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder:(context, index) {
                
                return InkWell(
                  onTap: () {
                    final movie;
                    if (data[index]["type"]=="Movie"){
                      movie=Movie(
                        id: data[index]["id"], 
                        isAdult: data[index]["isAdult"], 
                        orginalTitleText: data[index]["orginalTitleText"], 
                        imageUrl: data[index]["imageUrl"], 
                        IMDBRate: data[index]["IMDBRate"], 
                        worldRank: data[index]["worldRank"], 
                        releaseYear: data[index]["releaseYear"], 
                        plot: data[index]["plot"]); 
                    }
                    else {
                      movie=SearchedMovie(
                        id: data[index]["id"], 
                        orginalTitleText: data[index]["orginalTitleText"], 
                        year: data[index]["year"], 
                        stars: data[index]["stars"], 
                        imageUrl: data[index]["imageUrl"]);
                    }
                     Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => DetailedMovieScreen
                            (movie: movie,
                            isSearch: !(data[index]["type"]=="Movie"),
                            ),));
                  },
                  child: Image.network(data[index]["imageUrl"]));
              }
            );
          }
          else {
            return const Text("ddw");
          }
        
            
          
        },
      ),
    );
  }

}