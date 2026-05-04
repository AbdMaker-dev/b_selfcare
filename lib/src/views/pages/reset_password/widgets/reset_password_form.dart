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

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final resetCubit = getIt<ResetPasswordCubit>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      bloc: resetCubit,
      listener: (context, state) {
        state.maybeWhen(
            resetPasswordFailed: (message){
            },
            resetPasswordError: (data){
            },
            orElse: (){}
        );
      },
      builder: (context, state) {
        return state is ResetPasswordLoaded ?
        SendMailMessage(
          emailSentDescription: s.emailSentDescription,
          emailSentTitle:  s.emailSentTitle,
          icon: Icons.mark_email_read_outlined,
          isNotSend: true,
        ):
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText.textHighlight(
              "${s.titlereset}\n${s.pwd}",
              highlight: s.pwd,
              highlightHeight: 0.68,
              fontSize: 46.rsp,
              highlightFontSize: 46.rsp,
              color: AppColors.primary,
              fontWeight: FontWeight.w900,
              highlightColor: AppColors.secondary,
              fontStyle: FontStyle.italic,
              textAlign: TextAlign.center
            ),
            SizedBox(height: 40.0.rh),
            AppInput(
              labelText: s.email,
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            SizedBox(height: 50.0.rh),
            AppButton(
              text: s.resetPwd,
              onPressed: () {
                resetCubit.forgetPassword(email: _emailController.text);
                //context.router.replaceAll([ChangePasswordRoute()]);
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
