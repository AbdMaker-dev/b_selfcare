import 'package:b_selfcare/src/views/widgets/table/app_table_source.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_actions_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_badge_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_text_table.dart';
import 'package:flutter/material.dart';

import 'employe_model.dart';

class SourceEmployes extends AppTableSource<EmployeModel> {
  @override
  final List<EmployeModel> rows;

  SourceEmployes({required this.rows});

  @override
  List<({String label, int flex})> get columns => [
    (label: 'Employé',  flex: 5),
    (label: 'Groupe',   flex: 3),
    (label: 'Mission',  flex: 4),
    (label: 'Produit',  flex: 3),
    (label: 'Statut',   flex: 3),
    (label: 'Actions',  flex: 4),
  ];

  @override
  List<Widget> buildRow(EmployeModel e) => [
    CellTextTable(text: e.name, sub: e.group),
    CellTextTable(text: e.group),
    CellTextTable(text: e.phone),
    CellTextTable(text: e.product),
    e.status == 'ACTIF' ? CellBadgeTable.actif() : CellBadgeTable.suspendu(),
    CellActionsTable(actions: [
      (label: 'Modifier',  danger: false, onTap: () {
        print("bonjour modifier");
      }),
      (label: 'Swap SIM',  danger: true,  onTap: () {
        print("bonjour swap sim");
      }),
    ]),
  ];
}