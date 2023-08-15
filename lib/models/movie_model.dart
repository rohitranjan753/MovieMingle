class MovieModel {
  int id;
  String title;
  String backDropPath;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  double voteAverage;
  double popularity;

  MovieModel({
    required this.id,
    required this.title,
    required this.backDropPath,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.popularity,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? "No id",
        // title: json['title'],
        title: json['title'] ?? "No name",
        backDropPath: json['backdrop_path'] ?? "No background",
        originalTitle: json['original_title'] ?? "No title",
        overview: json['overview'] ?? "No overview",
        posterPath: json['poster_path'] ?? "No poster",
        releaseDate: json['release_date'] ?? "No date",
        voteAverage: json['vote_average'].toDouble() ?? "No vote",
      popularity: json['popularity'].toDouble() ?? "No popularity",
    );
  }


  //for sending data (POST) through api
  // Map<String,dynamic> toJson() => {
  //   "title":title,
  //   "overview":overview,
  //
  // }
}
