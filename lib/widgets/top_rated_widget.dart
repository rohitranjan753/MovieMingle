import 'package:flutter/material.dart';
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
    await Future.delayed(Duration(seconds: 1));

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
            return SizedBox.shrink(); // Hide the extra loading indicator
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 350,
                    width: 250,
                    child: Image.network(
                      '${TextConstants.imagePath}${widget.snapshot.data[index].posterPath}',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
