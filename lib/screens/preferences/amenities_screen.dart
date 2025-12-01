import 'package:flutter/material.dart';
import '../../models/space_models.dart';
import '../../services/space_service.dart';

class AmenitiesScreen extends StatefulWidget {
  const AmenitiesScreen({super.key});

  @override
  State<AmenitiesScreen> createState() => _AmenitiesScreenState();
}

class _AmenitiesScreenState extends State<AmenitiesScreen> {
  // pull existing selections if any
  List<AmenityType> selected = List.from(userPrefs.amenities);

  void toggleAmenity(AmenityType amenity) {
    setState(() {
      if (selected.contains(amenity)) {
        selected.remove(amenity);
      } else {
        selected.add(amenity);
      }
    });

    userPrefs.amenities = selected;
  }

  Widget amenityButton(String label, AmenityType value) {
    final isSelected = selected.contains(value);

    return GestureDetector(
      onTap: () => toggleAmenity(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A5D68) : const Color(0xFFE0EDF0),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFF7B8B8F),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC3DADC),
      body: Stack(
        children: [
          // ===== background circles to match other preference pages =====
          Positioned(
            top: -70,
            right: -40,
            child: Image.asset(
              'assets/small circular 3.1.png',
              width: 310,
              height: 310,
            ),
          ),
          Positioned(
            bottom: 60,
            left: -60,
            child: Image.asset(
              'assets/small circular 4.1.png',
              width: 280,
              height: 280,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: Column(
                children: [
                  // back button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0x33FFFFFF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  // CENTERED question + options
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 340),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 12),
                            const Text(
                              "What amenities matter to you?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A5D68),
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              "You can select one or more",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF1A5D68),
                              ),
                            ),
                            const SizedBox(height: 32),

                            amenityButton("Many outlets", AmenityType.outlets),
                            const SizedBox(height: 16),
                            amenityButton("Strong Wi-Fi", AmenityType.wifi),
                            const SizedBox(height: 16),
                            amenityButton("Cafe nearby", AmenityType.cafe),
                            const SizedBox(height: 16),
                            amenityButton("Long hours", AmenityType.longHours),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // bottom CTA
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/searching');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A5D68),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Show my spaces",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
