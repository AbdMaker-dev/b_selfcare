import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

class EmptyTable extends StatelessWidget {
  final String message;
  const EmptyTable({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.rh),
      child: Center(
        child: AppText(
          message,
          fontSize: 14.rsp,
          color: AppColors.grayAsh,
        ),
      ),
    );
  }
}