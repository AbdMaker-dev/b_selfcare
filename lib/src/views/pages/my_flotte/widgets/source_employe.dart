import 'package:b_selfcare/src/data/models/employee/employee_model.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table_source.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_actions_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_badge_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_text_table.dart';
import 'package:flutter/material.dart';

class SourceEmployes extends AppTableSource<EmployeeModel> {
  @override
  final List<EmployeeModel> rows;

  SourceEmployes({required this.rows});

  @override
  List<({String label, int flex})> get columns => [
    (label: 'Employé',   flex: 5),
    (label: 'Poste',     flex: 4),
    (label: 'Téléphone', flex: 4),
    (label: 'Numéros',   flex: 3),
    (label: 'Statut',    flex: 3),
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
    e.status == 'active' ? CellBadgeTable.actif() : CellBadgeTable.suspendu(),
    CellActionsTable(actions: [
      (label: 'Modifier', danger: false, onTap: () {}),
      (label: 'Swap SIM', danger: true,  onTap: () {}),
    ]),
  ];
}
