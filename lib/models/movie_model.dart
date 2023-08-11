class MovieModel {
  String title;
  String backDropPath;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  double voteAverage;

  MovieModel({
    required this.title,
    required this.backDropPath,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        // title: json['title'],
        title: json['title'] ?? "No name",
        backDropPath: json['backdrop_path'] ?? "No background",
        originalTitle: json['original_title'] ?? "No title",
        overview: json['overview'] ?? "No overview",
        posterPath: json['poster_path'] ?? "No poster",
        releaseDate: json['release_date'] ?? "No date",
        voteAverage: json['vote_average'].toDouble() ?? "No vote"
    );
  }


  //for sending data (POST) through api
  // Map<String,dynamic> toJson() => {
  //   "title":title,
  //   "overview":overview,
  //
  // }
}
