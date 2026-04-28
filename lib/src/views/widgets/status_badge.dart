import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';


class StatusBadge extends StatelessWidget {
  final bool isActive;

  const StatusBadge({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.success.withOpacity(0.08)
            :  AppColors.error.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive
              ? AppColors.success.withOpacity(0.25)
              : AppColors.error.withOpacity(0.25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5.rw,
            height: 5.rh,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.success
                  : AppColors.error,
              shape: BoxShape.circle,
            ),
          ),
           SizedBox(width: 5.rw),
          AppText(
            isActive ? 'ACTIF':"SUSPENDU",
            fontSize: 10.5.rsp,
            color: isActive ? AppColors.success : AppColors.error,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}