import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieDetail extends StatelessWidget {
  final String imageUrl;
  final String movieName;
  final int worldRank;
  final int yearReleased;

  const MovieDetail({
    super.key,
    required this.movieName,
    required this.imageUrl,
    required this.worldRank,
    required this.yearReleased,
  });

  @override
  Widget build(BuildContext context) {
    final deviceData = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          height: deviceData.height * 0.4,
          width: deviceData.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: deviceData.width * 0.4,
                  child: Image.network(imageUrl)),
              SizedBox(
                width: deviceData.width * 0.05,
              ),
              Container(
                width: deviceData.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movieName,
                      style: GoogleFonts.quicksand(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Year released: $yearReleased",
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "Comments💬",
            style: GoogleFonts.quicksand(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
