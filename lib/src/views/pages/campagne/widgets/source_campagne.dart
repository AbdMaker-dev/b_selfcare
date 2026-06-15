import 'package:b_selfcare/src/data/models/campaign/campaign_model.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table_source.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
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
    (label: 'Début',        flex: 2),
    (label: 'Fin',          flex: 2),
    (label: 'Prochain Run', flex: 2),
    (label: 'Statut',       flex: 3),
    (label: 'Actions',      flex: 3),
  ];

  @override
  List<Widget> buildRow(CampaignModel e) => [
    CellTextTable(text: e.name ?? '---', sub: e.description),
    CellTextTable(text: e.frequency ?? '---'),
    CellTextTable(text: e.product?.name ?? '---'),
    CellTextTable(text: e.startDate != null ? AppDate.formatShort(e.startDate!) : '---'),
    CellTextTable(text: e.endDate != null ? AppDate.formatShort(e.endDate!) : '---'),
    CellTextTable(text: e.nextExecution != null ? AppDate.formatShort(e.nextExecution!) : '---'),
    _statusBadge(e.status),
    _buildActionIcons(e),
  ];

  Widget _buildActionIcons(CampaignModel e) {
    final status = (e.status ?? '').toUpperCase();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (status == 'PAUSED')
          Tooltip(
            message: 'Réactiver',
            child: IconButton(
              onPressed: () => onExecute?.call(e, 'reactivate'),
              icon: Icon(Icons.play_circle_outline, color: AppColors.success),
            ),
          ),
        if (status == 'ACTIVE' || status == 'BLOCKED')
          Tooltip(
            message: 'Mettre en pause',
            child: IconButton(
              onPressed: () => onExecute?.call(e, 'pause'),
              icon: Icon(Icons.pause_rounded, color: AppColors.warning),
            ),
          ),
        if (status != 'CANCELLED' && status != 'COMPLETED')
          Tooltip(
            message: 'Annuler',
            child: IconButton(
              onPressed: () => onExecute?.call(e, 'cancel'),
              icon: Icon(Icons.cancel_outlined, color: AppColors.error),
            ),
          ),
        if (status == 'BLOCKED')
          Tooltip(
            message: 'Forcer l\'exécution',
            child: IconButton(
              onPressed: () => onExecute?.call(e, 'force_run'),
              icon: Icon(Icons.restart_alt_rounded, color: AppColors.primary),
            ),
          ),
      ],
    );
  }

  Widget _statusBadge(String? status) {
    return switch (status?.toLowerCase()) {
      'active'    => CellBadgeTable.actif(),
      'blocked'   => CellBadgeTable.bloque(),
      'paused'    => CellBadgeTable.enPause(),
      'cancelled' => CellBadgeTable.cancelled(),
      'completed' => CellBadgeTable.termine(),
      _           => CellBadgeTable.inactif(),
    };
  }
}
