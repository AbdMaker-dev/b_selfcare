import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_utilitaire.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/phone_number_widget.dart';
import 'package:b_selfcare/src/views/widgets/plan_badge.dart';
import 'package:b_selfcare/src/views/widgets/status_badge.dart';
import 'package:b_selfcare/src/views/widgets/subscriber_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoFlotteCard extends StatelessWidget {
  final String name;
  final String department;
  final String phone;
  final String forfait;
  final bool status;

  const InfoFlotteCard({
    super.key,
    required this.name,
    required this.department,
    required this.phone,
    required this.forfait,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.rr),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SubscriberAvatar(colorAvatar: Colors.blue, initial: AppUtilitaire().getInitials(name)),
                SizedBox(width: 12.rw),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        '${name}',
                        fontSize: 18.rsp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        type: AppTextType.heading,
                      ),
                      //SizedBox(height: 2.rh),
                      AppText(
                        '${department}'.toUpperCase(),
                        fontSize: 15.rsp,
                        color: AppColors.textHeading,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.rh),
            PhoneNumberWidget(phone: phone),
             SizedBox(height: 16.rh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PlanBadge(plan: forfait),
                StatusBadge(isActive: status),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
