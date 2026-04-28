import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CellBadgeTable extends StatelessWidget {
  final String label;
  final Color bg, fg, dot;
  const CellBadgeTable({super.key, required this.label, required this.bg, required this.fg, required this.dot});

  factory CellBadgeTable.actif()     =>  CellBadgeTable(label: 'Actif',      bg: AppColors.greenMint, fg: AppColors.green, dot: AppColors.greenOlive);
  factory CellBadgeTable.suspendu()  =>  CellBadgeTable(label: 'Suspendu',   bg: AppColors.orangePeach, fg: AppColors.orangeBurnt, dot: AppColors.orangeFire);
  factory CellBadgeTable.enAttente() =>  CellBadgeTable(label: 'En attente', bg: AppColors.amberCream, fg: AppColors.amberBrown, dot: AppColors.amberGold);
  factory CellBadgeTable.inactif()   =>  CellBadgeTable(label: 'Inactif',    bg: AppColors.beigeIvory, fg: AppColors.beigeMole, dot: AppColors.beigeSmoke);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 8.rw, vertical: 3.rh),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(99.rr)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 5.rw, height: 5.rh, decoration: BoxDecoration(color: dot, shape: BoxShape.circle)),
           SizedBox(width: 5.rw),
          AppText(
            label,
            fontSize: 11.rsp,
            fontWeight: FontWeight.w600,
            color: fg,
            type: AppTextType.heading,
          ),
        ],
      ),
    );
  }
}