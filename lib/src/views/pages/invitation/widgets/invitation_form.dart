import 'package:b_selfcare/routers/app_router.gr.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_validators.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/invitation/cubit/invitation_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/password_strength_indicator.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvitationForm extends StatefulWidget {
  final String token;
  const InvitationForm({super.key, required this.token});

  @override
  State<InvitationForm> createState() => _InvitationFormState();
}

class _InvitationFormState extends State<InvitationForm> {
  final _formKey = GlobalKey<FormState>();
  final _cubit = getIt<InvitationCubit>();
  late final _passwordController = TextEditingController();
  late final _confirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await _cubit.acceptInvitation(
      token: widget.token,
      password: _passwordController.text,
      passwordConfirmation: _confirmController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InvitationCubit, InvitationState>(
      bloc: _cubit,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          success: () {
            context.router.replaceAll([DashboardRoute()]);
          },
        );
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText.textHighlight(
              'Créer votre\nmot de passe',
              highlight: 'mot de passe',
              highlightHeight: 0.68,
              fontSize: 40.rsp,
              highlightFontSize: 50.rsp,
              color: AppColors.primary,
              fontWeight: FontWeight.w900,
              highlightColor: AppColors.secondary,
              fontStyle: FontStyle.italic,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.rh),
            AppText(
              'Bienvenue ! Définissez votre mot de passe\npour activer votre compte.',
              fontSize: 13.rsp,
              color: AppColors.textMuted,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 40.rh),
            AppInput(
              controller: _passwordController,
              labelText: 'Mot de passe',
              keyboardType: TextInputType.text,
              isPassword: true,
              validator: AppValidators.password(context),
            ),
            PasswordStrengthIndicator(password: _passwordController.text),
            SizedBox(height: 20.rh),
            AppInput(
              controller: _confirmController,
              labelText: 'Confirmer le mot de passe',
              keyboardType: TextInputType.text,
              isPassword: true,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Champ obligatoire';
                if (v != _passwordController.text) {
                  return 'Les mots de passe ne correspondent pas';
                }
                return null;
              },
            ),
            SizedBox(height: 40.rh),
            BlocBuilder<InvitationCubit, InvitationState>(
              bloc: _cubit,
              buildWhen: (_, s) => s.maybeWhen(
                submitting: () => true,
                success: () => true,
                error: (_) => true,
                orElse: () => false,
              ),
              builder: (context, state) {
                final isLoading = state.maybeWhen(
                  submitting: () => true,
                  orElse: () => false,
                );
                return AppButton(
                  text: 'Activer mon compte',
                  isLoading: isLoading,
                  onPressed: isLoading ? null : _submit,
                  type: AppButtonType.primary,
                  icon: Icons.check_circle_outline,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
