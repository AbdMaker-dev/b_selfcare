import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';

enum AppButtonType { primary, secondary, outline, none }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final AppButtonType type;
  final double? width;
  final double? height;
  final IconData? icon;
  final Color? textColor;
  final double? fontSize;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.type = AppButtonType.primary,
    this.width,
    this.height,
    this.icon,
    this.textColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null && !isLoading;
    
    Color backgroundColor;
    Color txtColor;
    BorderSide borderSide = BorderSide.none;

    switch (type) {
      case AppButtonType.primary:
        backgroundColor = AppColors.primary;
        txtColor = textColor ?? Colors.white;
        break;
      case AppButtonType.secondary:
        backgroundColor = AppColors.secondary;
        txtColor = textColor ?? AppColors.primary;
        break;
      case AppButtonType.outline:
        backgroundColor = Colors.transparent;
        txtColor = textColor ?? AppColors.primary;
        borderSide =  BorderSide(color: textColor ?? AppColors.inputBorder, width: 1.5);
        break;
        case AppButtonType.none:
        backgroundColor = Colors.transparent;
        txtColor = textColor ?? AppColors.primary;
        borderSide =  BorderSide.none;
        break;
    }

    final effectiveColor = isEnabled || backgroundColor == Colors.transparent
        ? backgroundColor
        : backgroundColor.withValues(alpha: 0.6);
    final effectiveTxtColor = isEnabled ? (textColor ?? txtColor) : (textColor ?? txtColor).withValues(alpha: 0.6);

    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        width: width ?? double.infinity,
        height: (height ?? 63).rh,
        decoration: BoxDecoration(
          color: effectiveColor,
          borderRadius: BorderRadius.circular(12.rr),
          border: borderSide != BorderSide.none ? Border.all(color: borderSide.color, width: borderSide.width) : null,
        ),
        alignment: Alignment.center,
        child: isLoading
            ? SizedBox(
                height: 20.rh,
                width: 20.rh,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(effectiveTxtColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: fontSize ?? 18.rsp, color: effectiveTxtColor),
                    SizedBox(width: 8.rw),
                  ],
                  AppText(
                    text,
                    color: effectiveTxtColor,
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize ?? 19.rsp,
                    fontStyle: FontStyle.normal,
                  ),
                ],
              ),
      ),
    );
  }
}
