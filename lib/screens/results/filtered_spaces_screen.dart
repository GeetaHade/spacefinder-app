import 'package:flutter/material.dart';
import '../../models/space_models.dart';

class FilteredSpacesScreen extends StatelessWidget {
  const FilteredSpacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spaces = ModalRoute.of(context)!.settings.arguments as List<StudySpace>;

    return Scaffold(
      backgroundColor: const Color(0xFFC3DADC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Study Spaces For You',
          style: TextStyle(color: Color(0xFF1A5D68)),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: spaces.length,
        itemBuilder: (context, index) {
          final s = spaces[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/spaceDetail',
                arguments: s,
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage(s.imageAsset),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    const Color.fromRGBO(0, 0, 0, 0.35),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    s.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
