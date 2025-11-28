import 'package:flutter/material.dart';

// adjust these imports if your folder names are slightly different
import 'screens/landing/landing_page.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/preferences/noise_screen.dart'; // stub for now
import 'screens/preferences/music_screen.dart';
import 'screens/preferences/crowd_screen.dart';
import 'screens/preferences/seating_screen.dart';
import 'screens/preferences/environment_screen.dart';
import 'screens/preferences/amenities_screen.dart';
import 'screens/results/searching_screen.dart';
import 'screens/results/filtered_spaces_screen.dart';
import 'screens/results/space_detail_screen.dart';




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

      // ✅ SINGLE routes map – combine everything here
      routes: {
        '/landing': (context) => const LandingPage(),
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/noise': (context) => const NoiseScreen(), // first preference screen
        // later you can add:
        '/music': (context) => const MusicScreen(),
        '/crowd': (context) => const CrowdScreen(),
        '/seating': (context) => const SeatingScreen(),
        '/environment': (context) => const EnvironmentScreen(),
        '/amenities': (context) => const AmenitiesScreen(),
        '/searching': (context) => const SearchingScreen(),
        '/results': (context) => const FilteredSpacesScreen(),
        '/spaceDetail': (context) => const SpaceDetailScreen(),


      },
    );
  }
}
