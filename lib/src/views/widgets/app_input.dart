import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';

class AppInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? labelActionText;
  final bool isPassword;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool readOnly;
  final VoidCallback? onTap, labelActionOnTap;
  final double? width;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final Iterable<String>? autofillHints;

  const AppInput({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.labelActionText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.labelActionOnTap,
    this.width,
    this.focusNode,
    this.nextFocusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autofillHints,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.labelText != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  widget.labelText!,
                  type: AppTextType.label,
                  fontSize: 14.rsp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start,
                ),
                if (widget.labelActionText != null)
                  AppText(
                    widget.labelActionText!,
                    type: AppTextType.label,
                    fontSize: 14.rsp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.start,
                    onClick: widget.labelActionOnTap,
                  ),
              ],
            ),
            SizedBox(height: 8.0.rh),
          ],
          TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            obscureText: widget.isPassword ? _obscureText : false,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            onChanged: widget.onChanged,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            textInputAction: widget.textInputAction ??
                (widget.nextFocusNode != null
                    ? TextInputAction.next
                    : widget.onFieldSubmitted != null
                        ? TextInputAction.done
                        : null),
            autofillHints: widget.autofillHints,
            onFieldSubmitted: (value) {
              if (widget.nextFocusNode != null) {
                FocusScope.of(context).requestFocus(widget.nextFocusNode);
              }
              widget.onFieldSubmitted?.call(value);
            },
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16.rsp,
              fontWeight: FontWeight.w500,
              color: AppColors.textHeading,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: widget.prefixIcon,
              suffixIcon:
                  widget.isPassword
                      ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.textMuted,
                          size: 16.rsp,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                      : widget.suffixIcon,
              hintStyle: TextStyle(
                fontFamily: 'Montserrat',
                color: AppColors.textMuted,
                fontSize: 14.rsp,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15.rw,
                vertical: 0.rh,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.rr),
                borderSide: BorderSide(
                  color: AppColors.inputBorder,
                  width: 1.6.rh,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.rr),
                borderSide: BorderSide(color: AppColors.primary, width: 1.6.rh),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.rr),
                borderSide: BorderSide(color: AppColors.error, width: 1.6.rh),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.rr),
                borderSide: BorderSide(color: AppColors.error, width: 1.6.rh),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
