import 'package:b_selfcare/src/data/models/campaign/campaign_execution_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table_source.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_badge_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_text_table.dart';
import 'package:flutter/material.dart';

class SourceExecutionCampagne extends AppTableSource<CampaignExecutionModel> {
  @override
  final List<CampaignExecutionModel> rows;

  SourceExecutionCampagne({required this.rows});

  @override
  void onRowTap(BuildContext context, CampaignExecutionModel item) {}

  @override
  List<({String label, int flex})> get columns => [
    (label: 'Campagne',       flex: 5),
    (label: 'Déclenché par',  flex: 3),
    (label: 'Total',          flex: 2),
    (label: 'Succès',         flex: 2),
    (label: 'Erreur',         flex: 2),
    (label: 'Montant débité', flex: 3),
    (label: 'Date réelle',    flex: 3),
    (label: 'Statut',         flex: 3),
  ];

  @override
  List<Widget> buildRow(CampaignExecutionModel e) => [
    CellTextTable(text: e.campaignName ?? '---', sub: AppDate.dayMonth(e.scheduledDate)),
    CellTextTable(text: e.triggeredBy ?? '---'),
    CellTextTable(text: '${e.totalNumbers ?? 0}'),
    CellTextTable(text: '${e.nbSuccess ?? 0}'),
    CellTextTable(text: '${e.nbError ?? 0}'),
    CellTextTable(text: e.amountDebited != null && e.amountDebited != 0 ? '${e.amountDebited} F' : '—'),
    CellTextTable(text: AppDate.formatWithTime(e.actualDate)),
    _statusBadge(e.status),
  ];

  Widget _statusBadge(String? status) {
    return switch (status?.toUpperCase()) {
      'SUCCESS'   => CellBadgeTable.success(),
      'ERROR'     => CellBadgeTable.echec(),
      'FAILED'    => CellBadgeTable.echec(),
      'RUNNING'   => CellBadgeTable.actif(),
      'PENDING'   => CellBadgeTable.enAttente(),
      'CANCELLED' => CellBadgeTable.cancelled(),
      'SKIPPED'   => CellBadgeTable(label: 'Ignoré', color: AppColors.textMuted),
      _           => CellBadgeTable.inactif(),
    };
  }
}
