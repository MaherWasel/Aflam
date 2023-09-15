import 'package:aflam/Widgets/HomeDrawer.dart';
import 'package:aflam/providers/topTenMovies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
