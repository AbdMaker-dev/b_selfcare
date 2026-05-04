import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/routers/app_router.gr.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

class SendMailMessage extends StatelessWidget {
  String emailSentTitle;
  String emailSentDescription;
  bool isNotSend;
  IconData icon;

  SendMailMessage({
    super.key,
    required this.emailSentTitle,
    required this.emailSentDescription,
    required this.icon,
    this.isNotSend = false,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 80.0.rsp, color: AppColors.secondary),
        SizedBox(height: 24.0.rh),
        AppText.textHighlight(
          emailSentTitle,
          highlight: emailSentTitle,
          highlightHeight: 0.68,
          fontSize: 28.rsp,
          highlightFontSize: 28.rsp,
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
          highlightColor: AppColors.primary,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.0.rh),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            emailSentDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.rsp,
              color: AppColors.primary.withOpacity(0.7),
            ),
          ),
        ),
        SizedBox(height: 40.0.rh),
        isNotSend
            ? GestureDetector(
                onTap: () {},
                child: AppText(
                  s.resendLink,
                  type: AppTextType.label,
                  fontSize: 14.rsp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            : SizedBox(),
        SizedBox(height: isNotSend ? 20.0.rh : 1.rh),
        AppButton(
          text: s.login,
          onPressed: () {
            context.router.replaceAll([LoginRoute()]);
          },
          type: AppButtonType.outline,
          icon: Icons.arrow_back,
        ),
      ],
    );
  }
}
