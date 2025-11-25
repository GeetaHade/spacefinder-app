import 'package:flutter/material.dart';

// adjust these imports if your folder names are slightly different
import 'screens/landing/landing_page.dart';
import 'screens/preferences/noise_screen.dart'; // we'll make a stub if you don't have it yet

void main() {
  runApp(const SpaceFinderApp());
}

class SpaceFinderApp extends StatelessWidget {
  const SpaceFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceFinder',
      debugShowCheckedModeBanner: false,

      // Global theme
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2E91A1), // teal from your Figma
        scaffoldBackgroundColor: const Color(0xFF2E91A1),
        fontFamily: 'System',
      ),

      // First screen when app opens
      home: const LandingPage(),

      // Named routes for navigation (we’ll use these later)
      routes: {
        '/landing': (context) => const LandingPage(),
        '/noise': (context) => const NoiseScreen(), // first preference screen
        // later you can add:
        // '/music': (context) => const MusicScreen(),
        // '/crowd': (context) => const CrowdScreen(),
        // '/results': (context) => const FilteredSpacesScreen(),
      },
    );
  }
}
