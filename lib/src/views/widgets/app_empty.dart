import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppEmpty extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const AppEmpty({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 60.rh, horizontal: 24.rw),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72.rw,
              height: 72.rw,
              decoration: BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.inputBorder, width: 1.5),
              ),
              child: Icon(
                icon,
                size: 32.rsp,
                color: AppColors.textMuted,
              ),
            ),
            SizedBox(height: 16.rh),
            AppText(
              title,
              type: AppTextType.heading,
              fontSize: 15.rsp,
              fontWeight: FontWeight.w600,
              color: AppColors.textHeading,
            ),
            if (subtitle != null) ...[
              SizedBox(height: 6.rh),
              AppText(
                subtitle!,
                fontSize: 13.rsp,
                color: AppColors.textMuted,
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              SizedBox(height: 24.rh),
              SizedBox(
                width: 200.rw,
                child: AppButton(
                  text: actionLabel!,
                  onPressed: onAction,
                  type: AppButtonType.secondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
