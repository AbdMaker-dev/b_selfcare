import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/routers/app_router.dart';
import 'package:b_selfcare/routers/app_router.gr.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/login/cubit/login_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_checkbox.dart';
import 'package:b_selfcare/src/views/widgets/app_indicator.dart';
import 'package:b_selfcare/src/views/widgets/app_otp_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key, required this.mfaToken});
  final String mfaToken;

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late String _mfaToken = widget.mfaToken;
  String _code = '';
  bool _isComplete = false;
  bool _canResend = false;
  int currentStep = 1;

  Map<String, dynamic> get _payload => {
    'mfa_token': _mfaToken,
    'code': _code,
  };

  Map<String, dynamic> get _resendPayload => {
    'mfa_token': _mfaToken,
  };

  Future<void> _submit() async {
    final cubit = getIt<LoginCubit>();
    await cubit.verifyOtp(_payload);
  }

  Future<void> _resend() async {
    final cubit = getIt<LoginCubit>();
    await cubit.resendOtp(_resendPayload);
  }

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
            currentStep: currentStep,
            steps: [s.stepCredentials, s.verification, s.stepAccess],
          ),
          SizedBox(height: 40.rh),
          BlocListener<LoginCubit, LoginState>(
            bloc: getIt<LoginCubit>(),
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                resendOtpSuccess: (mfaToken) {
                  setState(() => _mfaToken = mfaToken);
                },
                otpSuccess: () async {
                  setState(() => currentStep = 2);
                  await Future.delayed(const Duration(seconds: 3), () {});
                  // ignore: use_build_context_synchronously
                  if (context.mounted) context.router.pop();
                  // ignore: use_build_context_synchronously
                  if (context.mounted) context.router.pushPath('$routeApp/$routeAppDashbord');
                },
              );
            },
            child: AppText.textHighlight(
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
            )
          ),
          SizedBox(height: 10.rh),
          AppText(
            s.otpSubtitle,
            fontSize: 12.rsp,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30.rh),
          SizedBox(
            width: 400.rw,
            child: AppOtpInput(
            length: 6,
            enableAutofill: true,
            onChanged: (value) {
              _code = value;
              if (_isComplete) setState(() => _isComplete = false);
            },
            onCompleted: (value) {
              _code = value;
              setState(() => _isComplete = true);
              _submit();
            },
          ),
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
                  onCheck: (value) => setState(() => _canResend = value),
                ),
                AppText(
                  s.resend,
                  color: _canResend ? AppColors.primary : AppColors.inputBorderLight,
                  fontSize: 12.rsp,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  onClick: _canResend ? _resend : null,
                  type: AppTextType.heading,
                ),
              ],
            ),
          ),
          SizedBox(height: 40.rh),
          if(currentStep == 2)
            AppButton(
            width: 450.rw,
            text: s.verifyCode,
            onPressed: () {
              context.router.pop();
              context.router.replaceAll([DashboardRoute()]);
            },
            type: AppButtonType.primary,
            icon: Icons.check,
            color: AppColors.success,
          )
          else 
          AppButton(
            width: 450.rw,
            text: s.verifyCode,
            onPressed: _isComplete ? _submit : null,
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
            onClick: () => context.pop(),
            type: AppTextType.heading,
          ),
        ],
      ),
    );
  }
}
