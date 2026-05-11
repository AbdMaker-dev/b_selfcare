import 'package:b_selfcare/src/data/models/campaign/campaign_model.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table_source.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_badge_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_text_table.dart';
import 'package:flutter/material.dart';

class SourceHistoriqueCampagne extends AppTableSource<CampaignModel> {
  @override
  final List<CampaignModel> rows;

  SourceHistoriqueCampagne({required this.rows});

  @override
  List<({String label, int flex})> get columns => [
    (label: 'Date',          flex: 3),
    (label: 'Campagne',      flex: 4),
    (label: 'Produit',       flex: 3),
    (label: 'Coût',          flex: 3),
    (label: 'Statut',        flex: 3),
    (label: 'Prochain Run',  flex: 4),
  ];

  @override
  List<Widget> buildRow(CampaignModel e) => [
    CellTextTable(text: e.createdAt ?? '-'),
    CellTextTable(text: e.name ?? '-', sub: e.description),
    CellTextTable(text: e.product?.name ?? '-'),
    CellTextTable(text: e.estimatedCost ?? '-'),
    _statusBadge(e.status),
    CellTextTable(text: e.nextExecution ?? '-'),
  ];

  Widget _statusBadge(String? status) {
    return switch (status?.toLowerCase()) {
      'active'   => CellBadgeTable.actif(),
      'inactive' => CellBadgeTable.inactif(),
      'paused'   => CellBadgeTable.enAttente(),
      _          => CellBadgeTable.inactif(),
    };
  }
}
