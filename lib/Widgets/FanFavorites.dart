import 'package:aflam/models/movie.dart';
import 'package:aflam/providers/FanFavoriteMovies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FanFavorites extends ConsumerWidget {
  const FanFavorites({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Movie>>(
        future: ref.read(fanFavorites),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            List<Movie> movies = snapshot.data!;

            if (movies.isEmpty) {
              return Center(
                child: Text(
                  "failed to load FanFavorites",
                  style:
                      GoogleFonts.lato(color: Colors.deepPurple, fontSize: 32),
                ),
              );
            }
            return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        movies[index].imageUrl,
                        fit: BoxFit.fill,
                        scale: 0.7,
                      ),
                    ),
                  );
                });
          }
          return Center(
            child: Text("Error Ocuured when loading fan Favorites",
                style: GoogleFonts.lato(color: Colors.white, fontSize: 32)),
          );
        });
  }
}
