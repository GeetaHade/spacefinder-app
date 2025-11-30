// lib/screens/map/space_map_screen.dart
import 'package:flutter/material.dart';

import '../../models/space_models.dart';

class _SeatSpot {
  final String id;
  final double dx;
  final double dy;

  const _SeatSpot({
    required this.id,
    required this.dx,
    required this.dy,
  });
}

const Map<String, List<_SeatSpot>> _seatSpotsBySpace = {
  'library_private': [
    _SeatSpot(id: 'Seat A', dx: 0.33, dy: 0.62),
    _SeatSpot(id: 'Seat B', dx: 0.70, dy: 0.61),
  ],
  'library_silent': [
    _SeatSpot(id: 'Table 1', dx: 0.49, dy: 0.46),
    _SeatSpot(id: 'Table 2', dx: 0.62, dy: 0.60),
    _SeatSpot(id: 'Table 3', dx: 0.78, dy: 0.60),
    _SeatSpot(id: 'Table 4', dx: 0.72, dy: 0.46),
    _SeatSpot(id: 'Table 5', dx: 0.62, dy: 0.30),
    _SeatSpot(id: 'Table 6', dx: 0.52, dy: 0.20),
  ],
};

class SpaceMapScreen extends StatefulWidget {
  const SpaceMapScreen({super.key});

  @override
  State<SpaceMapScreen> createState() => _SpaceMapScreenState();
}

class _SpaceMapScreenState extends State<SpaceMapScreen> {
  static const double _dotSize = 20;
  final Map<String, bool> _reservedSeats = {};

  @override
  Widget build(BuildContext context) {
    final space = ModalRoute.of(context)!.settings.arguments as StudySpace;
    final assetPath = space.layoutImageAsset ?? space.imageAsset;
    final seats = _seatSpotsBySpace[space.id] ??
        const [_SeatSpot(id: 'Desk', dx: 0.5, dy: 0.5)];

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
          '${space.name} Map',
          style: const TextStyle(
            color: Color(0xFF1A5D68),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.12),
                  blurRadius: 18,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(36),
              child: AspectRatio(
                aspectRatio: 3 / 2,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final height = constraints.maxHeight;

                    return InteractiveViewer(
                      minScale: 1,
                      maxScale: 3,
                      boundaryMargin: const EdgeInsets.all(120),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              assetPath,
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
                                    Color.fromRGBO(0, 0, 0, 0.04),
                                    Color.fromRGBO(0, 0, 0, 0.12),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          for (final spot in seats)
                            Positioned(
                              left: spot.dx * width - _dotSize / 2,
                              top: spot.dy * height - _dotSize / 2,
                              child: GestureDetector(
                                onTap: () => _showReservationDialog(
                                  context,
                                  spot.id,
                                  space.name,
                                ),
                                child: Container(
                                  width: _dotSize,
                                  height: _dotSize,
                                  decoration: BoxDecoration(
                                    color: _reservedSeats[spot.id] == true
                                        ? const Color(0xFFE53935)
                                        : const Color(0xFF4CAF50),
                                    shape: BoxShape.circle,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.25),
                                        blurRadius: 10,
                                      ),
                                    ],
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      spot.id.split(' ').last,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showReservationDialog(
    BuildContext context,
    String seatLabel,
    String spaceName,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reserve $seatLabel'),
        content: Text(
          'Do you want to reserve $seatLabel in $spaceName?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _reservedSeats[seatLabel] = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$seatLabel reserved!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A5D68),
            ),
            child: const Text('Reserve'),
          ),
        ],
      ),
    );
  }
}
