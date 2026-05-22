import 'package:b_selfcare/src/data/models/campaign/campaign_model.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table_source.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_actions_menu_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_badge_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_text_table.dart';
import 'package:flutter/material.dart';

class SourceCampagne extends AppTableSource<CampaignModel> {
  @override
  final List<CampaignModel> rows;
  final void Function(CampaignModel)? onDetail;
  final void Function(CampaignModel, String execute)? onExecute;

  SourceCampagne({required this.rows, this.onDetail, this.onExecute});

  @override
  void onRowTap(BuildContext context, CampaignModel item) => onDetail?.call(item);

  @override
  List<({String label, int flex})> get columns => [
    (label: 'Campagne',     flex: 5),
    (label: 'Fréquence',    flex: 3),
    (label: 'Produit',      flex: 4),
    (label: 'Coût/Run',     flex: 3),
    (label: 'Début',        flex: 2),
    (label: 'Fin',          flex: 2),
    (label: 'Prochain Run', flex: 2),
    (label: 'Statut',       flex: 2),
    (label: 'Actions',      flex: 3),
  ];

  @override
  List<Widget> buildRow(CampaignModel e) => [
    CellTextTable(text: e.name ?? '---', sub: e.description),
    CellTextTable(text: e.frequency ?? '---'),
    CellTextTable(text: e.product?.name ?? '---'),
    CellTextTable(text: e.estimatedCost ?? '---'),
    CellTextTable(text: e.startDate != null ? AppDate.formatShort(e.startDate!) : '---'),
    CellTextTable(text: e.endDate != null ? AppDate.formatShort(e.endDate!) : '---'),
    CellTextTable(text: e.nextExecution != null ? AppDate.formatShort(e.nextExecution!) : '---'),
    _statusBadge(e.status),
    CellActionsMenuTable(actions: _actions(e)),
  ];

  List<({String label, bool danger, IconData icon, VoidCallback? onTap})> _actions(CampaignModel e) => [
    (label: 'Exécuter',     danger: false, icon: Icons.play_arrow_rounded,    onTap: () => onExecute?.call(e, 'execute')),
    (label: 'Pause',        danger: false, icon: Icons.pause_rounded,         onTap: () => onExecute?.call(e, 'pause')),
    (label: 'Réactiver',    danger: false, icon: Icons.replay_rounded,        onTap: () => onExecute?.call(e, 'reactivate')),
    (label: 'Redéclencher', danger: false, icon: Icons.restart_alt_rounded,   onTap: () => onExecute?.call(e, 'retrigger')),
    (label: 'Annuler',      danger: true,  icon: Icons.cancel_outlined,       onTap: () => onExecute?.call(e, 'cancel')),
  ];

  Widget _statusBadge(String? status) {
    return switch (status?.toLowerCase()) {
      'active'    => CellBadgeTable.actif(),
      'inactive'  => CellBadgeTable.inactif(),
      'paused'    => CellBadgeTable.enAttente(),
      'cancelled' => CellBadgeTable.cancelled(),
      _           => CellBadgeTable.inactif(),
    };
  }
}
