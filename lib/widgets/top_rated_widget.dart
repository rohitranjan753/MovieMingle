import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemingle/Screens/details_screen.dart';
import '../Constants/text_constants.dart';

class TopRatedWidget extends StatefulWidget {
  const TopRatedWidget({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  State<TopRatedWidget> createState() => _TopRatedWidgetState();
}

class _TopRatedWidgetState extends State<TopRatedWidget> {
  final ScrollController _scrollController = ScrollController();
  int _movieLoadingLimit = 5;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    // Simulate loading delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: double.infinity,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        itemCount: _currentPage * _movieLoadingLimit + _movieLoadingLimit,
        itemBuilder: (context, index) {
          if (index >= widget.snapshot.data.length) {
            return const SizedBox.shrink(); // Hide the extra loading indicator
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailsScreen(movie: widget.snapshot.data[index]),
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
                      child: Container(
                        child: Image.network(
                          '${TextConstants.imagePath}${widget.snapshot.data[index].posterPath}',
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: Colors.white30),
                      child: Column(
                        children: [
                          Text(
                            widget.snapshot.data[index].title,
                            style: GoogleFonts.belleza(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          // Text(
                          //   widget.snapshot.data[index].releaseDate,
                          //   style: GoogleFonts.belleza(
                          //       fontSize: 17, fontWeight: FontWeight.w600),
                          // ),
                          // Text(
                          //   widget.snapshot.data[index].voteAverage.toString(),
                          //   style: GoogleFonts.belleza(
                          //       fontSize: 17, fontWeight: FontWeight.w600),
                          // ),
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.snapshot.data[index].releaseDate,
                                        style: GoogleFonts.roboto(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        '${widget.snapshot.data[index].voteAverage.toStringAsFixed(1)}/10',
                                        style: GoogleFonts.roboto(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
