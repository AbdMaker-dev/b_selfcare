import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/routers/app_router.gr.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/reset_password/cubit/reset_password_cubit.dart';
import 'package:b_selfcare/src/views/pages/reset_password/widgets/otp_reset_form.dart';
import 'package:b_selfcare/src/views/pages/reset_password/widgets/send_mail_message.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/ctrt_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordForm extends StatefulWidget {
  final String token;
  final String email;

  const ChangePasswordForm({
    super.key,
    required this.token,
    required this.email,
  });

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final resetCubit = getIt<ResetPasswordCubit>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      bloc: resetCubit,
      listener: (context, state) {
        state.maybeWhen(
          changePasswordFailed: (message) {},
          changePasswordError: (data) {},
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state is ChangePasswordLoaded ?
        SendMailMessage(
          emailSentDescription: state.data.message ?? "",
          emailSentTitle:  s.pwdChangement,
          icon: Icons.mark_chat_read_sharp,
        ) :
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            SizedBox(height: 40.0.rh),
            AppInput(
              labelText: s.newPassword,
              keyboardType: TextInputType.text,
              isPassword: true,
              controller: _newPasswordController,
            ),
            SizedBox(height: 20.rh),
            AppInput(
              labelText: s.confirmPassword,
              keyboardType: TextInputType.text,
              controller: _confirmPasswordController,
              isPassword: true,
            ),
            SizedBox(height: 50.0.rh),
            AppButton(
              text: s.resetPwd,
              onPressed: () {
                resetCubit.resetPassword(
                  email: widget.email,
                  password: _newPasswordController.text,
                  passwordConfirmation: _confirmPasswordController.text,
                  token: widget.token,
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
      },
    );
  }
}
