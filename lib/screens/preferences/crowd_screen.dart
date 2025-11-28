import 'package:flutter/material.dart';
import '../../models/space_models.dart';
import '../../services/space_service.dart';
import 'preference_template.dart';

class CrowdScreen extends StatefulWidget {
  const CrowdScreen({super.key});

  @override
  State<CrowdScreen> createState() => _CrowdScreenState();
}

class _CrowdScreenState extends State<CrowdScreen> {
  // keep current selection (pulled from global userPrefs)
  CrowdLevel? _selected = userPrefs.crowd;

  @override
  Widget build(BuildContext context) {
    return PreferenceTemplate<CrowdLevel>(
      question: 'How crowded do you want the place to be?',
      selected: _selected,
      options: [
        PreferenceOption(label: 'Low Crowd',    value: CrowdLevel.low),
        PreferenceOption(label: 'Medium Crowd', value: CrowdLevel.medium),
        PreferenceOption(label: 'High Crowd',   value: CrowdLevel.high),
      ],
      onChanged: (value) {
        setState(() => _selected = value);
        userPrefs.crowd = value;
      },
      onNext: () {
        // go to next preference step → Seating
        Navigator.pushNamed(context, '/seating');
      },
    );
  }
}
