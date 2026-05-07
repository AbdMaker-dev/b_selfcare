import 'package:b_selfcare/src/data/models/campaign/campaign_model.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table_source.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_badge_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_text_table.dart';
import 'package:flutter/material.dart';

class SourceCampagne extends AppTableSource<CampaignModel> {
  @override
  final List<CampaignModel> rows;

  SourceCampagne({required this.rows});

  @override
  List<({String label, int flex})> get columns => [
    (label: 'Campagne',     flex: 5),
    (label: 'Fréquence',    flex: 3),
    (label: 'Produit',      flex: 3),
    (label: 'Coût/Run',     flex: 3),
    (label: 'Début',      flex: 3),
    (label: 'Fin',      flex: 3),
    (label: 'Prochain Run', flex: 3),
    (label: 'Statut',       flex: 2),
  ];

  @override
  List<Widget> buildRow(CampaignModel e) => [
    CellTextTable(text: e.name ?? '---', sub: e.description),
    CellTextTable(text: e.frequency ?? '---'),
    CellTextTable(text: e.product?.name ?? '---'),
    CellTextTable(text: e.estimatedCost != null ? AppMoney.formatString(e.estimatedCost!) : '---'),
    CellTextTable(text: e.startDate != null ? AppDate.formatShort(e.startDate!) : '---'),
    CellTextTable(text: e.endDate != null ? AppDate.formatShort(e.endDate!) : '---'),
    CellTextTable(text: e.nextExecution != null ? AppDate.formatShort(e.nextExecution!) : '---'),
    _statusBadge(e.status),
  ];

  Widget _statusBadge(String? status) {
    return switch (status?.toLowerCase()) {
      'active'   => CellBadgeTable.actif(),
      'inactive' => CellBadgeTable.inactif(),
      'paused'   => CellBadgeTable.enAttente(),
      'cancelled'   => CellBadgeTable.cancelled(),
      _          => CellBadgeTable.inactif(),
    };
  }
}
