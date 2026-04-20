import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/reset_password/widgets/new_password_step.dart';
import 'package:b_selfcare/src/views/pages/reset_password/widgets/otp_step.dart';
import 'package:flutter/material.dart';

class OtpResetForm extends StatefulWidget {
  const OtpResetForm({super.key});

  @override
  State<OtpResetForm> createState() => _OtpResetFormState();
}

class _OtpResetFormState extends State<OtpResetForm> {
  int _currentStep = 0;
  String _otpValue = '';
  bool _isOtpComplete = false;

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handlePasswordReset() {
    final newPwd = _newPasswordController.text;
    final confirmPwd = _confirmPasswordController.text;
    if (newPwd.isEmpty || confirmPwd.isEmpty || newPwd != confirmPwd) return;

    // TODO: appeler votre BLoC / use case ici
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450.rw,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
        child: _currentStep == 0 ? OtpStep(
          isOtpComplete: _isOtpComplete,
          onChanged: (value) => setState(() {
            _otpValue = value;
            _isOtpComplete = value.length == 6;
          }),
          onCompleted: (pin) => setState(() {
            _otpValue = pin;
            _isOtpComplete = true;
          }),
          onVerify: () => setState(() => _currentStep = 1),
          onResend: () {
            // TODO: renvoyer le code OTP
          },
          onBack: () => Navigator.of(context).pop(),
        ): NewPasswordStep(
          newPasswordController: _newPasswordController,
          confirmPasswordController: _confirmPasswordController,
          onConfirm: _handlePasswordReset,
          onBack: () => setState(() => _currentStep = 0),
        ),
      ),
    );
  }
}
