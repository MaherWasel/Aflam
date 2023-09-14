import 'package:aflam/Screens/featuresScreens/SecondFeature.dart';
import 'package:aflam/Screens/featuresScreens/ThirdFeature.dart';
import 'package:aflam/Screens/featuresScreens/firstFeature.dart';
import 'package:aflam/Screens/logIn.dart';
import 'package:aflam/main.dart';
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
        children: [FirstFeature(), SecondFeature(), ThirdFeature()],
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
      Container(
          width: double.infinity,
          height: 300,
          alignment: Alignment.center,
          child: SmoothPageIndicator(controller: _pageController, count: 3))
    ]));
  }
}
