import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:aflam/Screens/StartingApp.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Color.fromRGBO(65, 67, 66, 1001),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: StartingAppScreen(),
    );
  }
}
