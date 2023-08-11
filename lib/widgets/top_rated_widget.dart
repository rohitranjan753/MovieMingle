import 'package:cineflix/Constants/text_constants.dart';
import 'package:cineflix/Screens/details_screen.dart';
import 'package:flutter/material.dart';

class TopRatedWidget extends StatelessWidget {
  const TopRatedWidget({
    super.key, required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailsScreen(movie: snapshot.data[index]),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 200,
                  width: 150,
                  child: Image.network(
                    '${TextConstants.imagePath}${snapshot.data[index].posterPath}',
                    filterQuality: FilterQuality.high,fit: BoxFit.cover,),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}