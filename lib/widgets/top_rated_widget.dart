
import 'package:flutter/material.dart';
import 'package:moviemingle/Screens/details_screen.dart';

import '../Constants/text_constants.dart';

class TopRatedWidget extends StatelessWidget {
  const TopRatedWidget({
    super.key, required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: double.infinity,
      child: ListView.builder(

        // physics: const BouncingScrollPhysics(),
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
                child: Container(
                  height: 300,
                  width: 250,
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