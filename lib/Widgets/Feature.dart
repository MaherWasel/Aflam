import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Feature extends StatelessWidget {
  final String title;
  final String imageLocation;
  final String discerption;

  const Feature(
      {required this.title,
      required this.imageLocation,
      required this.discerption,
      super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.25),
            Theme.of(context).colorScheme.onInverseSurface,
            Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.75),
          ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: const Color.fromARGB(255, 115, 61, 208)),
          ),
          SizedBox(
              width: double.infinity,
              child: Image.asset(
                imageLocation,
                color: Colors.deepPurple,
                scale: 0.8,
              )),
          Text(
            discerption,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          )
        ],
      ),
    );
  }
}
