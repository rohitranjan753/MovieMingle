import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemingle/Constants/text_constants.dart';
import 'package:moviemingle/Screens/details_screen.dart';
import 'package:moviemingle/models/movie_model.dart';
import 'package:moviemingle/provider/favourite_movie_provider%5D.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  final List<MovieModel> favoriteMovies;
  final Function(MovieModel) onFavoriteToggle;

  const FavoriteScreen(
      {required this.favoriteMovies, required this.onFavoriteToggle});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<MovieModel> localFavoriteMovies = []; // Local state variable

  @override
  void initState() {
    super.initState();
    localFavoriteMovies =
        List.from(widget.favoriteMovies); // Initialize local list
  }

  void _showUnfavoriteConfirmationDialog(MovieModel movie) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Unfavorite Movie'),
          content: Text(
              'Are you sure you want to remove this movie from favorites?'),
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
                setState(() {
                  localFavoriteMovies.remove(movie); // Update local state
                });
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
    var favoriteMoviesProvider =
        Provider.of<FavoriteMoviesProvider>(context); // Access the provider
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Favorite Movies'),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Set the number of columns you want in the grid
            crossAxisSpacing: 8.0, // Adjust spacing between columns
            mainAxisSpacing: 8.0, // Adjust spacing between rows
          ),
          itemCount: localFavoriteMovies.length,
          itemBuilder: (context, index) {
            final movie = localFavoriteMovies[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      movie: movie,
                      onFavoriteToggle: widget.onFavoriteToggle,
                      favoriteMovies: widget.favoriteMovies,
                    ),
                  ),
                );
              },
              child: Card(
                elevation:
                    4.0, // Add elevation to create a card-like appearance
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
                          '${TextConstants.imagePath}${movie.posterPath}',
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      '${movie.title.toString()}',
                    ),
                    Text(
                      'Release year: ${movie.releaseDate.toString()}',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('Rating: '),
                              Icon(
                                Icons.star,
                                color: Colors.amberAccent,
                              ),
                              Text('${movie.voteAverage.toString()}'),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              if (widget.favoriteMovies.contains(movie)) {
                                _showUnfavoriteConfirmationDialog(movie);
                              } else {
                                widget.onFavoriteToggle(movie);
                                setState(() {});
                              }
                            },
                            child: Icon(
                              widget.favoriteMovies.contains(movie)
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              size: 30,
                              color: Colors.red,
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
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Favorite Movies'),
        ),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: localFavoriteMovies.length, // Use localFavoriteMovies
          itemBuilder: (context, index) {
            final movie = localFavoriteMovies[index]; // Use localFavoriteMovies

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        movie: movie,
                        onFavoriteToggle: widget.onFavoriteToggle,
                        favoriteMovies: widget.favoriteMovies,
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
                                if (widget.favoriteMovies.contains(movie)) {
                                  _showUnfavoriteConfirmationDialog(movie);
                                } else {
                                  widget.onFavoriteToggle(
                                      movie); // Toggle favorite status
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
}
