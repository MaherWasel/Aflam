import 'package:aflam/Screens/FavoriteMovies.dart';
import 'package:aflam/Screens/Search.dart';
import 'package:aflam/Widgets/FanFavorites.dart';
import 'package:aflam/Widgets/HomeDrawer.dart';
import 'package:aflam/Widgets/Top10PageView.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex=0;
  void _selectPage(int index){
    setState(() {
      _selectedPageIndex=index;
    });

  }

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
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: "Favorites")
          ],
        ),
        drawer:  const HomeDrawer(),
        body: _selectedPageIndex==0?
        ListView(
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
                
                FanFavorites()
        
              ],
           
        ):

            FavoriteMoviesScreen()



        );
  }
}
