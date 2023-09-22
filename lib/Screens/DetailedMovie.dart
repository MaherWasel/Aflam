


import 'package:aflam/models/Movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class DetailedMovieScreen extends StatefulWidget{
  final movie;
   const DetailedMovieScreen({required this.movie, super.key});

  @override
  State<DetailedMovieScreen> createState() => _DetailedMovieScreenState();
}

class _DetailedMovieScreenState extends State<DetailedMovieScreen> {
  final userCredential =FirebaseAuth.instance.currentUser;
  bool isFav=false;
  late var ref;
  void addToFavorite() async {
    if (isFav){
      FirebaseFirestore.instance.collection("favoriteMovies").doc(userCredential!.uid).collection("movie")
      .doc(ref).delete();
     
      return;
    
    }
    else if (widget.movie.runtimeType.toString()=="SearchedMovie"){
      await FirebaseFirestore.instance.collection("favoriteMovies").
      doc(userCredential!.uid).collection("movie").add(
        {
          "type":"SearchedMovie",
          "id":widget.movie.id,
          "title":widget.movie.title,
          "year":widget.movie.year,
          "stars":widget.movie.stars,
          "imageUrl":widget.movie.imageUrl

        
        }
      );

    }
    else if (widget.movie.runtimeType.toString()=="Movie"){

     await FirebaseFirestore.instance.collection("favoriteMovies").doc(userCredential!.uid).
     collection("movie").add({
      "type":"Movie",
      "id":widget.movie.id,
      "isAdult":widget.movie.isAdult,
      "orginalTitleText":widget.movie.orginalTitleText,
      "imageId":widget.movie.imageId,
      "imageUrl":widget.movie.imageUrl,
      "IMDBRate":widget.movie.IMDBRate,
      "worldRank":widget.movie.worldRank,
      "voters":widget.movie.voters,
      "releaseYear":widget.movie.releaseYear,
      "streamingOptions":widget.movie.streamingOptions,
      "plot":widget.movie.plot,
      "releaseDate":widget.movie.releaseDate

     });
    
    }
    
  
    }
  
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("favoriteMovies").
        doc(userCredential!.uid).collection("movie").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          else if (snapshot.hasData){
            final data=snapshot.data!.docs;
            
            for (int i=0;i<data.length;i++){
              if (data[i]["id"]==widget.movie.id){
                  ref=data[i].id;
                  isFav=true;
                
              }
            }
            return Scaffold(
              appBar: AppBar(
              actions: [
                StatefulBuilder(builder: (context, setState) {
                  return IconButton(
                    icon: Icon(isFav?Icons.star:Icons.star_border),
                    onPressed: (){
                      setState(() {
                        addToFavorite();
                        isFav=!isFav;

                      });
                    }, );
                },)
              ],
                        ),
                        
              body: Column(
              children: [
                Image.network(widget.movie.imageUrl)
            ],
          ),
            );
          }       
          else {
            return Text("check your connection");
          }
        }
      );
    
  }
}