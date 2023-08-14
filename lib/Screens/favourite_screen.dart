import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemingle/Constants/text_constants.dart';
import 'package:moviemingle/Screens/details_screen.dart';
import 'package:moviemingle/models/movie_model.dart';

class FavoriteScreen extends StatefulWidget {
  final List<MovieModel> favoriteMovies;
  final Function(MovieModel) onFavoriteToggle;

  const FavoriteScreen(
      {required this.favoriteMovies, required this.onFavoriteToggle});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  void _showUnfavoriteConfirmationDialog(MovieModel movie) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Unfavorite Movie'),
          content: Text('Are you sure you want to remove this movie from favorites?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                widget.onFavoriteToggle(movie); // Toggle favorite status
                setState(() {});
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
      ),
      // body: ListView.builder(
      //   itemCount: favoriteMovies.length,
      //   itemBuilder: (context, index) {
      //     final movie = favoriteMovies[index];
      //     // Build your favorite movie item UI here
      //     return ListTile(
      //       title: Text(movie.title),
      //       // ... other movie details
      //     );
      //   },
      // ),

      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.favoriteMovies.length,
        itemBuilder: (context, index) {
          final movie = widget.favoriteMovies[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(movie: movie),
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
                              if (widget.favoriteMovies.contains(movie)) {
                                _showUnfavoriteConfirmationDialog(movie);
                              } else {
                                widget.onFavoriteToggle(movie); // Toggle favorite status
                                setState(() {});
                              }
                            },
                            child: Icon(
                              widget.favoriteMovies.contains(movie)
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              size: 30,
                              color: Colors.red, // Customize color as needed
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
                      color: Colors.white30,
                    ),
                    child: Column(
                      children: [
                        Text(
                          movie.title,
                          style: GoogleFonts.belleza(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Text(
                                      'Release: ',
                                      style: GoogleFonts.belleza(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      movie.releaseDate,
                                      style: GoogleFonts.roboto(
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
                                      style: GoogleFonts.belleza(
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
                                      style: GoogleFonts.roboto(
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
}
