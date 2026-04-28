import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';


class CellTextTable extends StatelessWidget {
  final String text;
  final String? sub;
  const CellTextTable({super.key, required this.text, this.sub});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(
          text,
          fontSize: 13.rsp,
          color: AppColors.textHeading,
            fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
        ),
        if (sub != null)
          AppText(
            sub ?? "",
            fontSize: 11.5.rsp,
            color: AppColors.textMuted,
          ),
      ],
    );
  }
}