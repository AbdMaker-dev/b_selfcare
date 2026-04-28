import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CellMutedTable extends StatelessWidget {
  final String text;
  const CellMutedTable({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      fontSize: 12.5.rsp,
      color: AppColors.textMuted,
      overflow: TextOverflow.ellipsis,
    );
  }
}