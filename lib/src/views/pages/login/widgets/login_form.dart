import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/routers/app_router.gr.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_validators.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/login/cubit/login_cubit.dart';
import 'package:b_selfcare/src/views/pages/login/widgets/otp_form.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_checkbox.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/views/widgets/app_keyboard_form.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/ctrt_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFocus = FocusNode();
  late final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _emailController.clear();
      _passwordController.clear();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Map<String, dynamic> get _payload => {
    'email': _emailController.text.trim(),
    'password': _passwordController.text,
  };

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final cubit = getIt<LoginCubit>();
    await cubit.login(_payload);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return AppKeyboardForm(
      formKey: _formKey,
      onSubmit: _submit,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocListener<LoginCubit, LoginState>(
              bloc: getIt<LoginCubit>(),
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  success: (mfaToken) {
                    AppDialogs.popup(
                      context: context,
                      width: 530.rw,
                      height: 0.5,
                      contents: OtpForm(mfaToken: mfaToken),
                    );
                  },
                  otpSuccess: () {
                    _emailController.clear();
                    _passwordController.clear();
                    _formKey.currentState?.reset();
                  },
                );
              },
              child: AppText.textHighlight(
                s.loginTitle,
                highlight: s.loginTitleHighlight,
                highlightHeight: 0.68,
                fontSize: 40.rsp,
                highlightFontSize: 94.rsp,
                color: AppColors.primary,
                fontWeight: FontWeight.w900,
                highlightColor: AppColors.secondary,
                fontStyle: FontStyle.italic,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40.0.rh),
            AppInput(
              controller: _emailController,
              labelText: s.email,
              keyboardType: TextInputType.emailAddress,
              validator: AppValidators.email(context),
              nextFocusNode: _passwordFocus,
            ),
            SizedBox(height: 24.0.rh),
            AppInput(
              focusNode: _passwordFocus,
              controller: _passwordController,
              labelText: s.password,
              labelActionText: s.forgotPassword,
              keyboardType: TextInputType.text,
              isPassword: true,
              validator: AppValidators.password(context),
              autofillHints: const [],
              labelActionOnTap: () {
                context.router.replaceAll([const ResetPasswordRoute()]);
              },
              onFieldSubmitted: (_) => _submit(),
            ),
            SizedBox(height: 15.0.rh),
          AppCheckbox(
            text: s.stayConnected,
            fontSize: 14.rsp,
            fontWeight: FontWeight.w500,
            color: AppColors.inputBorderLight,
            onCheck: (value) {},
          ),
          SizedBox(height: 30.0.rh),
          AppButton(
            text: s.login,
            onPressed: _submit,
            type: AppButtonType.primary,
            icon: Icons.arrow_forward,
          ),

          SizedBox(height: 30.0.rh),
          Row(
            spacing: 10.rw,
            children: [
              Expanded(child: Container(height: 1.rh, color: AppColors.primary)),
              AppText(s.or, color: AppColors.black, fontSize: 12.rsp, fontWeight: FontWeight.w600, textAlign: TextAlign.center, type: AppTextType.heading),
              Expanded(child: Container(height: 1.rh, color: AppColors.primary)),
            ],
          ),

          // SizedBox(height: 30.0.rh),
          // AppButton(
          //   text: s.ssoLogin,
          //   onPressed: () {},
          //   type: AppButtonType.outline,
          //   icon: Icons.corporate_fare,
          // ),

          SizedBox(height: 20.0.rh),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5.rw,
            children: [
              AppText(
                s.needHelp,
                color: AppColors.inputBorderLight,
                fontSize: 19.rsp,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                type: AppTextType.heading,
              ),
              AppText(
                s.contactSupport,
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
      ),
    );
  }
}
