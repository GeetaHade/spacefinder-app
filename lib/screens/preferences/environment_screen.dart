import 'package:flutter/material.dart';
import '../../models/space_models.dart';
import '../../services/space_service.dart';
import 'preference_template.dart';

class EnvironmentScreen extends StatefulWidget {
  const EnvironmentScreen({super.key});

  @override
  State<EnvironmentScreen> createState() => _EnvironmentScreenState();
}

class _EnvironmentScreenState extends State<EnvironmentScreen> {
  // current selection (from global prefs)
  EnvironmentType? _selected = userPrefs.environment;

  @override
  Widget build(BuildContext context) {
    return PreferenceTemplate<EnvironmentType>(
      question: 'What kind of environment do you focus best in?',
      selected: _selected,
      options: [
        PreferenceOption(
          label: 'Bright lighting',
          value: EnvironmentType.bright,
        ),
        PreferenceOption(
          label: 'Soft Lighting',
          value: EnvironmentType.soft,
        ),
        PreferenceOption(
          label: 'Cool Temperature',
          value: EnvironmentType.cool,
        ),
        PreferenceOption(
          label: 'Warm Temperature',
          value: EnvironmentType.warm,
        ),
      ],
      onChanged: (value) {
        setState(() => _selected = value);
        userPrefs.environment = value;
      },
      onNext: () {
        // after last preference → go to searching screen
        Navigator.pushNamed(context, '/amenities');
      },
    );
  }
}
