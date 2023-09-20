import 'package:aflam/Screens/Search.dart';
import 'package:aflam/Widgets/FanFavorites.dart';
import 'package:aflam/Widgets/HomeDrawer.dart';
import 'package:aflam/Widgets/Top10PageView.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Search(),
                        ));
                  },
                  icon: const Icon(Icons.search)),
            )
          ],
        ),
        drawer: const HomeDrawer(),
        body: ListView(
          children: [
            Center(
              child: Text("Week TopTen",
                  style: GoogleFonts.lato(fontSize: 32, color: Colors.white)),
            ),
            const SizedBox(height: 200, width: 400, child: Top10PageView()),
            Center(
              child: Text(
                "Fan Favorites",
                style: GoogleFonts.lato(fontSize: 32, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const FanFavorites()
          ],
        ));
  }
}
