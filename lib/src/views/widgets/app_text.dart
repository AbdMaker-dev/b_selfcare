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

  final String? highlight;
  final Color? highlightColor;
  final double? highlightFontSize;
  final double? highlightHeight;
  final VoidCallback? onClick;

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
    this.highlight,
    this.highlightColor,
    this.highlightFontSize,
    this.highlightHeight,
    this.onClick,
  });

  factory AppText.textHighlight(
    String text, {
    Key? key,
    Color? color,
    double? fontSize,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight? fontWeight,
    String? highlight,
    Color? highlightColor,
    double? highlightFontSize,
    double? highlightHeight,
    FontStyle? fontStyle,
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
      highlight: highlight,
      highlightColor: highlightColor,
      highlightFontSize: highlightFontSize,
      highlightHeight: highlightHeight,
      fontStyle: fontStyle,
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
          fontWeight: fontWeight ?? FontWeight.w800,
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

    final finalStyle = defaultStyle
        .merge(style)
        .copyWith(
          color: color,
          fontSize: (fontSize ?? defaultStyle.fontSize)?.rsp,
          fontWeight: fontWeight ?? defaultStyle.fontWeight,
          fontStyle: fontStyle,
          fontFamily: fontFamily ?? defaultStyle.fontFamily,
        );

    if (highlight != null && text.contains(highlight!)) {
      final parts = text.split(highlight!);
      final hColor = highlightColor ?? AppColors.secondary;
      return RichText(
        textAlign: textAlign ?? (type == AppTextType.label ? TextAlign.center : TextAlign.start),
        maxLines: maxLines,
        overflow: overflow ?? TextOverflow.clip,
        text: TextSpan(
          style: finalStyle.copyWith(height: 1.0),
          children:
              parts.asMap().entries.map((entry) {
                final idx = entry.key;
                final part = entry.value;

                return TextSpan(
                  children: [
                    TextSpan(text: part),
                    if (idx < parts.length - 1)
                      TextSpan(
                        text: highlight,
                        style: finalStyle.copyWith(
                          color: hColor,
                          fontSize:
                              highlightFontSize?.rsp ?? finalStyle.fontSize,
                          height: highlightHeight ?? 1.0,
                        ),
                      ),
                  ],
                );
              }).toList(),
        ),
      );
    }

    return InkWell(
      onTap: onClick,
      child: Text(
        text,
        style: finalStyle,
        textAlign: textAlign ?? (type == AppTextType.label ? TextAlign.center : null),
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }
}
