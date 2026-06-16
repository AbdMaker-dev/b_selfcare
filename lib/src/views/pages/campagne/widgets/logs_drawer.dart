import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/src/data/models/provisioning/provisioning_log_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/campagne/cubit/campagne_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogsDrawer extends StatefulWidget {
  final CampagneCubit cubit;
  const LogsDrawer({super.key, required this.cubit});

  static void show(BuildContext context, {required CampagneCubit cubit}) {
    showGeneralDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: AppColors.primary.withValues(alpha: 0.7),
      pageBuilder: (_, _, _) => Align(
        alignment: Alignment.centerRight,
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: 650.rw,
            height: double.infinity,
            child: LogsDrawer(cubit: cubit),
          ),
        ),
      ),
    );
  }

  @override
  State<LogsDrawer> createState() => _LogsDrawerState();
}

class _LogsDrawerState extends State<LogsDrawer> {
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch({int page = 1}) {
    setState(() => _currentPage = page);
    widget.cubit.getProvisioningLogs(params: {'page': page});
  }

  void _close() => Navigator.of(context, rootNavigator: true).pop();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.rr),
          bottomLeft: Radius.circular(12.rr),
        ),
      ),
      child: BlocBuilder<CampagneCubit, CampagneState>(
        bloc: widget.cubit,
        builder: (context, _) {
          final data = widget.cubit.provisioningLogsData?.data;
          final items = data?.items ?? [];
          final summary = data?.summary;
          final pagination = data?.pagination;
          final lastPage = pagination?.lastPage ?? 1;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Header ──────────────────────────────────────────────────
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border(bottom: BorderSide(color: AppColors.gray)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.textHighlight(
                                'Logs de provisioning',
                                fontSize: 24.rsp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.grayAsh,
                                highlight: 'provisioning',
                                fontFamily: FontFamily.syne,
                                highlightColor: AppColors.primary,
                                highlightFontSize: 24.rsp,
                              ),
                              SizedBox(height: 4.rh),
                              AppText(
                                'Historique des opérations CBS',
                                fontSize: 12.rsp,
                                color: AppColors.textMuted,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: _close,
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 6.rh),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.graySilver),
                            ),
                            child: AppText(
                              'X',
                              fontSize: 13.rsp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (summary != null) ...[
                      SizedBox(height: 14.rh),
                      Row(
                        spacing: 10.rw,
                        children: [
                          _SummaryChip(label: 'Total', value: '${summary.total ?? 0}', color: AppColors.primary),
                          _SummaryChip(label: 'Succès', value: '${summary.success ?? 0}', color: AppColors.success),
                          _SummaryChip(label: 'Échec', value: '${summary.failed ?? 0}', color: AppColors.error),
                          _SummaryChip(label: 'En attente', value: '${summary.pending ?? 0}', color: AppColors.warning),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // ─── Corps ───────────────────────────────────────────────────
              Expanded(
                child: items.isEmpty
                        ? Center(
                            child: AppText(
                              'Aucun log trouvé',
                              fontSize: 13.rsp,
                              color: AppColors.textMuted,
                            ),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
                            itemCount: items.length,
                            separatorBuilder: (_, _) => SizedBox(height: 10.rh),
                            itemBuilder: (_, i) => _LogItem(log: items[i]),
                          ),
              ),

              // ─── Footer pagination ───────────────────────────────────────
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 12.rh),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border(top: BorderSide(color: AppColors.gray)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      'Page $_currentPage / $lastPage',
                      fontSize: 12.rsp,
                      color: AppColors.textMuted,
                    ),
                    Row(
                      spacing: 8.rw,
                      children: [
                        _PageBtn(
                          label: '← Précédent',
                          enabled: _currentPage > 1,
                          onTap: () => _fetch(page: _currentPage - 1),
                        ),
                        _PageBtn(
                          label: 'Suivant →',
                          enabled: _currentPage < lastPage,
                          onTap: () => _fetch(page: _currentPage + 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ─── Log item ─────────────────────────────────────────────────────────────────

class _LogItem extends StatelessWidget {
  final ProvisioningLogModel log;
  const _LogItem({required this.log});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 12.rh),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.rr),
        border: Border.all(color: AppColors.gray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: AppText(
                  log.phoneNumber ?? '—',
                  fontSize: 14.rsp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textHeading,
                ),
              ),
              _StatusBadge(status: log.status),
            ],
          ),
          SizedBox(height: 4.rh),
          AppText(
            log.productName ?? '—',
            fontSize: 12.rsp,
            color: AppColors.textMuted,
          ),
          SizedBox(height: 8.rh),
          Row(
            spacing: 12.rw,
            children: [
              _MetaChip(icon: Icons.repeat, label: '${log.attempts ?? 0} tentative(s)'),
              _MetaChip(icon: Icons.bolt_outlined, label: log.triggerType ?? '—'),
              if (log.amountDebited != null && log.amountDebited != '0.00')
                _MetaChip(icon: Icons.account_balance_wallet_outlined, label: '${log.amountDebited} F'),
              _MetaChip(icon: Icons.access_time, label: log.executedAt ?? '—'),
            ],
          ),
          if (log.errorMessage != null && log.errorMessage!.isNotEmpty) ...[
            SizedBox(height: 8.rh),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 6.rh),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(6.rr),
                border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
              ),
              child: AppText(
                log.errorMessage!,
                fontSize: 11.rsp,
                color: AppColors.error,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Widgets helpers ──────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String? status;
  const _StatusBadge({this.status});

  Color get _bg => switch (status) {
    'SUCCESS'      => const Color(0xFFF0FBF7),
    'ERROR'        => const Color(0xFFFEF2F2),
    'FAILED'       => const Color(0xFFFEF2F2),
    'DEBIT_FAILED' => const Color(0xFFFEF2F2),
    'PENDING'      => const Color(0xFFF0F5FF),
    'SKIPPED'      => const Color(0xFFF5F5F5),
    _              => const Color(0xFFF5F5F5),
  };

  Color get _fg => switch (status) {
    'SUCCESS'      => AppColors.success,
    'ERROR'        => AppColors.error,
    'FAILED'       => AppColors.error,
    'DEBIT_FAILED' => AppColors.error,
    'PENDING'      => AppColors.primary,
    _              => AppColors.textMuted,
  };

  Color get _border => switch (status) {
    'SUCCESS'      => const Color(0xFF9FE1CB),
    'ERROR'        => const Color(0xFFFCA5A5),
    'FAILED'       => const Color(0xFFFCA5A5),
    'DEBIT_FAILED' => const Color(0xFFFCA5A5),
    'PENDING'      => const Color(0xFFB5D4F4),
    _              => const Color(0xFFE0E0E0),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 4.rh),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(20.rr),
        border: Border.all(color: _border),
      ),
      child: AppText(
        status ?? '—',
        fontSize: 10.rsp,
        fontWeight: FontWeight.w700,
        color: _fg,
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MetaChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4.rw,
      children: [
        Icon(icon, size: 12.rsp, color: AppColors.textMuted),
        AppText(label, fontSize: 11.rsp, color: AppColors.textMuted),
      ],
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _SummaryChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 6.rh),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.rr),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6.rw,
        children: [
          AppText(value, fontSize: 14.rsp, fontWeight: FontWeight.w700, color: color),
          AppText(label, fontSize: 11.rsp, color: AppColors.textMuted),
        ],
      ),
    );
  }
}

class _PageBtn extends StatelessWidget {
  final String label;
  final bool enabled;
  final VoidCallback onTap;
  const _PageBtn({required this.label, required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 6.rh),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.rr),
          border: Border.all(color: enabled ? AppColors.primary : AppColors.gray),
        ),
        child: AppText(
          label,
          fontSize: 12.rsp,
          fontWeight: FontWeight.w500,
          color: enabled ? AppColors.primary : AppColors.textMuted,
        ),
      ),
    );
  }
}
