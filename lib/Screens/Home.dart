import 'package:aflam/Widgets/HomeDrawer.dart';
import 'package:aflam/Widgets/top10PageView.dart';
import 'package:aflam/providers/topTenMovies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double minScrollExtent = _scrollController.position.minScrollExtent;
      double maxScrollExtent = _scrollController.position.maxScrollExtent;

      //
      animateToMaxMin(maxScrollExtent, minScrollExtent, maxScrollExtent, 9,
          _scrollController);
    });
  }

  animateToMaxMin(double max, double min, double direction, int seconds,
      ScrollController scrollController) {
    scrollController
        .animateTo(direction,
            duration: Duration(seconds: seconds), curve: Curves.linear)
        .then((value) {
      direction = direction == max ? min : max;
      animateToMaxMin(max, min, direction, seconds, scrollController);
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
                    FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(Icons.exit_to_app)),
            )
          ],
        ),
        drawer: const HomeDrawer(),
        body: Column(
          children: [
            SizedBox(
              height: 100,
              child: Top10PageView(
                scrollController: _scrollController,
              ),
            )
          ],
        ));
  }
}
