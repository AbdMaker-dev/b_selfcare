import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/src/data/models/resource_custom/recovered_bundle_model.dart';
import 'package:b_selfcare/src/data/models/resource_custom/recovery_history_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/detail_components.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table_source.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_badge_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_muted_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_text_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecoveryHistoryPanel extends StatelessWidget {
  final MyFlotteCubit cubit;
  final int? fleetNumberId;

  const RecoveryHistoryPanel({
    super.key,
    required this.cubit,
    this.fleetNumberId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyFlotteCubit, MyFlotteState>(
      bloc: cubit,
      buildWhen: (_, s) => s.maybeWhen(
        historiqueRecoveryEmployeeLoading: () => true,
        historiqueRecoveryEmployeeLoaded: (_) => true,
        historiqueRecoveryEmployeeFailed: (_) => true,
        orElse: () => false,
      ),
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          historiqueRecoveryEmployeeLoading: () => true,
          orElse: () => false,
        );
        final response = state.maybeWhen(
          historiqueRecoveryEmployeeLoaded: (d) => d,
          orElse: () => null,
        );

        final history = response?.data ?? <RecoveryHistoryModel>[];
        final meta = response?.meta;
        final currentPage = meta?.currentPage ?? 1;
        final lastPage = meta?.lastPage ?? 1;
        final total = meta?.total ?? 0;

        if (isLoading) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.rr),
              border: Border.all(color: AppColors.gray),
            ),
            padding: EdgeInsets.symmetric(vertical: 60.rh),
            child: Center(
              child: CircularProgressIndicator(
                  color: AppColors.primary, strokeWidth: 2),
            ),
          );
        }

        return AppTable<RecoveryHistoryModel>(
          title: 'Historique de retrait',
          source: _RecoveryHistorySource(history),
          emptyMessage: 'Aucun historique disponible',
          currentPage: currentPage,
          totalCount: total,
          hidePaginator: total == 0,
          activePreviousClicked: currentPage > 1,
          activeNextClicked: currentPage < lastPage,
          onPreviousClicked: (currentPage > 1 && fleetNumberId != null)
              ? () => cubit.historiqueRecoveryEmployee(
                    fleetNumberId: fleetNumberId!,
                    data: {'page': currentPage - 1},
                  )
              : null,
          onNextClicked: (currentPage < lastPage && fleetNumberId != null)
              ? () => cubit.historiqueRecoveryEmployee(
                    fleetNumberId: fleetNumberId!,
                    data: {'page': currentPage + 1},
                  )
              : null,
        );
      },
    );
  }
}

class _RecoveryHistorySource extends AppTableSource<RecoveryHistoryModel> {
  final List<RecoveryHistoryModel> _rows;

  _RecoveryHistorySource(this._rows);

  @override
  List<RecoveryHistoryModel> get rows => _rows;

  @override
  List<({String label, int flex})> get columns => [
        (label: 'Statut', flex: 2),
        (label: 'Montant', flex: 3),
        (label: 'Référence CBS', flex: 3),
        (label: 'Ressources', flex: 4),
        (label: 'Date', flex: 3),
      ];

  @override
  List<Widget> buildRow(RecoveryHistoryModel item) {
    return [
      _statusBadge(item.status),
      CellTextTable(
        text: item.amountCredited != null ? '${item.amountCredited} FCFA' : '---',
      ),
      CellMutedTable(text: item.cbsReference ?? '---'),
      _resourcesCell(item),
      CellMutedTable(text: _formatDate(item.createdAt)),
    ];
  }

  @override
  void onRowTap(BuildContext context, RecoveryHistoryModel item) {
    _RecoveryDetailPanel.show(context, item: item);
  }

  Widget _statusBadge(String? status) => switch (status) {
        'SUCCESS' => CellBadgeTable.success(),
        'ERROR' => CellBadgeTable.echec(),
        _ => CellMutedTable(text: status ?? '---'),
      };

