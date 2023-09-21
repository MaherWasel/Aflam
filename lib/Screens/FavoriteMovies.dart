import 'package:aflam/Screens/DetailedMovie.dart';
import 'package:aflam/models/Movie.dart';
import 'package:aflam/models/SearchedMovie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteMoviesScreen extends StatelessWidget{
  final userCredential=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("favoriteMovies").doc(userCredential!.uid).collection("movie").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator()));
          }
          else  if (snapshot.hasData){
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
                        imageId: data[index]["imageId"], 
                        imageUrl: data[index]["imageUrl"], 
                        IMDBRate: data[index]["IMDBRate"], 
                        worldRank: data[index]["worldRank"], 
                        voters:data[index]["voters"] , 
                        releaseYear: data[index]["releaseYear"], 
                        streamingOptions: data[index]["streamingOptions"], 
                        plot: data[index]["plot"], 
                        releaseDate: data[index]["releaseDate"]);
                    }
                    else {
                      movie=SearchedMovie(
                        id: data[index]["id"], 
                        title: data[index]["title"], 
                        year: data[index]["year"], 
                        stars: data[index]["stars"], 
                        imageUrl: data[index]["imageUrl"]);
                    }
                     Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => DetailedMovieScreen(movie: movie),));
                  },
                  child: Image.network(data[index]["imageUrl"]));
              }
            );
          }
          else {
            return Text("ddw");
          }
        
            
          
        },
      ),
    );
  }

}