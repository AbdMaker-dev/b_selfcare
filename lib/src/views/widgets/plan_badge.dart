import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive_extention.dart';


class PlanBadge extends StatelessWidget {
  final String plan;

  const PlanBadge({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 10.rw, vertical: 5.rh),
      decoration: BoxDecoration(
        color:  AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.gray),
      ),
      child:
      AppText(
        '${plan}',
        fontSize: 11.rsp,
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w600,
      )
    );
  }
}