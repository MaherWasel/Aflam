import 'package:aflam/Screens/DetailedMovie.dart';
import 'package:aflam/Widgets/top10PageView.dart';
import 'package:aflam/models/movie.dart';
import 'package:aflam/providers/topTenMovies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Top10PageView extends ConsumerWidget {
  const Top10PageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Movie>>(
        future: ref.read(topTenMovies),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            List<Movie> movies = snapshot.data!;
            if (movies.isEmpty) {
              return Center(
                child: Text("Failed to load TOP10",
                    style: GoogleFonts.lato(
                        fontSize: 32, color: Colors.deepPurple)),
              );
            }
            return Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => DetailedMovieScreen(movie: movies[index]),));
                          },
                          child: Image.network(movies[index].imageUrl,
                              fit: BoxFit.fill),
                        ),
                      ),
                    );
                  }),
            );
          }
          return  Text("Failed to load TOP10",
                    style: GoogleFonts.lato(
                        fontSize: 32, color: Colors.deepPurple));
        });
  }
}
