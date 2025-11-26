import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF2E91A1), // same base as landing
      body: Stack(
        children: [
          // ========= TOP BACKGROUND SHAPES (reuse landing assets) =========
          // Ellipse 505
          Positioned(
            top: -64,
            left: -56,
            child: Image.asset(
              'assets/Ellipse 505.png',
              width: 269,
              height: 270,
              fit: BoxFit.cover,
            ),
          ),
          // Ellipse 506
          Positioned(
            top: -64,
            left: -101,
            child: Image.asset(
              'assets/Ellipse 506.png',
              width: 434,
              height: 388,
              fit: BoxFit.cover,
            ),
          ),
          // small circular 3 (right)
          Positioned(
            top: 84,
            left: 216,
            child: Image.asset(
              'assets/small circular 3.png',
              width: 352,
              height: 352,
              fit: BoxFit.cover,
            ),
          ),

          // ========= MAIN CONTENT =========
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),

                // Top row: back button + logo centered
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
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
                              shape: BoxShape.circle,
                              color: Color(0x33FFFFFF),
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      // logo in middle
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 57.45,
                          height: 57.45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/streamline-kameleon-color_map-pin.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Headline + subtitle (matches Figma text)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Find your perfect study space here..',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Sign up with your IIT credentials',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ====== ROUNDED CARD AREA (Rectangle 208) ======
                Expanded(
                  child: Container(
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC3DADC),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(27, 40, 27, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Name
                          _AuthTextField(
                            hint: 'Enter your name',
                            icon: Icons.person_outline,
                          ),
                          const SizedBox(height: 16),

                          // Email
                          _AuthTextField(
                            hint: 'Enter your @hawk.illinoistech.edu email',
                            icon: Icons.email_outlined,
                          ),
                          const SizedBox(height: 16),

                          // Password
                          _AuthTextField(
                            hint: 'Enter your password',
                            icon: Icons.lock_outline,
                            obscure: true,
                            showEye: true,
                          ),
                          const SizedBox(height: 12),

                          // Remember me
                          Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (_) {},
                                visualDensity: VisualDensity.compact,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'Remember me',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF7B8B8F),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Sign Up button
                          SizedBox(
                            width: double.infinity,
                            height: 44,
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: handle real sign up
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1A5D68),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Divider with "Or"
                          _OrDivider(),

                          const SizedBox(height: 24),

                          // Google button
                          _ProviderButton(
                            label: 'Google',
                            icon: Icons.g_mobiledata, // placeholder icon
                          ),
                          const SizedBox(height: 16),

                          // Outlook button
                          _ProviderButton(
                            label: 'Outlook',
                            icon: Icons.email, // placeholder icon
                          ),

                          const SizedBox(height: 24),

                          // Already have account
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: const Text.rich(
                                TextSpan(
                                  text: 'Already have an account? ',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF7B8B8F),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Login',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Shared text field style used on login & signup
class _AuthTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscure;
  final bool showEye;

  const _AuthTextField({
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.showEye = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF5FAFC),
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF7B8B8F)),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              obscureText: obscure,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF7B8B8F),
                ),
              ),
            ),
          ),
          if (showEye)
            const Icon(Icons.visibility_off_outlined,
                color: Color(0xFF7B8B8F)),
        ],
      ),
    );
  }
}

/// "Or" divider (Group 190)
class _OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: Divider(
            color: Color(0xFF959999),
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Or',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF959999),
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Color(0xFF959999),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

/// Google / Outlook button style (wide rounded outline)
class _ProviderButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const _ProviderButton({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFE0EDF0),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFF959999),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4285F4)), // not exact but fine
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
