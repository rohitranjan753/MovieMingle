import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemingle/Constants/color.dart';
import 'package:moviemingle/Constants/text_constants.dart';
import 'package:moviemingle/models/movie_model.dart';
import 'package:moviemingle/provider/favourite_movie_provider%5D.dart';
import 'package:moviemingle/widgets/back_button.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  final MovieModel movie;
  final Function(MovieModel) onFavoriteToggle;
  final List<MovieModel> favoriteMovies;

  const DetailsScreen(
      {super.key,
      required this.movie,
      required this.onFavoriteToggle,
      required this.favoriteMovies});


  @override
  Widget build(BuildContext context) {
    var favoriteMoviesProvider =
    Provider.of<FavoriteMoviesProvider>(context); // Access the provider
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: const BackButtonWidget(),
            backgroundColor: Colours.scaffoldBgColor,
            expandedHeight: 500,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie.title,
                style: GoogleFonts.belleza(
                    fontSize: 17, fontWeight: FontWeight.w600),
              ),
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24)),
                child: screenWidth > 600
                    ? Image.network(
                        '${TextConstants.imagePath}${movie.backDropPath}',
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        '${TextConstants.imagePath}${movie.posterPath}',
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview',
                    style: GoogleFonts.openSans(
                        fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    movie.overview,
                    style: GoogleFonts.poppins(
                        fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Release: ',
                                style: GoogleFonts.belleza(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                movie.releaseDate,
                                style: GoogleFonts.roboto(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Rating:  ',
                                style: GoogleFonts.belleza(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(
                                '${movie.voteAverage.toStringAsFixed(1)}/10',
                                style: GoogleFonts.roboto(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
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
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }}
