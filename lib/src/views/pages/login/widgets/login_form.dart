import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/routers/app_router.gr.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/login/widgets/otp_form.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_checkbox.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/ctrt_dialogs.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText.textHighlight(
          "Connexion à votre \nespace",
          highlight: "espace",
          highlightHeight: 0.68,
          fontSize: 40.rsp,
          highlightFontSize: 94.rsp,
          color: AppColors.primary,
          fontWeight: FontWeight.w900,
          highlightColor: AppColors.secondary,
          fontStyle: FontStyle.italic,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40.0.rh),
        AppInput(labelText: s.phoneNumber, keyboardType: TextInputType.phone),
        SizedBox(height: 24.0.rh),
        AppInput(
          labelText: "Mot de passe",
          labelActionText: "Mot de passe oublié",
          keyboardType: TextInputType.text,
          isPassword: true,
          labelActionOnTap: () {
            context.router.replaceAll([const SplashRoute()]);
          },
        ),
        SizedBox(height: 15.0.rh),
        AppCheckbox(
          text: "Rester connecté",
          fontSize: 14.rsp,
          fontWeight: FontWeight.w500,
          color: AppColors.inputBorderLight,
          onCheck: (value) {},
        ),
        SizedBox(height: 30.0.rh),
        AppButton(
          text: s.login,
          onPressed: () {
            AppDialogs.popup(
              context: context,
              width: 592.rw,
              height: 0.45,
              contents: OtpForm(),
            );
          },
          type: AppButtonType.primary,
          icon: Icons.arrow_forward,
        ),
  
        SizedBox(height: 30.0.rh),
        Row(
          spacing: 10.rw,
          children: [
            Expanded(child: Container(height: 1.rh, color: AppColors.primary)),
            AppText("OU", color: AppColors.black, fontSize: 12.rsp, fontWeight: FontWeight.w600, textAlign: TextAlign.center, type: AppTextType.heading),
            Expanded(child: Container(height: 1.rh, color: AppColors.primary)),
          ],
        ),

        SizedBox(height: 30.0.rh),
        AppButton(
          text: "Connexion SSO Entreprise",
          onPressed: () {},
          type: AppButtonType.outline,
          icon: Icons.corporate_fare,
        ),

        SizedBox(height: 20.0.rh),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5.rw,
          children: [
            AppText(
              "Besoin d'aide ?",
              color: AppColors.inputBorderLight,
              fontSize: 19.rsp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              type: AppTextType.heading,
            ),
            AppText(
              "Contactez le support YAS",
              color: AppColors.primary,
              fontSize: 19.rsp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              onClick: () {},
              type: AppTextType.heading,
            ),
          ],
        ),
      ],
    );
  }
}
