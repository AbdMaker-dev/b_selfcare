import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({super.key, required this.password});

  static bool _hasLength(String p)  => p.length >= 8;
  static bool _hasUpper(String p)   => p.contains(RegExp(r'[A-Z]'));
  static bool _hasLower(String p)   => p.contains(RegExp(r'[a-z]'));
  static bool _hasDigit(String p)   => p.contains(RegExp(r'[0-9]'));
  static bool _hasSpecial(String p) => p.contains(RegExp(r'[!@#%^&*()\-_=+\[\]{};:,.<>?/|\\]'));

  static const List<(String, bool Function(String))> _rules = [
    ('Au moins 8 caractères',        _hasLength),
    ('Une lettre majuscule (A–Z)',    _hasUpper),
    ('Une lettre minuscule (a–z)',    _hasLower),
    ('Un chiffre (0–9)',              _hasDigit),
    ('Un caractère spécial (!@#...)', _hasSpecial),
  ];

  int get _score => _rules.where((r) => r.$2(password)).length;

  (String, Color) get _strength {
    final s = _score;
    if (s <= 1) return ('Très faible', AppColors.error);
    if (s == 2) return ('Faible',      Colors.orange);
    if (s == 3) return ('Moyen',       Colors.amber);
    if (s == 4) return ('Fort',        Colors.lightGreen.shade700);
    return ('Très fort', AppColors.success);
  }

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) return const SizedBox.shrink();

    final score = _score;
    final (label, color) = _strength;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.rh),

        // Barre de force
        Row(
          children: List.generate(5, (i) {
            final filled = i < score;
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 4,
                margin: EdgeInsets.only(right: i < 4 ? 4 : 0),
                decoration: BoxDecoration(
                  color: filled ? color : AppColors.gray,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
        ),

        SizedBox(height: 6.rh),

        // Étiquette
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppText('Force : ', fontSize: 11.rsp, color: AppColors.textMuted),
            AppText(label, fontSize: 11.rsp, fontWeight: FontWeight.w700, color: color),
          ],
        ),

        SizedBox(height: 10.rh),

        // Critères
        ...List.generate(_rules.length, (i) {
          final ok = _rules[i].$2(password);
          return Padding(
            padding: EdgeInsets.only(bottom: 4.rh),
            child: Row(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    ok ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                    key: ValueKey(ok),
                    size: 14.rsp,
                    color: ok ? AppColors.success : AppColors.grayAsh,
                  ),
                ),
                SizedBox(width: 6.rw),
                AppText(
                  _rules[i].$1,
                  fontSize: 11.rsp,
                  color: ok ? AppColors.textHeading : AppColors.grayAsh,
                  fontWeight: ok ? FontWeight.w600 : FontWeight.w400,
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
