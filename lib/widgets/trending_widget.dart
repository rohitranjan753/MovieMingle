import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moviemingle/Constants/text_constants.dart';
import 'package:moviemingle/Screens/details_screen.dart';

class TrendingWidget extends StatelessWidget {
  const TrendingWidget({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: CarouselSlider.builder(
          itemCount: 10,
          options: CarouselOptions(
            height: 300,
            autoPlay: true,
            viewportFraction: 0.55,
            pageSnapping: true,
            enlargeCenterPage: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(seconds: 2),
          ),
          itemBuilder: (context, itemIndex, pageViewIndex) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailsScreen(movie: snapshot.data[itemIndex]),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 300,
                  width: 200,
                  child: Image.network(
                    '${TextConstants.imagePath}${snapshot.data[itemIndex].posterPath}',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ));
  }
}
