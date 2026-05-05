import 'package:b_selfcare/src/views/pages/my_flotte/example_model/employe_model.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table_source.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_actions_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_badge_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_text_table.dart';
import 'package:flutter/material.dart';

class SourceHistoriqueCampagne extends AppTableSource<EmployeModel> {
  @override
  final List<EmployeModel> rows;

  SourceHistoriqueCampagne({required this.rows});

  @override
  List<({String label, int flex})> get columns => [
    (label: 'Date',  flex: 2),
    (label: 'Campagne',   flex: 4),
    (label: 'Numéro',  flex: 3),
    (label: 'Provisionnés',  flex: 3),
    (label: 'Coût',   flex: 3),
    (label: 'Status',  flex: 2),
    (label: 'Durée',  flex: 3),
  ];

  @override
  List<Widget> buildRow(EmployeModel e) => [
    CellTextTable(text: e.name, sub: e.group),
    CellTextTable(text: e.group),
    CellTextTable(text: e.phone),
    CellTextTable(text: e.product),
    CellTextTable(text: e.product),
    e.status == 'Succès' ? CellBadgeTable.success() : CellBadgeTable.echec(),
    CellTextTable(text: e.product),
  ];
}