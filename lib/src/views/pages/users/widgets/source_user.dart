import 'package:b_selfcare/src/data/models/user_profile_model.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table_source.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_actions_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_badge_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_muted_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_text_table.dart';
import 'package:flutter/material.dart';

class SourceUsers extends AppTableSource<UserProfileModel> {
  @override
  final List<UserProfileModel> rows;
  final void Function(UserProfileModel)? onDetail;
  final void Function(UserProfileModel)? onEdit;
  final void Function(UserProfileModel)? onDisable;

  SourceUsers({
    required this.rows,
    this.onDetail,
    this.onEdit,
    this.onDisable,
  });

  @override
  void onRowTap(BuildContext context, UserProfileModel item) => onDetail?.call(item);

  @override
  List<({String label, int flex})> get columns => [
    (label: 'Utilisateur', flex: 5),
    (label: 'Email',       flex: 4),
    (label: 'Rôle',        flex: 3),
    (label: 'Statut',      flex: 2),
    (label: 'Actions',     flex: 4),
  ];

  String _roleLabel(UserProfileModel user) {
    final name = user.roles.firstOrNull?.name ?? '—';
    return name.replaceAll('_', ' ');
  }

  @override
  List<Widget> buildRow(UserProfileModel item) => [
    CellTextTable(text: item.name ?? '—'),
    CellTextTable(text: item.email ?? '—'),
    CellTextTable(text: _roleLabel(item)),
    item.status?.toUpperCase() == 'ACTIVE'
        ? CellBadgeTable.actif()
        : CellBadgeTable.inactif(),
    CellActionsTable(actions: [
      (label: 'Modifier',   danger: false, onTap: () => onEdit?.call(item)),
      (label: 'Supprimer', danger: true, onTap: () => onDisable?.call(item)),
    ]),
  ];
}
