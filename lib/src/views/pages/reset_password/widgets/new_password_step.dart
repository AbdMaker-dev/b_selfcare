import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_indicator.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

class NewPasswordStep extends StatelessWidget {
  const NewPasswordStep({
    super.key,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.onConfirm,
    required this.onBack,
  });

  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onConfirm;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.rw),
      width: 450.rw,
      child: Column(
        key: const ValueKey('password_step'),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30.rh),
          AppStepIndicator(
            currentStep: 2,
            steps: [s.stepCredentials, s.verification, s.stepAccess],
          ),
          SizedBox(height: 20.rh),
          AppText.textHighlight(
            "${s.titlereset}\n${s.newPwd}",
            highlight: s.newPwd,
            highlightHeight: 0.68,
            fontSize: 46.rsp,
            highlightFontSize: 46.rsp,
            color: AppColors.primary,
            fontWeight: FontWeight.w900,
            highlightColor: AppColors.secondary,
            fontStyle: FontStyle.italic,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30.rh),
          AppInput(
            width: 450.rw,
            labelText: s.newPassword,
            keyboardType: TextInputType.text,
            controller: newPasswordController,
            isPassword: true,
          ),
          SizedBox(height: 20.rh),
          AppInput(
            width: 450.rw,
            labelText: s.confirmPassword,
            keyboardType: TextInputType.text,
            controller: confirmPasswordController,
            isPassword: true,
          ),
          SizedBox(height: 40.rh),
          AppButton(
            width: 450.rw,
            text: s.confirm,
            onPressed: onConfirm,
            type: AppButtonType.primary,
            icon: Icons.check,
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
      ),
    );
  }
}