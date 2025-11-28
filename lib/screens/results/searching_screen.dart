import 'package:flutter/material.dart';
import '../../models/space_models.dart';
import '../../services/space_service.dart';

class SearchingScreen extends StatefulWidget {
  const SearchingScreen({super.key});

  @override
  State<SearchingScreen> createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
  @override
  void initState() {
    super.initState();
    _startSearch();
  }

  Future<void> _startSearch() async {
    // small delay to show animation
    await Future.delayed(const Duration(seconds: 2));

    // use global userPrefs from models and matcher from service
    final List<StudySpace> matches = findMatchingSpaces(userPrefs);

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      '/results',
      arguments: matches,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC3DADC),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                "We're finding study spaces that match your preferences...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1A5D68),
                ),
              ),
              SizedBox(height: 24),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1A5D68)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
