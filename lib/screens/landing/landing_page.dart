import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Figma frame size
    const double baseWidth = 393.0;
    const double baseHeight = 852.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double scaleX = constraints.maxWidth / baseWidth;
        final double scaleY = constraints.maxHeight / baseHeight;

        // Helper to scale a value in X/Y direction
        double sx(double v) => v * scaleX;
        double sy(double v) => v * scaleY;

        return Scaffold(
          body: Stack(
            children: [
              // Base background color
              Container(color: const Color(0xFF2E91A1)),

              // ELLIPSE 505  (Top: -64, Left: -56, W: 269, H: 270)
              Positioned(
                top: sy(-64),
                left: sx(-56),
                child: Image.asset(
                  'assets/Ellipse 505.png',
                  width: sx(269),
                  height: sy(270),
                  fit: BoxFit.cover,
                ),
              ),

              // ELLIPSE 506 (Top: -64, Left: -101, W: 434, H: 388)
              Positioned(
                top: sy(-64),
                left: sx(-101),
                child: Image.asset(
                  'assets/Ellipse 506.png',
                  width: sx(434),
                  height: sy(388),
                  fit: BoxFit.cover,
                ),
              ),

              // SMALL CIRCULAR 3 (Top: 84, Left: 216, W: 352, H: 352, 25% opacity)
              Positioned(
                top: sy(84),
                left: sx(216),
                child: Opacity(
                  opacity: 0.25,
                  child: Image.asset(
                    'assets/small circular 3.png',
                    width: sx(352),
                    height: sy(352),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // SMALL CIRCULAR 4 (Top: 444, Left: -90, W: 352, H: 352, 50% opacity)
              Positioned(
                top: sy(444),
                left: sx(-90),
                child: Opacity(
                  opacity: 0.5,
                  child: Image.asset(
                    'assets/small circular 4.png',
                    width: sx(352),
                    height: sy(352),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // ELLIPSE 507 (Top: 633, Left: 179, W: 269, H: 270)
              Positioned(
                top: sy(633),
                left: sx(179),
                child: Image.asset(
                  'assets/Ellipse 507.png',
                  width: sx(269),
                  height: sy(270),
                  fit: BoxFit.cover,
                ),
              ),

              // LOGO GROUP (circle + pin)  Top: 253, Left: 168, W: 57.45, H: 57.45
              Positioned(
                top: sy(253),
                left: sx(168),
                child: SizedBox(
                  width: sx(57.45),
                  height: sy(57.45),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/Vector.png', // white ring
                        width: sx(57.45),
                        height: sy(57.45),
                      ),
                      Image.asset(
                        'assets/streamline-kameleon-color_map-pin.png',
                        width: sx(50),
                        height: sy(50),
                      ),
                    ],
                  ),
                ),
              ),

              // TITLE "SpaceFinder" (Top: 320, Left: 90, W: 213, H: 61)
              // TITLE "SpaceFinder" as image (matches Figma width & position)
Positioned(
  top: sy(320),   // from Figma
  left: sx(90),   // from Figma
  child: Image.asset(
    'assets/SpaceFinder.png',
    width: sx(213),  // Figma width
    height: sy(61),  // Figma height
    fit: BoxFit.contain,
  ),
),

              Positioned(
  top: sy(392),
  left: sx(30),
  width: sx(334),
  child: Image.asset(
    'assets/Find the perfect study space around campus.png',
    fit: BoxFit.contain,
  ),
),


              // START BUTTON GROUP 198 (Top: 477, Left: 89, W: 216, H: 44)
              Positioned(
                top: sy(477),
                left: sx(89),
                width: sx(216),
                height: sy(44),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/noise');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.white, width: 1),
                    ),
                  ),
                  child: Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 18 * scaleY, // scales a bit with height
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2E91A1),
                    ),
                  ),
                ),
              ),

              // FOOTER "Pixel Pioneers © 2025" (Top: 811, Left: 30, W: 334, H: 12)
              Positioned(
                top: sy(811),
                left: sx(30),
                width: sx(334),
                child: const Text(
                  'Pixel Pioneers © 2025',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontFamily: 'Instrument Sans',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
