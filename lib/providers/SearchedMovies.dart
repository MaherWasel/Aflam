import 'dart:convert';

import 'package:aflam/models/SearchedMovie.dart';
import 'package:aflam/models/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;

class SearchedMoviesNotifier extends StateNotifier<List<SearchedMovie>>{
    SearchedMoviesNotifier():super([]);
    void search(String input) async {
      if (state.isNotEmpty){
        state=[];
      }
       final uri=Uri.https('imdb188.p.rapidapi.com',"/api/v1/searchIMDB",{"query": input});
        final response=await http.get(uri,headers: {
    'X-RapidAPI-Key': '9dc371acd9mshe6c14d130bdf29dp1ada06jsn40545a8b415b',
    'X-RapidAPI-Host': 'imdb188.p.rapidapi.com'
  });
      
      if (response.statusCode != 200) {
        state=[];
        return;}
  
      final List<dynamic> data = jsonDecode(response.body)["data"];
      for (int i=0;i<data.length;i++){
        state=[...state, 
        SearchedMovie(id: data[i]["id"], 
        title: data[i]["title"], 
        year: data[i]["year"], 
        stars: data[i]["stars"], 
        imageUrl: data[i]["image"])];
      }
    }}
final searchedMoviesProvider=StateNotifierProvider<SearchedMoviesNotifier,List<SearchedMovie>>
((ref) => SearchedMoviesNotifier());

 