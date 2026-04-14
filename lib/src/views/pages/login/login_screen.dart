import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0.rw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.0.rh),
              AppText.heading(s.welcome),
              SizedBox(height: 8.0.rh),
              AppText(
                s.loginContinue,
                color: AppColors.textMuted,
              ),
              SizedBox(height: 48.0.rh),
              AppInput(
                labelText: s.phoneNumber,
                // prefixIcon: const Icon(Icons.phone_outlined),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 24.0.rh),
              AppButton(
                text: s.login,
                onPressed: () {},
                type: AppButtonType.secondary,
              ),
              const Spacer(),
              Center(
                child: AppText(
                  s.appName,
                  type: AppTextType.label,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 16.0.rh),
            ],
          ),
        ),
      ),
    );
  }
}