import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginOtpScreen extends StatefulWidget {
  const LoginOtpScreen({super.key});

  @override
  State<LoginOtpScreen> createState() => _LoginOtpScreenState();
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0.rw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.textHighlight(s.verification),
              SizedBox(height: 8.0.rh),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textMuted,
                    fontSize: 16.rsp,
                  ),
                  children: [
                    TextSpan(text: '${s.otpSentTo} '),
                    const TextSpan(
                      text: '+221 77 XXX XX XX',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        color: AppColors.textHeading,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 48.0.rh),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  4,
                  (index) => SizedBox(
                    width: 70.rw,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.rr),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 24.rsp,
                        fontWeight: FontWeight.bold,
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.0.rh),
              AppButton(
                text: s.verify,
                onPressed: () {},
                type: AppButtonType.secondary,
              ),
              SizedBox(height: 24.0.rh),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: AppText(
                    s.resendCode,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
