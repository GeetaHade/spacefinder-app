import 'package:flutter/material.dart';
import '../../models/space_models.dart';
import '../../services/space_service.dart';
import 'preference_template.dart';

class NoiseScreen extends StatefulWidget {
  const NoiseScreen({super.key});

  @override
  State<NoiseScreen> createState() => _NoiseScreenState();
}

class _NoiseScreenState extends State<NoiseScreen> {
  NoiseLevel? _selected = userPrefs.noise;

  @override
  Widget build(BuildContext context) {
    return PreferenceTemplate<NoiseLevel>(
      question: 'What noise level do you prefer?',
      selected: _selected,
      options: [
        PreferenceOption(label: 'Quiet', value: NoiseLevel.quiet),
        PreferenceOption(label: 'Balanced Noise', value: NoiseLevel.balanced),
        PreferenceOption(label: 'Busy Noise', value: NoiseLevel.busy),
      ],
      onChanged: (value) {
        setState(() => _selected = value);
        userPrefs.noise = value;
      },
      onNext: () {
        // if user skips selection, value just stays null
        Navigator.pushNamed(context, '/music');
      },
    );
  }
}
