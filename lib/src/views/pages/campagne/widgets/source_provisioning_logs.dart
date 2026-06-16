import 'package:b_selfcare/src/data/models/provisioning/provisioning_log_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table_source.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_badge_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_text_table.dart';
import 'package:flutter/material.dart';

class SourceProvisioningLogs extends AppTableSource<ProvisioningLogModel> {
  @override
  final List<ProvisioningLogModel> rows;

  SourceProvisioningLogs({required this.rows});

  @override
  void onRowTap(BuildContext context, ProvisioningLogModel item) {}

  @override
  List<({String label, int flex})> get columns => [
    (label: 'Numéro',       flex: 3),
    (label: 'Produit',      flex: 4),
    (label: 'Déclencheur',  flex: 3),
    (label: 'Tentatives',   flex: 2),
    (label: 'Montant',      flex: 3),
    (label: 'Date',         flex: 4),
    (label: 'Statut',       flex: 3),
  ];

  @override
  List<Widget> buildRow(ProvisioningLogModel e) => [
    CellTextTable(text: e.phoneNumber ?? '---'),
    CellTextTable(text: e.productName ?? '---'),
    CellTextTable(text: e.triggerType ?? '---'),
    CellTextTable(text: '${e.attempts ?? 0}'),
    CellTextTable(text: e.amountDebited != null && e.amountDebited != '0.00' ? '${e.amountDebited} F' : '—'),
    CellTextTable(text: AppDate.formatWithTime(e.executedAt), sub: e.errorMessage),
    _statusBadge(e.status),
  ];

  Widget _statusBadge(String? status) {
    return switch (status?.toUpperCase()) {
      'SUCCESS'      => CellBadgeTable.success(),
      'ERROR'        => CellBadgeTable.echec(),
      'FAILED'       => CellBadgeTable.echec(),
      'DEBIT_FAILED' => CellBadgeTable(label: 'Débit échoué', color: AppColors.error),
      'PENDING'      => CellBadgeTable.enAttente(),
      'SKIPPED'      => CellBadgeTable(label: 'Ignoré', color: AppColors.textMuted),
      _              => CellBadgeTable.inactif(),
    };
  }
}
