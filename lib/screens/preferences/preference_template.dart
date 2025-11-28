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
          // you can reuse your circle background here like other screens...

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // back + status bar etc. (you can copy from signup)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text(
                    question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A5D68),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Options
                  for (final opt in options) ...[
                    _PreferenceButton(
                      label: opt.label,
                      isSelected: selected == opt.value,
                      onTap: () => onChanged(opt.value),
                    ),
                    const SizedBox(height: 16),
                  ],

                  const Spacer(),

                  // Next ->
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: onNext,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Next',
                            style: TextStyle(
                              color: Color(0xFF1A5D68),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward, size: 16, color: Color(0xFF1A5D68)),
                        ],
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
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A5D68) : const Color(0xFFE0EDF0),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xFF959999),
            width: isSelected ? 0 : 1,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF1A5D68),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
