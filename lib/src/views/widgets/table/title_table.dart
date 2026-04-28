import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

class TitleTable extends StatelessWidget {
  final String title;
  const TitleTable({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:  EdgeInsets.fromLTRB(20.rw, 16.rh, 20.rw, 14.rh),
      decoration:  BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.gray)),
      ),
      child: AppText(
        '${title}',
        fontSize: 15.rsp,
        color: AppColors.textHeading,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}