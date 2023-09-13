import 'package:aflam/Screens/featuresScreens/SecondFeature.dart';
import 'package:aflam/Screens/featuresScreens/ThirdFeature.dart';
import 'package:aflam/Screens/featuresScreens/firstFeature.dart';
import 'package:flutter/material.dart';
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
          width: double.infinity,
          height: 300,
          alignment: Alignment.center,
          child: SmoothPageIndicator(controller: _pageController, count: 3))
    ]));
  }
}
