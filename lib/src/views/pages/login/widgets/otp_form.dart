import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_checkbox.dart';
import 'package:b_selfcare/src/views/widgets/app_indicator.dart';
import 'package:b_selfcare/src/views/widgets/app_otp_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return SizedBox(
      width: 450.rw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30.rh),
          AppStepIndicator(
            currentStep: 1,
            steps: [s.stepCredentials, s.verification, s.stepAccess],
          ),
          SizedBox(height: 20.rh),
          AppText.textHighlight(
            s.otpTitle,
            highlight: s.otpTitleHighlight,
            highlightHeight: 0.68,
            fontSize: 54.rsp,
            highlightFontSize: 54.rsp,
            color: AppColors.primary,
            fontWeight: FontWeight.w900,
            highlightColor: AppColors.secondary,
            fontStyle: FontStyle.italic,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15.rh),
          AppText(
            s.otpSubtitle,
            fontSize: 22.rsp,
            type: AppTextType.heading,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30.rh),
          AppOtpInput(
            length: 6,
            onChanged: (value) => print("En cours : $value"),
            onCompleted: (pin) {
            },
          ),
          SizedBox(height: 10.rh),
          SizedBox(
            width: 450.rw,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppCheckbox(
                  text: s.otpNotReceived,
                  fontSize: 24.rsp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.inputBorderLight,
                  onCheck: (value) {},
                ),
                AppText(
                  s.resend,
                  color: AppColors.inputBorderLight,
                  fontSize: 24.rsp,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  onClick: () {},
                  type: AppTextType.heading,
                ),
              ],
            ),
          ),
          SizedBox(height: 30.rh),
          AppButton(
            width: 450.rw,
            text: s.verifyCode,
            onPressed: () {},
            type: AppButtonType.primary,
            icon: Icons.arrow_forward,
          ),
          SizedBox(height: 20.rh),
          AppText(
            s.backToLogin,
            color: AppColors.inputBorderLight,
            fontSize: 24.rsp,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
            onClick: () {},
            type: AppTextType.heading,
          ),
        ],
      ),
    );
  }
}
