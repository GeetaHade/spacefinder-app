// lib/screens/results/space_image_screen.dart
import 'package:flutter/material.dart';

import '../../models/space_models.dart';

class SpaceImageScreen extends StatelessWidget {
  const SpaceImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final space = ModalRoute.of(context)!.settings.arguments as StudySpace;
    final assetPath = space.layoutImageAsset ?? space.imageAsset;

    return Scaffold(
      backgroundColor: const Color(0xFFC3DADC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC3DADC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A5D68)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          space.name,
          style: const TextStyle(
            color: Color(0xFF1A5D68),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: AspectRatio(
            aspectRatio: 3 / 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                assetPath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFDEE7E7),
                    alignment: Alignment.center,
                    child: Text(
                      'Image not found:\n$assetPath',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF1A5D68),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
