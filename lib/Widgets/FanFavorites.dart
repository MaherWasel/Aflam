import 'package:aflam/Screens/detailedMovie.dart';
import 'package:aflam/models/Movie.dart';
import 'package:aflam/providers/FanFavoriteMovies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FanFavorites extends ConsumerWidget {
  const FanFavorites({super.key});
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder (
        future: ref.read(fanFav),
        
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (!snapshot.hasData||snapshot.data!.isEmpty){
          
          return Center(
            child: Text(
                  "failed to load FanFavorites",
                  style:
                      GoogleFonts.lato(color: Colors.deepPurple, fontSize: 32),
                ),
          );}
          {
            final movies = snapshot.data!;
           
            return GridView.builder(
                
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: (25),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: InkWell(
                        onTap: () {
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => DetailedMovieScreen(
                          isSearch: false,
                          movie: movies[index]),));
                        },
                        child: Image.network(
                          movies[index].imageUrl,
                          fit: BoxFit.fill,
                          scale: 0.7,
                        ),
                      ),
                    ),
                  );
                });
          }
        });
  }
}