  Widget _resourcesCell(RecoveryHistoryModel item) {
    final res = item.recoveredResources;
    if (res == null && item.errorMessage == null) {
      return const CellMutedTable(text: '---');
    }
    if (item.errorMessage != null) {
      return CellMutedTable(text: item.errorMessage!);
    }

    // Ligne 1 : Crédit + SMS
    final line1 = <String>[];
    if ((res?.mainCreditFcfa ?? 0) > 0) {
      line1.add('Crédit ${res!.mainCreditFcfa} FCFA');
    }
    // Ligne 2 : bundles DATA + VOIX
    final line2 = <String>[];
    final bundles = res?.bundles ?? [];
    for (final b in bundles) {
      final unit = b.walletUnit ?? '';
      final amount = _formatBundleAmount(b.cbsAmount, unit);
      if (unit == 'SMS') {
        line1.add('SMS $amount');
      } else {
        line2.add('$amount $unit');
      }
    }

    final l1 = line1.join('  ·  ');
    final l2 = line2.join('  ·  ');

    if (l1.isEmpty && l2.isEmpty) return const CellMutedTable(text: '---');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (l1.isNotEmpty) CellMutedTable(text: l1),
        if (l2.isNotEmpty) CellMutedTable(text: l2),
      ],
    );
  }

  String _formatBundleAmount(int? amount, String? unit) {
    if (amount == null) return '---';
    if (unit == 'MB_GB' || unit == 'MB' || unit == 'GB') {
      if (amount >= 1024 * 1024 * 1024) {
        return '${(amount / (1024 * 1024 * 1024)).toStringAsFixed(1)} Go';
      } else if (amount >= 1024 * 1024) {
        return '${(amount / (1024 * 1024)).toStringAsFixed(0)} Mo';
      }
      return '${(amount / 1024).toStringAsFixed(0)} Ko';
    }
    if (unit == 'MIN' || unit == 'MINUTES') {
      return '${amount ~/ 60} min';
    }
    return '$amount';
  }

  String _formatDate(String? iso) {
    if (iso == null) return '---';
    try {
      final dt = DateTime.parse(iso).toLocal();
      return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}  '
          '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return iso;
    }
  }
}

// ─── Panel détail (style detail_groupe) ─────────────────────────────────────

class _RecoveryDetailPanel extends StatelessWidget {
  final RecoveryHistoryModel item;

  const _RecoveryDetailPanel({required this.item});

