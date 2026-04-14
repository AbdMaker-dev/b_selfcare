import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';

enum AppTextType { body, heading, small, label }

class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final String? fontFamily;
  final AppTextType type;

  const AppText(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontFamily,
    this.type = AppTextType.body,
  });

  // Constructeurs nommés pour plus de simplicité
  factory AppText.heading(String text, {
    Key? key,
    Color? color,
    double? fontSize,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight? fontWeight,
  }) {
    return AppText(
      text,
      key: key,
      color: color,
      fontSize: fontSize,
      textAlign: textAlign,
      maxLines: maxLines,
      fontWeight: fontWeight,
      type: AppTextType.heading,
    );
  }

  factory AppText.small(String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return AppText(
      text,
      key: key,
      color: color,
      type: AppTextType.small,
    );
  }



  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle;
    
    switch (type) {
      case AppTextType.heading:
        defaultStyle = Theme.of(context).textTheme.headlineMedium!.copyWith(
          fontFamily: 'Montserrat',
          color: color ?? AppColors.textHeading,
          fontSize: fontSize,
          fontWeight: fontWeight,
        );
        break;
      case AppTextType.small:
        defaultStyle = Theme.of(context).textTheme.bodySmall!.copyWith(
          color: color ?? AppColors.textMuted,
          fontSize: fontSize,
          fontWeight: fontWeight,
        );
        break;
      case AppTextType.label:
        defaultStyle = Theme.of(context).textTheme.labelLarge!.copyWith(
          color: color ?? AppColors.textHeading,
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.w400,
          height: 1.0,
          letterSpacing: 0.0,
        );
        break;
      case AppTextType.body:
      // ignore: unreachable_switch_default
      default:
        defaultStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: color ?? AppColors.textBody,
          fontSize: fontSize,
          fontWeight: fontWeight,
        );
        break;
    }

    // On fusionne avec le style passé en paramètre si présent
    final finalStyle = defaultStyle.merge(style).copyWith(
      color: color,
      fontSize: fontSize?.rsp,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      fontFamily: fontFamily,
    );

    return Text(
      text,
      style: finalStyle,
      textAlign: textAlign ?? (type == AppTextType.label ? TextAlign.center : null),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
