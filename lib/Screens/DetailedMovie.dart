


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class DetailedMovieScreen extends StatefulWidget{
  final movie;
  final bool isSearch;
   const DetailedMovieScreen({
    required this.isSearch,
    required this.movie, super.key});

  @override
  State<DetailedMovieScreen> createState() => _DetailedMovieScreenState();
}

class _DetailedMovieScreenState extends State<DetailedMovieScreen> {
  final userCredential =FirebaseAuth.instance.currentUser;
  bool isFav=false;
  late var ref;
  String comment="";
  var name="";
  void commentHandler(){
    if (comment==""){
      return;
    }
    FirebaseFirestore.instance.collection("comments").doc(widget.movie.id).collection("comment").add({
      "comment":comment,"user":userCredential!.uid,"name":name,
      "createdAt":Timestamp.now()});

  }
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
          "orginalTitleText":widget.movie.orginalTitleText,
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
      "imageUrl":widget.movie.imageUrl,
      "IMDBRate":widget.movie.IMDBRate,
      "worldRank":widget.movie.worldRank,
      "releaseYear":widget.movie.releaseYear,
      "plot":widget.movie.plot,

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
            return const CircularProgressIndicator();
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
                title: Text(widget.movie.orginalTitleText,overflow: TextOverflow.clip,),
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
                        
              body: ListView(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 3),
                      
                      width: 210,
                      height: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(widget.movie.imageUrl,fit: BoxFit.fill,))),
                    Expanded(
                      child: widget.isSearch?
                      Row(
                            children: [
                              Text("   releaseYear : ${widget.movie.year}",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 16
                              ),),
                              const Icon(Icons.date_range)
                            ],
                          )
                      :Column(
                        children: [
                          Row(
                            children: [
                              Text("   world rank : ${widget.movie.worldRank}",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 20
                              ),),
                              const Icon(Icons.star_border_purple500_rounded)
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                           Row(
                            children: [
                              Text("   releaseYear : ${widget.movie.releaseYear}",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 16
                              ),),
                              const Icon(Icons.date_range)
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text("   IMDBRate : ${widget.movie.IMDBRate}/10",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 16
                              ),),
                              const Icon(Icons.reviews_sharp)
                            ],
                          ),
                           const SizedBox(
                            height: 6,
                          ),
                          Text(widget.movie.isAdult==true?"For Adult!":"For EveryOne!",
                          style: GoogleFonts.lato(
                            color: Colors.red,
                            fontSize: 20
                          ),)
                        ],
                      ))
                  ],
                ),
                widget.isSearch?Text(""): Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.movie.plot,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 18
                  ),),
                ),
                Center(
                  child: Text("The Comments Section",
                  style: GoogleFonts.lato(
                    color: Colors.grey,
                    fontSize: 28
                  ),),
                ),
                Row(children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    width: 258,
                    child: TextField(
                      maxLength: 50,
                      onChanged: (value) =>comment=value ,
                      style:GoogleFonts.lato(
                          
                          color: Colors.white
                        ) ,
                      
                    )),
                  ElevatedButton(
                    onPressed: commentHandler, 
                  child: Text("Submit",
                  style: GoogleFonts.lato(
                    color: Colors.white
                  ),),
                  style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
  )  )
                ],),
                StreamBuilder (
                  stream: FirebaseFirestore.instance.collection("comments").doc(widget.movie.id).collection("comment").orderBy("createdAt",descending: false).snapshots(), 
                  builder:(context, snapshot) {
                    if (snapshot.connectionState==ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }
                    else if (snapshot.hasData){
                    final list=snapshot.data!.docs;
                    return Expanded(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: list.length,
                        reverse: true,
                        itemBuilder:(context, index) {
                          return Container(
                            margin: EdgeInsets.all(8),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color.fromARGB(255, 227, 203, 203),Color.fromARGB(255, 244, 220, 220),const Color.fromARGB(255, 160, 140, 140)])
                            ),
                            height: 100,
                            child: Row(
                              children: [
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance.collection("users").snapshots(), 
                                  builder:(context, snapshot) {
                                    if (snapshot.hasData){
                                       final us=snapshot.data!.docs;
                                       var link="";
                                       
                                       for (int i=0;i<us.length;i++){
                                        if (us[i].id==list[index]["user"]){
                                          link=us[i]["imageUrl"];
                                          name=us[i]["username"];
                                         
                                        }
                                       }
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.all(10),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(45),
                                                  child: Image.network(link,scale: 2,fit: BoxFit.cover,))),
                                              Column(
                                    children: [
                                      Text(name.toUpperCase(),
                                      style: GoogleFonts.lato(
                                        color: Colors.blueGrey,
                                        fontSize: 32
                                      ),),
                                    Text(list[index]["comment"],
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 15
                                    ),)],
                                  ),
                                            ],
                                          );
                                    }
                                    return Text("");
                                  },),

                                
                              ],
                            ));
                        },));
                    }
                    return Text("fuck you");
                  },)
            ],
          ),
            );
          }       
          else {
            return const Text("check your connection");
          }
        }
      );
    
  }
}