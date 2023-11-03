import 'dart:convert';

import 'package:aflam/models/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;

final topTenMovies = Provider((ref) async {
  List<Movie> listOfMovies = [];

  final uri =
      Uri.tryParse('https://imdb188.p.rapidapi.com/api/v1/getWeekTop10');
  final headers = {
    'X-RapidAPI-Key': 'b208eec911mshcf2bbc911339699p19588cjsn4fa2db4a3d06',
    'X-RapidAPI-Host': 'imdb188.p.rapidapi.com'
  };
  final response = await http.get(uri!, headers: headers);
  if (response.statusCode != 200) {
    return listOfMovies;
  }

  final List<dynamic> data = jsonDecode(response.body)["data"];

  for (int i = 0; i < data.length; i++) {
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
        ));
  }
  return listOfMovies;
});
