import 'package:b_selfcare/src/data/models/group/group_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table_source.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_actions_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_text_table.dart';
import 'package:flutter/material.dart';

class SourceGroupe extends AppTableSource<GroupModel> {
  @override
  final List<GroupModel> rows;
  final void Function(GroupModel)? onDetail;
  final void Function(GroupModel)? onEdit;
  final void Function(GroupModel)? onDelete;
  final void Function(GroupModel)? onToggleNotification;

  SourceGroupe({required this.rows, this.onDetail, this.onEdit, this.onDelete, this.onToggleNotification});

  @override
  List<({String label, int flex})> get columns => [
    (label: 'Groupe',          flex: 5),
    (label: 'Produit',         flex: 3),
    (label: 'Fréquence',       flex: 3),
    (label: 'Date début',      flex: 2),
    (label: 'Employés',        flex: 2),
    (label: 'Date création',   flex: 2),
    (label: 'Notif. SMS',      flex: 2),
    (label: 'Actions',         flex: 2),
  ];

  @override
  void onRowTap(BuildContext context, GroupModel item) => onDetail?.call(item);

  @override
  List<Widget> buildRow(GroupModel e) => [
    CellTextTable(text: e.name ?? '---', sub: e.description),
    CellTextTable(text: e.product?.name ?? '---'),
    CellTextTable(text: e.campaign?.frequency ?? '---'),
    CellTextTable(text: AppDate.formatShort(e.campaign?.startDate)),
    CellTextTable(text: e.employeesCount?.toString() ?? '---'),
    CellTextTable(text: e.createdAt != null ? AppDate.formatShort(e.createdAt!) : '---'),
    Switch(
      value: e.smsNotificationEnabled == true,
      onChanged: (_) => onToggleNotification?.call(e),
      activeTrackColor: AppColors.greenOlive.withValues(alpha: 0.3),
      activeThumbColor: AppColors.greenOlive,
      inactiveThumbColor: AppColors.grayAsh,
      inactiveTrackColor: AppColors.gray,
    ),
    CellActionsTable(actions: [
      (label: 'Modifier', danger: false, onTap: () => onEdit?.call(e)),
    ]),
  ];
}
