import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:moviemingle/Constants/text_constants.dart';
import 'package:moviemingle/models/movie_model.dart';
class Api{
  static const _trendingUrl ='https://api.themoviedb.org/3/trending/movie/day?api_key=${TextConstants.apiKey}';
  static const _topRatedUrl ='https://api.themoviedb.org/3/movie/top_rated?api_key=${TextConstants.apiKey}';
  static const _upcomingUrl ='https://api.themoviedb.org/3/movie/upcoming?api_key=${TextConstants.apiKey}';


  Future<List<MovieModel>> getTrendingMovies() async{
    final response = await http.get((Uri.parse(_trendingUrl)));
    if(response.statusCode==200){
      var decodeData = jsonDecode(response.body)['results'] as List;
      // print(decodeData);
      return decodeData.map((movie) => MovieModel.fromJson(movie)).toList();
    }
    else{
      throw Exception('Something went wrong!');
    }
  }


  Future<List<MovieModel>> getTopRatedMovies() async{
    final response = await http.get((Uri.parse(_topRatedUrl)));
    if(response.statusCode==200){
      var decodeData = jsonDecode(response.body)['results'] as List;
      // print(decodeData);
      return decodeData.map((movie) => MovieModel.fromJson(movie)).toList();
    }
    else{
      throw Exception('Something went wrong!');
    }
  }


  Future<List<MovieModel>> getUpcomingMovies() async{
    final response = await http.get((Uri.parse(_upcomingUrl)));
    if(response.statusCode==200){
      var decodeData = jsonDecode(response.body)['results'] as List;
      // print(decodeData);
      return decodeData.map((movie) => MovieModel.fromJson(movie)).toList();
    }
    else{
      throw Exception('Something went wrong!');
    }
  }
}