import 'package:flutter/material.dart';
import '../../models/space_models.dart';
import '../../services/space_service.dart';
import 'preference_template.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  // current selection for this screen
  MusicPref? _selected = userPrefs.music;

  @override
  Widget build(BuildContext context) {
    return PreferenceTemplate<MusicPref>(
      question: 'What kind of background sound helps you focus?',
      selected: _selected,
      options: [
        PreferenceOption(label: 'Light Music', value: MusicPref.lightMusic),
        PreferenceOption(label: 'Cafe Ambience', value: MusicPref.cafeAmbience),
        PreferenceOption(label: 'Nature Sounds', value: MusicPref.natureSounds),
        PreferenceOption(label: 'No Music', value: MusicPref.noMusic),
      ],
      onChanged: (value) {
        setState(() => _selected = value);
        userPrefs.music = value;
      },
      onNext: () {
        // go to the next preference screen (Crowd)
        Navigator.pushNamed(context, '/crowd');
      },
    );
  }
}