  static void show(BuildContext context, {required RecoveryHistoryModel item}) {
    showGeneralDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: AppColors.primary.withValues(alpha: 0.7),
      pageBuilder: (_, __, ___) => Align(
        alignment: Alignment.centerRight,
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: 650.rw,
            height: double.infinity,
            child: _RecoveryDetailPanel(item: item),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final (statusColor, statusLabel) = _statusInfo(item.status);
    final res = item.recoveredResources;

    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.rr),
          bottomLeft: Radius.circular(12.rr),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(bottom: BorderSide(color: AppColors.gray)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.textHighlight(
                        'Détail recovery',
                        fontSize: 24.rsp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grayAsh,
                        highlight: 'recovery',
                        fontFamily: FontFamily.syne,
                        highlightColor: AppColors.primary,
                        highlightFontSize: 24.rsp,
                      ),
                      SizedBox(height: 4.rh),
                      AppText(
                        item.cbsReference != null
                            ? '${item.cbsReference}  ·  $statusLabel'
                            : statusLabel,
                        fontSize: 12.rsp,
                        color: statusColor,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context, rootNavigator: true).pop(),
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.rw, vertical: 6.rh),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.graySilver),
                    ),
                    child: AppText('X',
                        fontSize: 13.rsp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          ),

          // BODY scrollable
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.rw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header card
                  Container(
                    padding: EdgeInsets.all(16.rw),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.rr),
                      border: Border.all(color: AppColors.gray),
                    ),
                    child: Row(
                      children: [
                        DetailIconBox(icon: Icons.history_rounded),
                        SizedBox(width: 14.rw),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                item.amountCredited != null
                                    ? '${item.amountCredited} FCFA'
                                    : '---',
                                fontSize: 16.rsp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                              SizedBox(height: 2.rh),
                              AppText(
                                _formatDate(item.createdAt),
                                fontSize: 12.rsp,
                                color: AppColors.textMuted,
                              ),
                            ],
                          ),
                        ),
                        DetailStatusBadge(
                            label: statusLabel, color: statusColor),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.rh),

                  // Section informations
                  DetailSectionTitle(
                      label: 'Informations générales',
                      icon: Icons.info_outline),
                  SizedBox(height: 14.rh),
                  DetailInfoRow(
                    left: DetailInfoItem(
                      label: 'Date',
                      value: _formatDate(item.createdAt),
                      icon: Icons.schedule_outlined,
                    ),
                    right: DetailInfoItem(
                      label: 'Montant crédité',
                      value: item.amountCredited != null
                          ? '${item.amountCredited} FCFA'
                          : '---',
                      icon: Icons.account_balance_wallet_outlined,
                    ),
                  ),
                  if (item.cbsReference != null) ...[
                    SizedBox(height: 12.rh),
                    DetailInfoItem(
                      label: 'Référence CBS',
                      value: item.cbsReference!,
                      icon: Icons.tag_outlined,
                    ),
                  ],
                  if (item.errorMessage != null) ...[
                    SizedBox(height: 12.rh),
                    DetailInfoItem(
                      label: 'Message erreur',
                      value: item.errorMessage!,
                      icon: Icons.error_outline,
                    ),
                  ],

                  // Section ressources
                  if (res != null &&
                      ((res.mainCreditFcfa ?? 0) > 0 ||
                          (res.bundles ?? []).isNotEmpty)) ...[
                    SizedBox(height: 16.rh),
                    const DetailDivider(),
                    SizedBox(height: 16.rh),
                    DetailSectionTitle(
                        label: 'Ressources récupérées',
                        icon: Icons.layers_outlined),
                    SizedBox(height: 14.rh),
                    if ((res.mainCreditFcfa ?? 0) > 0)
                      DetailInfoItem(
                        label: 'Crédit',
                        value: '${res.mainCreditFcfa} FCFA',
                        icon: Icons.account_balance_wallet_outlined,
                      ),
                    ...List.generate(res.bundles?.length ?? 0, (i) {
                      final b = res.bundles![i];
                      final needsGap = i > 0 || (res.mainCreditFcfa ?? 0) > 0;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (needsGap) SizedBox(height: 12.rh),
                          DetailInfoItem(
                            label: b.freeUnitType ?? b.walletUnit ?? '---',
                            value: _formatBundleAmount(
                                b.cbsAmount, b.walletUnit),
                            icon: _unitIcon(b.walletUnit),
                          ),
                        ],
                      );
                    }),
                  ],

                  SizedBox(height: 16.rh),
                ],
              ),
            ),
          ),

          // FOOTER
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(top: BorderSide(color: AppColors.gray)),
            ),
            child: SizedBox(
              width: double.infinity,
              child: AppButton(
                text: 'Fermer',
                type: AppButtonType.outline,
                fontSize: 13.rsp,
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  (Color, String) _statusInfo(String? status) => switch (status) {
        'SUCCESS' => (AppColors.success, 'SUCCÈS'),
        'ERROR' => (AppColors.error, 'ERREUR'),
        _ => (AppColors.grayAsh, status?.toUpperCase() ?? '---'),
      };

  IconData _unitIcon(String? unit) => switch (unit) {
        'MB_GB' || 'MB' || 'GB' => Icons.wifi_outlined,
        'SMS' => Icons.sms_outlined,
        'MIN' || 'MINUTES' => Icons.phone_outlined,
        _ => Icons.layers_outlined,
      };

  String _formatBundleAmount(int? amount, String? unit) {
    if (amount == null) return '---';
    if (unit == 'MB_GB' || unit == 'MB' || unit == 'GB') {
      if (amount >= 1024 * 1024 * 1024) {
        return '${(amount / (1024 * 1024 * 1024)).toStringAsFixed(1)} Go';
      } else if (amount >= 1024 * 1024) {
        return '${(amount / (1024 * 1024)).toStringAsFixed(0)} Mo';
      }
      return '${(amount / 1024).toStringAsFixed(0)} Ko';
    }
    if (unit == 'MIN' || unit == 'MINUTES') return '${amount ~/ 60} min';
    return '$amount';
  }

  String _formatDate(String? iso) {
    if (iso == null) return '---';
    try {
      final dt = DateTime.parse(iso).toLocal();
      return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}  '
          '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return iso;
    }
  }
}
