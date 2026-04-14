import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AppOtpInput extends StatefulWidget {
  final int length;
  final String? labelText;
  final void Function(String)? onChanged;
  final void Function(String)? onCompleted;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool enableAutofill;

  const AppOtpInput({
    super.key,
    this.length = 6,
    this.labelText,
    this.onChanged,
    this.onCompleted,
    this.validator,
    this.obscureText = false,
    this.enableAutofill = true,
  });

  @override
  State<AppOtpInput> createState() => _AppOtpInputState();
}

class _AppOtpInputState extends State<AppOtpInput> {
  final PinInputController _pinController = PinInputController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null) ...[
          AppText(
            widget.labelText!,
            type: AppTextType.label,
            fontSize: 18.rsp,
            color: AppColors.primary,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: 8.0.rh),
        ],
        MaterialPinField(
          length: widget.length,
          pinController: _pinController,
          keyboardType: TextInputType.number,
          obscureText: widget.obscureText,
          enableAutofill: widget.enableAutofill,
          autofillHints: widget.enableAutofill
          ? const [AutofillHints.oneTimeCode]
          : null,
          onChanged: widget.onChanged,
          onCompleted: widget.onCompleted,
          // validator: widget.validator,
          // textStyle: TextStyle(
          //   fontFamily: 'Montserrat',
          //   fontSize: 24.rsp,
          //   fontWeight: FontWeight.w600,
          //   color: AppColors.textHeading,
          // ),
          theme: MaterialPinTheme(
            shape: MaterialPinShape.outlined, // bordure comme ton AppInput
            cellSize: Size(52.rw, 62.rh),     // taille de chaque case
            spacing: 10.rw,                   // espace entre les cases
            borderRadius: BorderRadius.circular(12.rr),

            // Bordures
            borderWidth: 1.6.rh,
            focusedBorderWidth: 2.2.rh,
            borderColor: AppColors.inputBorder,
            focusedBorderColor: AppColors.primary,
            errorColor: AppColors.error,

            // Fond
            fillColor: Colors.white,
            focusedFillColor: Colors.white,
            filledFillColor: Colors.white,

            // Curseur
            showCursor: true,
            cursorColor: AppColors.primary,
            cursorWidth: 2,

            // Animation
            entryAnimation: MaterialPinAnimation.scale,
            animationDuration: const Duration(milliseconds: 200),
          ),
          errorTextStyle: TextStyle(
            fontFamily: 'Montserrat',
            color: AppColors.error,
            fontSize: 14.rsp,
          ),
        ),
      ],
    );
  }
}