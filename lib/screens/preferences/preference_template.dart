// lib/screens/preferences/preference_template.dart
import 'package:flutter/material.dart';

class PreferenceOption<T> {
  final String label;
  final T value;

  PreferenceOption({required this.label, required this.value});
}

class PreferenceTemplate<T> extends StatelessWidget {
  final String question;
  final List<PreferenceOption<T>> options;
  final T? selected;
  final void Function(T value) onChanged;
  final VoidCallback onNext;

  const PreferenceTemplate({
    super.key,
    required this.question,
    required this.options,
    required this.selected,
    required this.onChanged,
    required this.onNext,
  });

 
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
            bottom: 80,
            left: -60,
            child: Image.asset(
              'assets/small circular 4.1.png',
              width: 310,
              height: 310,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),

                // ===== TOP: BACK BUTTON =====
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Align(
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
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                // ===== CENTER: QUESTION + OPTIONS =====
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            question,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A5D68),
                            ),
                          ),
                          const SizedBox(height: 40),

                          // buttons list
                          for (final opt in options) ...[
                            _PreferenceButton(
                              label: opt.label,
                              isSelected: selected == opt.value,
                              onTap: () => onChanged(opt.value),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),

                // ===== BOTTOM: "Next →" =====
                Padding(
                  padding:
                      const EdgeInsets.only(right: 30, left: 30, bottom: 24),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: onNext,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: Colors.black,
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

class _PreferenceButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PreferenceButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
