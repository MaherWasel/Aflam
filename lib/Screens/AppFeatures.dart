import 'package:aflam/Screens/logIn.dart';
import 'package:aflam/Widgets/Feature.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppFeatures extends StatefulWidget {
  @override
  State<AppFeatures> createState() => _AppFeaturesState();
}

class _AppFeaturesState extends State<AppFeatures> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Stack(alignment: Alignment.bottomCenter, children: [
      PageView(
        controller: _pageController,
        children: const [
          Feature(
              title: "Explore Movies and Tv-Series",
              imageLocation: "assets/images/ExploreIcon.png",
              discerption:
                  "Search for many diffrent types of movies with ease ! "),
          Feature(
              title: "Review your Experience",
              imageLocation: "assets/images/ReviewIcon.png",
              discerption: "Rate movies based on your opinion ! "),
          Feature(
              title: "Comment your thoughts",
              imageLocation: "assets/images/commentIcon.png",
              discerption: "Read and share movies Experiences and thoughts")
        ],
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 45),
        alignment: Alignment.topLeft,
        child: Text(
          "Aflam افلام",
          style: GoogleFonts.lato(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 123, 189, 222)),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 35),
        alignment: Alignment.topRight,
        child: TextButton(
            child: Text(
              "Skip",
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Colors.white),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageTransition(
                    child: const LogInPage(),
                    duration: const Duration(milliseconds: 550),
                    type: PageTransitionType.topToBottom),
              );
            }),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          
           const SizedBox(
            height: 12,
          ),
          Container(
              width: double.infinity,
              alignment: Alignment.center,
              child:
                  SmoothPageIndicator(controller: _pageController, count: 3)),
          Container(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: const LogInPage(),
                          duration: const Duration(milliseconds: 550),
                          type: PageTransitionType.topToBottom),
                    );
                  },
                  child: Text("SIGN IN",
                      style: GoogleFonts.openSans(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)))),
          const SizedBox(
            height: 45,
          ),
        ],
      )
    ]));
  }
}
