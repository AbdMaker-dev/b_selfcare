import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CellBadgeTable extends StatelessWidget {
  final String label;
  final Color color;

  const CellBadgeTable({super.key, required this.label, required this.color});

  factory CellBadgeTable.actif()     => CellBadgeTable(label: 'Actif',      color: AppColors.success);
  factory CellBadgeTable.active()    => CellBadgeTable(label: 'ACTIVE',     color: AppColors.success);
  factory CellBadgeTable.success()   => CellBadgeTable(label: 'Succès',     color: AppColors.success);
  factory CellBadgeTable.suspendu()  => CellBadgeTable(label: 'Suspendu',   color: AppColors.error);
  factory CellBadgeTable.cancelled() => CellBadgeTable(label: 'Annulé',     color: AppColors.error);
  factory CellBadgeTable.enAttente() => CellBadgeTable(label: 'En attente', color: AppColors.warning);
  factory CellBadgeTable.inactif()   => CellBadgeTable(label: 'Inactif',    color: AppColors.error);
  factory CellBadgeTable.inactive()  => CellBadgeTable(label: 'INACTIVE',   color: AppColors.error);
  factory CellBadgeTable.echec()     => CellBadgeTable(label: 'Echec',      color: AppColors.error);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 5.rw,
            height: 5.rh,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 5.rw),
          AppText(
            label,
            fontSize: 10.5.rsp,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ],
      ),
    );
  }
}
