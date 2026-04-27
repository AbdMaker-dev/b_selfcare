import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

class HeaderTable extends StatelessWidget {
  final List<({String label, int flex})> columns;
  const HeaderTable({required this.columns});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.gray,width: 2.rw)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.rw),
      child: Row(
        children: columns
            .map((c) => Expanded(
          flex: c.flex,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 10.rh),
            child: AppText(
              c.label.toUpperCase(),
              fontSize: 10.5.rsp,
              color: AppColors.textMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
        ))
            .toList(),
      ),
    );
  }
}