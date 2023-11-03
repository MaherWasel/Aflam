import 'package:aflam/Screens/FavoriteMovies.dart';
import 'package:aflam/Screens/Search.dart';
import 'package:aflam/Widgets/FanFavorites.dart';
import 'package:aflam/Widgets/HomeDrawer.dart';
import 'package:aflam/Widgets/Top10PageView.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedPageIndex = 0;
  bool favoritesScreen = false;
  void _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
      favoritesScreen = !favoritesScreen;
    });
  }

  final List<Widget> screens = [
    ListView(
      children: [
        Center(
          child: Text("Week TopTen",
              style: GoogleFonts.lato(fontSize: 32, color: Colors.white)),
        ),
         SizedBox(height: 200, width: 400, child: Top10PageView()),
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
    ),
    FavoriteMoviesScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: selectedPageIndex == screens.length - 1
            ? AppBar(
                title: const Text("Your Favorite Movies!"),
              )
            : AppBar(
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
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: selectedPageIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites")
          ],
        ),
        drawer: HomeDrawer(),
        body: screens[selectedPageIndex]);
  }
}
