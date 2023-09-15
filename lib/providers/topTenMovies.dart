import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;

final topTenMovies = Provider((ref) async {
  final uri =
      Uri.tryParse('https://imdb188.p.rapidapi.com/api/v1/getWeekTop10');
  final headers = {
    'X-RapidAPI-Key': 'b208eec911mshcf2bbc911339699p19588cjsn4fa2db4a3d06',
    'X-RapidAPI-Host': 'imdb188.p.rapidapi.com'
  };
  final response = await http.get(uri!, headers: headers);
  if (response.statusCode != 200) {
    return [];
  }
  final data = jsonDecode(response.body);
  final List<dynamic> listOfMovies = data["data"];
  return listOfMovies;
});
