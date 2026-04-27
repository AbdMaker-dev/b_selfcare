import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';



class PhoneNumberWidget extends StatelessWidget {
  final String phone;
  const PhoneNumberWidget({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            Icons.phone_outlined,
            size: 13.rsp,
            color: AppColors.textMuted,
          ),
        ),
        SizedBox(width: 8.rw),
        AppText(
          '${phone}',
          fontSize: 13.5.rsp,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}