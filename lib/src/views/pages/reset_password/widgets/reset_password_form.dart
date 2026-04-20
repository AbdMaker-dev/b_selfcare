import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/routers/app_router.gr.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/login/widgets/otp_form.dart';
// import 'package:b_selfcare/src/views/pages/login/widgets/otp_form.dart';
import 'package:b_selfcare/src/views/pages/reset_password/widgets/otp_reset_form.dart';
// import 'package:b_selfcare/src/views/pages/reset_password/widgets/otp_step.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/ctrt_dialogs.dart';
import 'package:flutter/material.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText.textHighlight(
          "${s.titlereset}\n\n${s.pwd}",
          highlight: s.pwd,
          highlightHeight: 0.68,
          fontSize: 40.rsp,
          highlightFontSize: 94.rsp,
          color: AppColors.primary,
          fontWeight: FontWeight.w900,
          highlightColor: AppColors.secondary,
          fontStyle: FontStyle.italic,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 45.0.rh),
        AppInput(labelText: s.phoneNumber, keyboardType: TextInputType.phone),
        SizedBox(height: 50.0.rh),
        AppButton(
          text: s.resetPwd,
          onPressed: () {
            AppDialogs.popup(
              context: context,
              width: 530.rw,
              height: 0.6,
              contents: OtpResetForm(),
            );
          },
          type: AppButtonType.primary,
          icon: Icons.arrow_forward,
        ),
        SizedBox(height: 30.0.rh),
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
