import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:flutter/material.dart';

class AppDialogs {
  static void bottomShette({
    required BuildContext context,
    required Widget content,
    isDis = true,
    double height = 0.95,
    bool isScrollControlled = false,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      enableDrag: isDis,
      isDismissible: isDis,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  width: 200,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: isScrollControlled 
                  ? SingleChildScrollView(
                      child: SizedBox(
                        width: double.infinity,
                        child: content,
                      ),
                    )
                  : SizedBox(width: double.infinity, child: content),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void popup({
  required BuildContext context,
  required Widget contents,
  bool isDis = true,
  double height = 0.95,
  double width = 300,
  double? bottomPad
}) {
  showDialog(
    context: context,
    barrierDismissible: isDis,
    barrierColor: AppColors.primary.withValues(alpha: 0.7),
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.rh),
        ),
        child: Container(
          width: width,
          height: MediaQuery.of(context).size.height * height,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(20.rr),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: bottomPad??100.rh),
            child: contents,
          ),
        ),
      );
    },
  );
}


}
