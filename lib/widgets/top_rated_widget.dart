import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemingle/Constants/color.dart';
import 'package:moviemingle/Constants/text_constants.dart';
import 'package:moviemingle/models/movie_model.dart';
import 'package:moviemingle/Screens/details_screen.dart';
import 'package:moviemingle/provider/favourite_movie_provider%5D.dart';
import 'package:provider/provider.dart';

class TopRatedWidget extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final List<MovieModel> movies;
  final Function(MovieModel) onFavoriteToggle;
  final List<MovieModel> favoriteMovies;

  const TopRatedWidget({
    required this.snapshot,
    required this.movies,
    required this.onFavoriteToggle,
    required this.favoriteMovies,
  });

  @override
  Widget build(BuildContext context) {
    var favoriteMoviesProvider =
        Provider.of<FavoriteMoviesProvider>(context); // Access the provider
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final availableWidth = constraints.maxWidth;
        double fontSize = 16;
        if (availableWidth > 600) {

          // Display movies in a grid when available width is greater than 600
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        movie: movie,
                        onFavoriteToggle: onFavoriteToggle,
                        favoriteMovies: favoriteMovies,
                      ),
                    ),
                  );
                },
                child: Card(
                  color: Colours.scaffoldBgColor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Image.network(
                            '${TextConstants.imagePath}${movie.backDropPath}',
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        '${movie.title.toString()}',style: TextStyle(color: Colors.white)
                      ),
                      Text(
                        'Release: ${movie.releaseDate.toString()}',style: TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Rating: ',style: TextStyle(
                                  color: Colors.white
                                ),),
                                Icon(
                                  Icons.star,
                                  color: Colors.amberAccent,
                                ),
                                Text('${movie.voteAverage.toString()}',style: TextStyle(color: Colors.white),),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                onFavoriteToggle(movie);
                              },
                              icon: Icon(
                                favoriteMovies.contains(movie)
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                size: 30,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {

          //Mobile View
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.infinity,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            movie: movie,
                            onFavoriteToggle: onFavoriteToggle,
                            favoriteMovies: favoriteMovies,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                child: Container(
                                  child: Image.network(
                                    '${TextConstants.imagePath}${movie.posterPath}',
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                child: GestureDetector(
                                  onTap: () {
                                    onFavoriteToggle(
                                        movie); // Toggle favorite status
                                  },
                                  child: Icon(
                                    favoriteMovies.contains(movie)
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    size: 30,
                                    color:
                                        Colors.red, // Customize color as needed
                                  ),
                                ),
                                right: 10,
                                top: 10,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            color: Colors.black12,
                          ),
                          child: Column(
                            children: [
                              Text(
                                movie.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Release: ',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            movie.releaseDate,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Rating:  ',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          Text(
                                            '${movie.voteAverage.toStringAsFixed(1)}/10',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
