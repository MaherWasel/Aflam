import 'package:aflam/Screens/appFeatures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class StartingAppScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StartingAppScreenState();
  }
}

class _StartingAppScreenState extends State<StartingAppScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _iconAnimation;
  late CurvedAnimation _textAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1850));
    _iconAnimation = CurvedAnimation(
        parent: _controller, curve: Curves.fastEaseInToSlowEaseOut);
    _textAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.elasticInOut);
  }

  void startAnimation() async {
    await _controller.forward();
    await _controller.reverse();
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.leftToRight,
            duration: Duration(milliseconds: 550),
            child: AppFeatures()));
  }

  @override
  Widget build(BuildContext context) {
    startAnimation();
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
              Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.5),
              Theme.of(context).colorScheme.onInverseSurface,
              Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.25),
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _iconAnimation,
              child: SizedBox(
                  height: 220,
                  width: 220,
                  child: Image.asset("assets/images/appIcon.jpeg")),
            ),
            const SizedBox(
              height: 25,
            ),
            ScaleTransition(
                scale: _textAnimation,
                child: Text(
                  "Aflam افلام",
                  style: GoogleFonts.lato(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 123, 189, 222)),
                ))
          ],
        ),
      ),
    );
  }
}
