import 'package:b_selfcare/src/views/pages/my_flotte/example_model/employe_model.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table_source.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_actions_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_badge_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_text_table.dart';
import 'package:flutter/material.dart';

class SourceCampagne extends AppTableSource<EmployeModel> {
  @override
  final List<EmployeModel> rows;

  SourceCampagne({required this.rows});

  @override
  List<({String label, int flex})> get columns => [
    (label: 'Employé',  flex: 4),
    (label: 'Fréquence',   flex: 2),
    (label: 'Numéro',  flex: 3),
    (label: 'Produit',  flex: 3),
    (label: 'Coût/Run',   flex: 3),
    (label: 'Prochain Run',  flex: 3),
    (label: 'Status',  flex: 2),
  ];

  @override
  List<Widget> buildRow(EmployeModel e) => [
    CellTextTable(text: e.name, sub: e.group),
    CellTextTable(text: e.group),
    CellTextTable(text: e.phone),
    CellTextTable(text: e.product),
    CellTextTable(text: e.product),
    CellTextTable(text: e.product),
    e.status == 'Succès' ? CellBadgeTable.success() : CellBadgeTable.echec(),
  ];
}