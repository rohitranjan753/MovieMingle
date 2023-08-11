import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemingle/api_services/api.dart';
import 'package:moviemingle/models/movie_model.dart';
import 'package:moviemingle/widgets/top_rated_widget.dart';
import 'package:moviemingle/widgets/top_upcoming_widget.dart';
import 'package:moviemingle/widgets/trending_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<MovieModel>> trendingMovies;
  late Future<List<MovieModel>> topRatedMovies;
  late Future<List<MovieModel>> upcomingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    topRatedMovies = Api().getTopRatedMovies();
    upcomingMovies = Api().getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('CineFlix'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trending Movies',
                style: GoogleFonts.poppins(fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: FutureBuilder(
                    future: trendingMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        // final data = snapshot.data;
                        return TrendingWidget(snapshot: snapshot,);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Top rated movies',
                style: GoogleFonts.poppins(fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: FutureBuilder(
                    future: topRatedMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        // final data = snapshot.data;
                        return TopRatedWidget(snapshot: snapshot,);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Top upcoming movies',
                style: GoogleFonts.poppins(fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: FutureBuilder(
                    future: upcomingMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        // final data = snapshot.data;
                        return TopUpcomingWidget(snapshot: snapshot,);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
