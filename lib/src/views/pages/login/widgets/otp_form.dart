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
    return SizedBox(
      width: 400.rw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30.rh),
          AppStepIndicator(
            currentStep: 1,
            steps: const ['Identifiants', 'Vérification', 'Accès'],
          ),
          SizedBox(height: 20.rh),
          AppText.textHighlight(
            "Vérification OTP",
            highlight: "OTP",
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
            "Saisissez le code à 6 chiffres envoyé à l’adresse e-mail enregistre",
            fontSize: 14.5.rsp,
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
            width: 400.rw,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppCheckbox(
                  text: "Vous n'avez pas reçu le code ?",
                  fontSize: 16.rsp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.inputBorderLight,
                  onCheck: (value) {},
                ),
                AppText(
                  "Renvoyer",
                  color: AppColors.inputBorderLight,
                  fontSize: 16.rsp,
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
            width: 400.rw,
            text: "Vérifier le code",
            onPressed: () {},
            type: AppButtonType.primary,
            icon: Icons.arrow_forward,
          ),
          SizedBox(height: 20.rh),
          AppText(
            "← Retour à la connexion",
            color: AppColors.inputBorderLight,
            fontSize: 18.rsp,
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
