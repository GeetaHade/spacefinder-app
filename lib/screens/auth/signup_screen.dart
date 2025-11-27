import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _handleSignUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
    await prefs.setString('user_password', password);
    await prefs.setBool('is_logged_in', true);

    setState(() => _isSubmitting = false);

    if (!mounted) return;

    // After sign up → go to first preference screen
    Navigator.pushReplacementNamed(context, '/noise');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF2E91A1),
      body: Stack(
        children: [
          // top shapes
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

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),

                // back + logo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0x33FFFFFF),
                            ),
                            child: const Icon(Icons.arrow_back, color: Colors.white),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 57,
                          height: 57,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/streamline-kameleon-color_map-pin.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // headline
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Text(
                        "Find your perfect study space here..",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Sign up with your IIT credentials",
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

                const SizedBox(height: 18),

                // card
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(27, 28, 27, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Name
                          _AuthTextField(
                            controller: _nameController,
                            hint: 'Enter your name',
                            icon: Icons.person_outline,
                          ),
                          const SizedBox(height: 12),

                          // Email
                          _AuthTextField(
                            controller: _emailController,
                            hint: 'Enter your @hawk.illinoistech.edu email',
                            icon: Icons.email_outlined,
                          ),
                          const SizedBox(height: 12),

                          // Password
                          _AuthTextField(
                            controller: _passwordController,
                            hint: 'Enter your password',
                            icon: Icons.lock_outline,
                            obscure: true,
                            showEye: true,
                          ),
                          const SizedBox(height: 8),

                          Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (_) {},
                                visualDensity: VisualDensity.compact,
                              ),
                              const Text(
                                "Remember me",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF7B8B8F),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Sign Up button
                          SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              onPressed: _isSubmitting ? null : _handleSignUp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1A5D68),
                                disabledBackgroundColor: const Color(0xFF8BB0B6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                elevation: 0,
                              ),
                              child: _isSubmitting
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          const _OrDivider(),
                          const SizedBox(height: 16),

                          const _ProviderButton(label: "Google", icon: Icons.g_mobiledata),
                          const SizedBox(height: 12),

                          const _ProviderButton(label: "Outlook", icon: Icons.email),

                          const SizedBox(height: 10),

                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: const Center(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Already have an account? ",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF7B8B8F),
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Login",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
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

class _AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;
  final bool showEye;

  const _AuthTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.showEye = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
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
              controller: controller,
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
            const Icon(
              Icons.visibility_off_outlined,
              color: Color(0xFF7B8B8F),
            ),
        ],
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider(color: Color(0xFF959999), thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "Or",
            style: TextStyle(color: Color(0xFF959999), fontSize: 14),
          ),
        ),
        Expanded(child: Divider(color: Color(0xFF959999), thickness: 1)),
      ],
    );
  }
}

class _ProviderButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const _ProviderButton({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFFE0EDF0),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFF959999)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4285F4)),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
