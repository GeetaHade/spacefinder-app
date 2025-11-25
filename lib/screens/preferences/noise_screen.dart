import 'package:flutter/material.dart';

class NoiseScreen extends StatelessWidget {
  const NoiseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noise Preference'),
      ),
      body: const Center(
        child: Text('Noise preference UI will go here'),
      ),
    );
  }
}
