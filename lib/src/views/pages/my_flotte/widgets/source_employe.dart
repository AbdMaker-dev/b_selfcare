import 'package:b_selfcare/src/data/models/employee/employee_model.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table_source.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_actions_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_badge_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_text_table.dart';
import 'package:flutter/material.dart';

class SourceEmployes extends AppTableSource<EmployeeModel> {
  @override
  final List<EmployeeModel> rows;
  final void Function(EmployeeModel)? onEdit;
  final void Function(EmployeeModel)? onDisable;

  SourceEmployes({required this.rows, this.onEdit, this.onDisable});

  @override
  List<({String label, int flex})> get columns => [
    (label: 'Employé',   flex: 5),
    (label: 'Poste',     flex: 4),
    (label: 'Téléphone', flex: 4),
    (label: 'Numéros',   flex: 4),
    (label: 'Groupe',   flex: 4),
    (label: 'Statut',    flex: 2),
    (label: 'Actions',   flex: 4),
  ];

  @override
  List<Widget> buildRow(EmployeeModel e) => [
    CellTextTable(
      text: '${e.firstName ?? ''} ${e.lastName ?? ''}'.trim(),
      sub: e.position,
    ),
    CellTextTable(text: e.position ?? '-'),
    CellTextTable(text: e.phone ?? '-'),
    CellTextTable(text: '${e.fleetNumbersCount ?? 0} numéros'),
    CellTextTable(text: e.group?.name ?? '-'),
    _statusBadge(e.status),
    CellActionsTable(actions: [
      (label: 'Modifier', danger: false, onTap: () => onEdit?.call(e)),
      if (e.status?.toLowerCase() == 'active')
        (label: 'Désactiver', danger: true, onTap: () => onDisable?.call(e)),
    ]),
  ];
  Widget _statusBadge(String? status) {
    return switch (status?.toLowerCase()) {
      'active'   => CellBadgeTable.actif(),
      'inactive' => CellBadgeTable.inactive(),
      'paused'   => CellBadgeTable.enAttente(),
      _          => CellBadgeTable.inactive(),
    };
  }
}
