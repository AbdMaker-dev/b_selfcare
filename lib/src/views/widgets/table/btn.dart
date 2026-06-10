import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

class Btn extends StatefulWidget {
  final String label;
  final bool danger;
  final VoidCallback? onTap;
  final IconData? icon;
  const Btn({required this.label, this.danger = false, this.onTap, this.icon});

  @override
  State<Btn> createState() => _BtnState();
}

class _BtnState extends State<Btn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.danger ? AppColors.orangeBurnt : AppColors.greyCharcoal;
    final borderColor = widget.danger ? AppColors.orangeSalmon : AppColors.gray;
    final hoverBg = widget.danger ? AppColors.orangePeach : AppColors.grayGh;

    if (widget.icon != null) {
      return Tooltip(
        message: widget.label,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: 30.rw,
              height: 30.rh,
              decoration: BoxDecoration(
                color: _hovered ? hoverBg : Colors.white,
                borderRadius: BorderRadius.circular(6.rr),
                border: Border.all(color: borderColor),
              ),
              child: Icon(widget.icon, size: 15.rsp, color: color),
            ),
          ),
        ),
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          constraints: BoxConstraints(minWidth: 40.rw, maxWidth: 120.rw),
          padding: EdgeInsets.symmetric(horizontal: 8.rw, vertical: 4.rh),
          decoration: BoxDecoration(
            color: _hovered ? hoverBg : Colors.white,
            borderRadius: BorderRadius.circular(6.rr),
            border: Border.all(color: borderColor),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: AppText(
              widget.label,
              fontSize: 13.rsp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
