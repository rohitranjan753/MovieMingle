import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemingle/Screens/details_screen.dart';
import 'package:moviemingle/Screens/favourite_screen.dart';
import 'package:moviemingle/api_services/api.dart';
import 'package:moviemingle/models/movie_model.dart';
import 'package:moviemingle/provider/favourite_movie_provider%5D.dart';
import 'package:moviemingle/widgets/top_rated_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SortType {
  popularity,
  releaseYearAscending,
  releaseYearDescending,
  voteAverageLowToHigh,
  voteAverageHighToLow,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<MovieModel>> topRatedMovies;
  late List<MovieModel> searchResults = []; // Holds search results
  SortType? _selectedSortType; // Change SortType to SortType?
  List<MovieModel> favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    topRatedMovies = Api().getTopRatedMovies();
    _loadFavorites();
  }

  void _loadFavorites() async {
    List<MovieModel> movies =
        await topRatedMovies; // Wait for movies to be fetched
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteIds = prefs.getStringList('favoriteIds');
    if (favoriteIds != null) {
      setState(() {
        favoriteMovies = favoriteIds.map((id) {
          return movies.firstWhere((movie) => movie.id.toString() == id);
        }).toList();
      });
    }
  }

  // Function to perform search
  void _performSearch(String query) async {
    if (query.isNotEmpty) {
      final results = await Api().searchMovies(query);
      setState(() {
        searchResults = results;
      });
    } else {
      setState(() {
        searchResults = [];
      });
    }
  }

  void _sortMovies(SortType sortType) {
    setState(() {
      _selectedSortType = sortType;
    });
  }

  // Toggle favorite and update SharedPreferences
  void _toggleFavorite(MovieModel movie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favoriteIds') ?? [];

    if (favoriteIds.contains(movie.id.toString())) {
      favoriteIds.remove(movie.id.toString());
    } else {
      favoriteIds.add(movie.id.toString());
    }

    await prefs.setStringList('favoriteIds', favoriteIds);
    _loadFavorites(); // Reload favorites
  }

  @override
  Widget build(BuildContext context) {
    var favoriteMoviesProvider =
        Provider.of<FavoriteMoviesProvider>(context); // Access the provider
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'MovieMingle',
          style: GoogleFonts.abrilFatface(
              fontSize: 25, fontWeight: FontWeight.w300),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteScreen(
                    favoriteMovies: favoriteMovies,
                    onFavoriteToggle: _toggleFavorite,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top rated movies',
              style: GoogleFonts.poppins(fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            // Search bar
            TextField(
              onChanged: _performSearch,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: searchResults.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            searchResults = [];
                          });
                        },
                        icon: Icon(Icons.clear),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            // Display search results or top rated movies
            Expanded(
              child: searchResults.isNotEmpty
                  ? ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(searchResults[index].title),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  movie: searchResults[index],
                                  onFavoriteToggle: _toggleFavorite,
                                  favoriteMovies: favoriteMovies,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                  : FutureBuilder<List<MovieModel>>(
                      future: topRatedMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else if (snapshot.hasData) {
                          List<MovieModel> movies = snapshot.data!;

                          if (_selectedSortType != null) {
                            // Add this condition
                            if (_selectedSortType == SortType.popularity) {
                              movies.sort((a, b) =>
                                  b.popularity.compareTo(a.popularity));
                            } else if (_selectedSortType ==
                                SortType.releaseYearAscending) {
                              movies.sort((a, b) =>
                                  a.releaseDate.compareTo(b.releaseDate));
                            } else if (_selectedSortType ==
                                SortType.releaseYearDescending) {
                              movies.sort((a, b) =>
                                  b.releaseDate.compareTo(a.releaseDate));
                            } else if (_selectedSortType ==
                                SortType.voteAverageLowToHigh) {
                              movies.sort((a, b) =>
                                  a.voteAverage.compareTo(b.voteAverage));
                            } else if (_selectedSortType ==
                                SortType.voteAverageHighToLow) {
                              movies.sort((a, b) =>
                                  b.voteAverage.compareTo(a.voteAverage));
                            }
                          }

                          return TopRatedWidget(
                              snapshot: snapshot,
                              movies: movies,
                              onFavoriteToggle: _toggleFavorite,
                              favoriteMovies: favoriteMovies);
                        } else {
                          return Center(
                            child: SpinKitChasingDots(
                              color: Colors.white,
                            ),
                          );
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter & Sort'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Sort by Popularity'),
                onTap: () {
                  _sortMovies(SortType.popularity);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Sort by Release Year (Ascending)'),
                onTap: () {
                  _sortMovies(SortType.releaseYearAscending);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Sort by Release Year (Descending)'),
                onTap: () {
                  _sortMovies(SortType.releaseYearDescending);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Sort by Vote Average (Low to High)'),
                onTap: () {
                  _sortMovies(SortType.voteAverageLowToHigh);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Sort by Vote Average (High to Low)'),
                onTap: () {
                  _sortMovies(SortType.voteAverageHighToLow);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
