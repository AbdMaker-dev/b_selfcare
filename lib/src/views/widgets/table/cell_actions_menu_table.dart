import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CellActionsMenuTable extends StatelessWidget {
  final List<({String label, bool danger, IconData icon, VoidCallback? onTap})> actions;

  const CellActionsMenuTable({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      offset: const Offset(0, 36),
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.rr),
        side: BorderSide(color: AppColors.gray),
      ),
      itemBuilder: (_) => actions
          .asMap()
          .entries
          .map(
            (entry) => PopupMenuItem<int>(
              value: entry.key,
              onTap: entry.value.onTap,
              padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 4.rh),
              child: Row(
                children: [
                  Icon(
                    entry.value.icon,
                    size: 15,
                    color: entry.value.danger
                        ? AppColors.orangeBurnt
                        : AppColors.greyCharcoal,
                  ),
                  SizedBox(width: 8.rw),
                  AppText(
                    entry.value.label,
                    fontSize: 13.rsp,
                    fontWeight: FontWeight.w500,
                    color: entry.value.danger
                        ? AppColors.orangeBurnt
                        : AppColors.textHeading,
                  ),
                ],
              ),
            ),
          )
          .toList(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 6.rh),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.rr),
          border: Border.all(color: AppColors.gray),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              'Actions',
              fontSize: 11.5.rsp,
              fontWeight: FontWeight.w500,
              color: AppColors.greyCharcoal,
            ),
            SizedBox(width: 6.rw),
            Icon(Icons.keyboard_arrow_down_rounded,
                size: 14, color: AppColors.grayAsh),
          ],
        ),
      ),
    );
  }
}
