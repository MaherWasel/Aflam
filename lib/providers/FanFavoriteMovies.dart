import 'dart:convert';

import 'package:aflam/models/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;

final fanFavorites = Provider((ref) async {
  List<Movie> listOfMovies = [];

  final uri =
      Uri.tryParse('https://imdb188.p.rapidapi.com/api/v1/getFanFavorites');
  final headers = {
    'X-RapidAPI-Key': '9dc371acd9mshe6c14d130bdf29dp1ada06jsn40545a8b415b',
    'X-RapidAPI-Host': 'imdb188.p.rapidapi.com'
  };
  final response = await http.get(uri!, headers: headers);

  if (response.statusCode != 200) {
    return listOfMovies;
  }

  final List<dynamic> data = jsonDecode(response.body)["data"]["list"];

  for (int i = 0; i < data.length; i++) {
    listOfMovies.add(Movie(
        id: data[i]["id"],
        isAdult: data[i]["isAdult"] == "false" ? false : true,
        orginalTitleText: data[i]["originalTitleText"]["text"],
        imageId: data[i]["primaryImage"]["id"],
        imageUrl: data[i]["primaryImage"]["imageUrl"],
        IMDBRate: data[i]["ratingsSummary"]["aggregateRating"],
        worldRank: data[i]["ratingsSummary"]["topRanking"] == null
            ? ""
            : data[i]["ratingsSummary"]["topRanking"]["rank"],
        voters: data[i]["ratingsSummary"]["voteCount"],
        releaseYear: data[i]["releaseYear"]["year"],
        streamingOptions: {},
        plot: data[i]["plot"]["plotText"]["plainText"],
        releaseDate: []));
  }
  return listOfMovies;
});
