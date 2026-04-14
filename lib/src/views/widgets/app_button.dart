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
        borderSide =  BorderSide(color: textColor ?? AppColors.primary, width: 1.5);
        break;
        case AppButtonType.none:
        backgroundColor = Colors.transparent;
        txtColor = textColor ?? AppColors.primary;
        borderSide =  BorderSide.none;
        break;
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: (height ?? 63).rh,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          enableFeedback: false,
          backgroundColor: backgroundColor,
          foregroundColor: textColor?? txtColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.rr),
            side: borderSide,
          ),
          disabledBackgroundColor: backgroundColor.withValues(alpha: 0.6),
          disabledForegroundColor: (textColor??txtColor).withValues(alpha: 0.6),
        ),
        child: isLoading
        ? SizedBox(
            height: 20.rh,
            width: 20.rh,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(textColor?? txtColor),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18.rsp),
                SizedBox(width: 8.rw),
              ],
              AppText(
                text,
                color: textColor ?? txtColor,
                fontWeight: FontWeight.w700,
                fontSize: 19.rsp,
                fontStyle: FontStyle.normal,
              ),
            ],
          ),
      ),
    );
  }
}
