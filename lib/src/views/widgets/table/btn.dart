import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

class Btn extends StatefulWidget {
  final String label;
  final bool danger;
  final VoidCallback? onTap;
  const Btn({required this.label, this.danger = false, this.onTap});

  @override
  State<Btn> createState() => _BtnState();
}

class _BtnState extends State<Btn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          constraints: BoxConstraints(
            minWidth: 40.rw,
            maxWidth: 120.rw,   // évite un bouton trop large sur desktop
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 8.rw,
            vertical: 4.rh,
          ),
          decoration: BoxDecoration(
            color: _hovered
                ? (widget.danger ? AppColors.orangePeach : AppColors.grayGh)
                : Colors.white,
            borderRadius: BorderRadius.circular(6.rr),
            border: Border.all(
              color: widget.danger ? AppColors.orangeSalmon : AppColors.gray,
            ),
          ),
          child: FittedBox(                // ← scale le texte si espace insuffisant
            fit: BoxFit.scaleDown,
            child: AppText(
              widget.label,
              fontSize: 13.rsp,
              fontWeight: FontWeight.w500,
              color: widget.danger
                  ? AppColors.orangeBurnt
                  : AppColors.greyCharcoal,
            ),
          ),
        ),
      ),
    );
  }
}
