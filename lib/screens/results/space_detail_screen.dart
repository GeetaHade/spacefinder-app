// lib/screens/results/space_detail_screen.dart
import 'package:flutter/material.dart';
import '../../models/space_models.dart';

class SpaceDetailScreen extends StatelessWidget {
  const SpaceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final space = ModalRoute.of(context)!.settings.arguments as StudySpace;

    return Scaffold(
      backgroundColor: const Color(0xFFC3DADC),
      body: SafeArea(
        child: Column(
          children: [
            // top image
            SizedBox(
              height: 260,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      space.imageAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    bottom: 24,
                    child: Text(
                      space.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Preferences summary (keep it simple)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Noise Level: ${space.noise.name}'),
                  Text('Crowd Level: ${space.crowd.name}'),
                  Text('Environment: ${space.environment.name}'),
                  const SizedBox(height: 12),
                  const Text(
                    'Seating:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Wrap(
                    spacing: 8,
                    children: space.seatingOptions
                        .map((s) => Chip(label: Text(s.name)))
                        .toList(),
                  ),
                ],
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A5D68),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {
                    // later: open maps / save booking
                  },
                  child: const Text(
                    'Select Your Space',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
