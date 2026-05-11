import 'package:b_selfcare/src/data/models/campaign/campaign_model.dart';
import 'package:b_selfcare/src/data/models/group/group_model.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table_source.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_badge_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_text_table.dart';
import 'package:flutter/material.dart';

class SourceGroupe extends AppTableSource<GroupModel> {
  @override
  final List<GroupModel> rows;

  SourceGroupe({required this.rows});

  @override
  List<({String label, int flex})> get columns => [
    (label: 'Groupe',     flex: 5),
    (label: 'Produit',      flex: 3),
    (label: 'Nombre employés',      flex: 3),
    (label: 'Début création',       flex: 2),
  ];

  @override
  List<Widget> buildRow(GroupModel e) => [
    CellTextTable(text: e.name ?? '---', sub: e.description),
    CellTextTable(text: e.product?.name ?? '---'),
    CellTextTable(text: e.employeesCount?.toString() ?? '---'),
    CellTextTable(text: e.createdAt != null ? AppDate.formatShort(e.createdAt!) : '---'),
  ];
}
