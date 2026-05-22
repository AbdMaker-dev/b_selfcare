import 'package:b_selfcare/src/data/models/flotte_number/flotte_number_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table_source.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_actions_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_badge_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_text_table.dart';
import 'package:flutter/material.dart';

class SourceNumeros extends AppTableSource<FlotteNumberModel> {
  @override
  final List<FlotteNumberModel> rows;
  final void Function(FlotteNumberModel)? onDetail;
  final void Function(FlotteNumberModel)? onAssign;
  final void Function(FlotteNumberModel)? onSuspend;
  final void Function(FlotteNumberModel)? onReactivate;

  SourceNumeros({
    required this.rows,
    this.onDetail,
    this.onAssign,
    this.onSuspend,
    this.onReactivate,
  });

  @override
  void onRowTap(BuildContext context, FlotteNumberModel item) => onDetail?.call(item);

  @override
  List<({String label, int flex})> get columns => [
    (label: 'Numéro',       flex: 4),
    (label: 'ICCID',        flex: 4),
    (label: 'Employé',      flex: 5),
    (label: 'Assigné le',   flex: 3),
    (label: 'Créé le',      flex: 3),
    (label: 'Statut',       flex: 3),
    (label: 'Actions',      flex: 3),
  ];

  @override
  List<Widget> buildRow(FlotteNumberModel n) {
    final status = n.status?.toUpperCase();
    final emp = n.employee;
    final empName = emp != null
        ? '${emp.firstName ?? ''} ${emp.lastName ?? ''}'.trim()
        : null;

    return [
      CellTextTable(text: n.msisdn ?? '-'),
      CellTextTable(text: n.iccid ?? '-'),
      CellTextTable(
        text: empName?.isNotEmpty == true ? empName! : 'Non assigné',
        sub: emp != null ? emp.status : null,
      ),
      CellTextTable(text: AppDate.formatShort(n.assignmentDate)),
      CellTextTable(text: AppDate.formatShort(n.createdAt)),
      _statusBadge(status),
      CellActionsTable(actions: [
        if (status == 'UNASSIGNED')
          (label: 'Assigner', danger: false, onTap: () => onAssign?.call(n)),
        if (status == 'ACTIVE')
          (label: 'Suspendre', danger: true, onTap: () => onSuspend?.call(n)),
        if (status == 'SUSPENDED' || status == 'INACTIVE')
          (label: 'Réactiver', danger: false, onTap: () => onReactivate?.call(n)),
      ]),
    ];
  }

  Widget _statusBadge(String? status) => switch (status) {
    'ACTIVE'     => CellBadgeTable.actif(),
    'INACTIVE'   => CellBadgeTable.inactif(),
    'SUSPENDED'  => CellBadgeTable.suspendu(),
    'UNASSIGNED' => CellBadgeTable(label: 'Non assigné', color: AppColors.grayAsh),
    _            => CellBadgeTable.inactif(),
  };
}
