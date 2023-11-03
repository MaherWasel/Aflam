import 'dart:convert';

import 'package:aflam/models/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;

final fanFav = Provider((ref) async {
  List<Movie> listOfMovies = [];

  final uri =
      Uri.tryParse('https://imdb188.p.rapidapi.com/api/v1/getFanFavorites');
  final headers = {
    'X-RapidAPI-Key': '8f79bdb236msh9e95bef31f5fbb1p1fa0eejsne34b5d1b9034',
    'X-RapidAPI-Host': 'imdb188.p.rapidapi.com'
  };
  final response = await http.get(uri!, headers: headers);
  if (response.statusCode != 200) {
    return listOfMovies;
  }

  final List<dynamic> data = jsonDecode(response.body)["data"]["list"];
  
  for (int i = 0; i < data.length; i++) {
    try{
    listOfMovies.add(Movie(
        id: data[i]["id"],
        isAdult: data[i]["isAdult"] == "false" ? false : true,
        orginalTitleText: data[i]["originalTitleText"]["text"],
        imageUrl: data[i]["primaryImage"]["imageUrl"],
        IMDBRate: data[i]["ratingsSummary"]["aggregateRating"],
        worldRank: data[i]["ratingsSummary"]["topRanking"] == null
            ? ""
            : data[i]["ratingsSummary"]["topRanking"]["rank"],
        releaseYear: data[i]["releaseYear"]["year"],
        plot: data[i]["plot"]["plotText"]["plainText"],
        ));}
        catch(e){

  }

  }
  return listOfMovies;
});
