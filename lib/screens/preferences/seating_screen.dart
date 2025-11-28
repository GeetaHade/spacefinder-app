import 'package:flutter/material.dart';
import '../../models/space_models.dart';
import '../../services/space_service.dart';
import 'preference_template.dart';

class SeatingScreen extends StatefulWidget {
  const SeatingScreen({super.key});

  @override
  State<SeatingScreen> createState() => _SeatingScreenState();
}

class _SeatingScreenState extends State<SeatingScreen> {
  // current selection (read from global userPrefs)
  SeatingType? _selected = userPrefs.seating;

  @override
  Widget build(BuildContext context) {
    return PreferenceTemplate<SeatingType>(
      question: 'What kind of seating do you prefer?',
      selected: _selected,
      options: [
        PreferenceOption(
          label: 'Individual Desks',
          value: SeatingType.individualDesks,
        ),
        PreferenceOption(
          label: 'Group Tables',
          value: SeatingType.groupTables,
        ),
        PreferenceOption(
          label: 'Soft Seating',
          value: SeatingType.softSeating,
        ),
        PreferenceOption(
          label: 'Study Pods',
          value: SeatingType.studyPods,
        ),
      ],
      onChanged: (value) {
        setState(() => _selected = value);
        userPrefs.seating = value;
      },
      onNext: () {
        // go to next preference screen (Environment)
        Navigator.pushNamed(context, '/environment');
      },
    );
  }
}
