import 'dart:convert';

import 'package:aflam/models/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;


final  fanFavorites = Provider((ref) async {
    List<Movie> listOfMovies=[];

  final uri =
      Uri.tryParse('https://imdb188.p.rapidapi.com/api/v1/getFanFavorites');
  final headers= {
    'X-RapidAPI-Key': '78a465d2d5msha8b5827db0bfdaep1241e6jsnc9f77831407e',
    'X-RapidAPI-Host': 'imdb188.p.rapidapi.com'
  };
  final response = await http.get(uri!, headers: headers);
  if (response.statusCode != 200) {
    return listOfMovies;
  }

  final List<dynamic> data = jsonDecode(response.body)["data"]["list"];
  
  for (int i=0;i<data.length;i++){
    listOfMovies.add(Movie(id: data[i]["id"], isAdult:data[i]["isAdult"]=="false"?false:true , 
    orginalTitleText: data[i]["originalTitleText"]["text"], 
    imageId: data[i]["primaryImage"]["id"], imageUrl: data[i]["primaryImage"]["imageUrl"], 
    IMDBRate: data[i]["ratingsSummary"]["aggregateRating"], 
    worldRank: data[i]["ratingsSummary"]["topRanking"]==null?"":data[i]["ratingsSummary"]["topRanking"]["rank"], voters: data[i]["ratingsSummary"]["voteCount"], 
    releaseYear: data[i]["releaseYear"]["year"], streamingOptions: {}, 
    plot: data[i]["plot"]["plotText"]["plainText"], releaseDate: []));
      
    

  }
  return listOfMovies;
});
