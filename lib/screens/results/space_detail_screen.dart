// lib/screens/results/space_detail_screen.dart
import 'package:flutter/material.dart';
import '../../models/space_models.dart';

class SpaceDetailScreen extends StatelessWidget {
  const SpaceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final space = ModalRoute.of(context)!.settings.arguments as StudySpace;

    final seatingText = space.seatingOptions
        .map((s) => _prettifyEnum(s.name))
        .join(', ');
    final amenitiesText = space.amenities.isEmpty
        ? '—'
        : space.amenities.map((a) => _prettifyEnum(a.name)).join(', ');
    final bestFor =
        space.seatingOptions.contains(SeatingType.groupTables) ? 'Group Study' : 'Solo Study';
    final hours = space.amenities.contains(AmenityType.longHours)
        ? 'Open Late'
        : '8 AM – 8 PM';
    final music = switch (space.noise) {
      NoiseLevel.quiet => 'No Music',
      NoiseLevel.balanced => 'Soft Ambience',
      NoiseLevel.busy => 'Cafe Ambience',
    };

    final infoCards = [
      _InfoCardData(title: 'Noise Level', value: _prettifyEnum(space.noise.name)),
      _InfoCardData(title: 'Crowd Level', value: _prettifyEnum(space.crowd.name)),
      _InfoCardData(title: 'Seating', value: seatingText),
      _InfoCardData(title: 'Environment', value: _prettifyEnum(space.environment.name)),
      _InfoCardData(title: 'Music', value: music),
      _InfoCardData(title: 'Amenities', value: amenitiesText),
      _InfoCardData(title: 'Hours', value: hours),
      _InfoCardData(title: 'Best For', value: bestFor),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFC3DADC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            children: [
              SizedBox(
                height: 360,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        space.imageAsset,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: const [
                              Color.fromRGBO(0, 0, 0, 0.2),
                              Color.fromRGBO(0, 0, 0, 0.65),
                            ],
                          ),
                        ),
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(0, 0, 0, 0.65),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                space.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  ...List.generate(
                                    5,
                                    (index) => Icon(
                                      index < space.rating.round()
                                          ? Icons.star_rounded
                                          : Icons.star_border_rounded,
                                      color: const Color(0xFFFFE066),
                                      size: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '(${space.rating.toStringAsFixed(1)})',
                                    style: const TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _Dot(active: true),
                                  const SizedBox(width: 6),
                                  const _Dot(),
                                  const SizedBox(width: 6),
                                  const _Dot(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: infoCards.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.3,
                      ),
                      itemBuilder: (context, index) {
                        final data = infoCards[index];
                        return _InfoCard(title: data.title, value: data.value);
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 54,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A5D68),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/spaceMap',
                            arguments: space,
                          );
                        },
                        child: const Text(
                          'Select Your Space',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE1ECEE)),
        boxShadow: [
          const BoxShadow(
            color: Color.fromRGBO(26, 93, 104, 0.05),
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A5D68),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4B5C60),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCardData {
  const _InfoCardData({required this.title, required this.value});
  final String title;
  final String value;
}

class _Dot extends StatelessWidget {
  const _Dot({this.active = false});
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: active ? 20 : 12,
      height: 6,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white54,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

String _prettifyEnum(String value) {
  final spaced = value.replaceAllMapped(
    RegExp(r'([A-Z])'),
    (match) => ' ${match.group(0)}',
  );
  return spaced.trim().split(' ').map((part) {
    if (part.isEmpty) return part;
    return part[0].toUpperCase() + part.substring(1);
  }).join(' ');
}
