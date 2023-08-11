import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemingle/Screens/details_screen.dart';
import 'package:moviemingle/api_services/api.dart';
import 'package:moviemingle/models/movie_model.dart';
import 'package:moviemingle/widgets/top_rated_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<MovieModel>> topRatedMovies;
  late List<MovieModel> searchResults = []; // Holds search results

  @override
  void initState() {
    super.initState();
    topRatedMovies = Api().getTopRatedMovies();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'MovieMingle',
          style: GoogleFonts.abrilFatface(fontSize: 25, fontWeight: FontWeight.w300),
        ),
        centerTitle: true,
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
            // Display search results
            Expanded(
              child: searchResults.isNotEmpty
                  ? ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(searchResults[index].title),
                    // Add navigation to details screen
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsScreen(movie: searchResults[index]),
                        ),
                      );
                    },
                  );
                },
              )
                  : FutureBuilder(
                future: topRatedMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return TopRatedWidget(snapshot: snapshot);
                  } else {
                    return  Center(
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
}
