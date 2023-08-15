import 'package:flutter/material.dart';
import 'package:moviemingle/models/movie_model.dart';

class FavoriteMoviesProvider extends ChangeNotifier {
  List<MovieModel> _favoriteMovies = [];

  List<MovieModel> get favoriteMovies => _favoriteMovies;

  void toggleFavorite(MovieModel movie) {
    if (_favoriteMovies.contains(movie)) {
      _favoriteMovies.remove(movie);
    } else {
      _favoriteMovies.add(movie);
    }
    notifyListeners();
  }
}
