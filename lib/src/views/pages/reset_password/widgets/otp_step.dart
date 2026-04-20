import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_checkbox.dart';
import 'package:b_selfcare/src/views/widgets/app_indicator.dart';
import 'package:b_selfcare/src/views/widgets/app_otp_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

class OtpStep extends StatelessWidget {
  const OtpStep({
    super.key,
    required this.isOtpComplete,
    required this.onChanged,
    required this.onCompleted,
    required this.onVerify,
    required this.onResend,
    required this.onBack,
  });

  final bool isOtpComplete;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onCompleted;
  final VoidCallback onVerify;
  final VoidCallback onResend;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      key: const ValueKey('otp_step'),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 30.rh),
        AppStepIndicator(
          currentStep: 1,
          steps: [s.stepCredentials, s.verification, s.stepAccess],
        ),
        SizedBox(height: 40.rh),
        AppText.textHighlight(
          s.otpTitle,
          highlight: s.otpTitleHighlight,
          highlightHeight: 0.68,
          fontSize: 46.rsp,
          highlightFontSize: 46.rsp,
          color: AppColors.primary,
          fontWeight: FontWeight.w900,
          highlightColor: AppColors.secondary,
          fontStyle: FontStyle.italic,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.rh),
        AppText(
          s.otpSubtitle,
          fontSize: 12.rsp,
          type: AppTextType.heading,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30.rh),
        AppOtpInput(
          length: 6,
          enableAutofill: true,
          onChanged: onChanged,
          onCompleted: onCompleted,
        ),
        SizedBox(height: 10.rh),
        SizedBox(
          width: 400.rw,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppCheckbox(
                text: s.otpNotReceived,
                fontSize: 12.rsp,
                fontWeight: FontWeight.w500,
                color: AppColors.inputBorderLight,
                onCheck: (_) {},
              ),
              AppText(
                s.resend,
                color: AppColors.inputBorderLight,
                fontSize: 12.rsp,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                onClick: onResend,
                type: AppTextType.heading,
              ),
            ],
          ),
        ),
        SizedBox(height: 40.rh),
        AppButton(
          width: 450.rw,
          text: s.verifyCode,
          onPressed: isOtpComplete ? onVerify : null,
          type: AppButtonType.primary,
          icon: Icons.arrow_forward,
        ),
        SizedBox(height: 20.rh),
        AppText(
          s.backToLogin,
          color: AppColors.inputBorderLight,
          fontSize: 15.rsp,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.center,
          onClick: onBack,
          type: AppTextType.heading,
        ),
      ],
    );
  }
}
