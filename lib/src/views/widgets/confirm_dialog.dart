import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/ctrt_dialogs.dart';
import 'package:flutter/material.dart';

class AppConfirmDialog {
  AppConfirmDialog._();

  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmLabel = 'Confirmer',
    String cancelLabel = 'Annuler',
    bool isDanger = false,
  }) {
    AppDialogs.popup(
      context: context,
      width: 400.rw,
      height: 0.2,
      bottomPad: 0,
      contents: _ConfirmContent(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDanger: isDanger,
        onConfirm: onConfirm,
      ),
    );
  }
}

class _ConfirmContent extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDanger;
  final VoidCallback onConfirm;

  const _ConfirmContent({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.isDanger,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.rw),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.rw),
                decoration: BoxDecoration(
                  color: (isDanger ? AppColors.error : AppColors.primary).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.rr),
                ),
                child: Icon(
                  isDanger ? Icons.warning_amber_rounded : Icons.help_outline_rounded,
                  color: isDanger ? AppColors.error : AppColors.primary,
                  size: 20.rsp,
                ),
              ),
              SizedBox(width: 12.rw),
              Expanded(
                child: AppText(
                  title,
                  fontSize: 15.rsp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textHeading,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.rh),
          AppText(
            message,
            fontSize: 14.rsp,
            color: AppColors.textBody,
          ),
          SizedBox(height: 24.rh),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: cancelLabel,
                  type: AppButtonType.outline,
                  height: 44,
                  fontSize: 13.rsp,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              SizedBox(width: 12.rw),
              Expanded(
                child: AppButton(
                  text: confirmLabel,
                  height: 44,
                  fontSize: 13.rsp,
                  color: isDanger ? AppColors.error : AppColors.primary,
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirm();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
