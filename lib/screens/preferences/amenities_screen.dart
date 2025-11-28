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
      body: SafeArea(
        child: Stack(
          children: [
            // BACK BUTTON
            Positioned(
              top: 16,
              left: 16,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0x33FFFFFF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
            ),

            // CONTENT
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 70, 30, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "What amenities matter to you?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "You can select one or more",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 36),

                  // buttons
                  amenityButton("Many Outlets", AmenityType.outlets),
                  const SizedBox(height: 16),
                  amenityButton("Strong Wi-Fi", AmenityType.wifi),
                  const SizedBox(height: 16),
                  amenityButton("Cafe Nearby", AmenityType.cafe),
                  const SizedBox(height: 16),
                  amenityButton("Long Hours", AmenityType.longHours),

                  const Spacer(),

                  // SHOW MY SPACES BUTTON
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
                        "Show My Spaces",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
