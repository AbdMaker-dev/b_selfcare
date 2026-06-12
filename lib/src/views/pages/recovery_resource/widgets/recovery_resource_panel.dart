import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/src/data/models/employee/fleet_number_model.dart';
import 'package:b_selfcare/src/data/models/resource_custom/free_unit_model.dart';
import 'package:b_selfcare/src/data/models/resource_custom/resource_custom_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

class RecoveryResourcePanel extends StatelessWidget {
  final List<FleetNumberModel> numbers;
  final int selectedIndex;
  final Map<int, ResourceCustomModel> resourcesCache;
  final int? loadingNumberId;

  const RecoveryResourcePanel({
    super.key,
    required this.numbers,
    required this.selectedIndex,
    required this.resourcesCache,
    required this.loadingNumberId,
  });

  @override
  Widget build(BuildContext context) {
    if (numbers.isEmpty) return const SizedBox.shrink();

    final selectedNumber = numbers[selectedIndex];
    final id = selectedNumber.id;
    final isLoading = id != null && loadingNumberId == id;
    final resource = id != null ? resourcesCache[id] : null;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.grayWh,
        borderRadius: BorderRadius.circular(12.rr),
        border: Border.all(color: AppColors.gray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête
          Padding(
            padding: EdgeInsets.fromLTRB(14.rw, 10.rh, 14.rw, 0),
            child: AppText(
              'GETSUBSCRIBERBALANCE CBS',
              fontSize: 10.rsp,
              fontWeight: FontWeight.w700,
              color: AppColors.textMuted,
              fontFamily: FontFamily.syne,
            ),
          ),

          SizedBox(height: 10.rh),

          if (isLoading)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32.rh),
              child: Center(
                child: CircularProgressIndicator(
                    color: AppColors.primary, strokeWidth: 2),
              ),
            )
          else if (resource == null)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32.rh),
              child: Center(
                child: AppText('Aucune ressource disponible',
                    fontSize: 13.rsp, color: AppColors.textMuted),
              ),
            )
          else ...[
            // 4 cartes métriques
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.rw),
              child: _MetricRow(resource: resource),
            ),

            SizedBox(height: 10.rh),

            // Estimation
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 14.rw, vertical: 10.rh),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.gray)),
              ),
              child: Row(
                children: [
                  AppText(
                    'Estimation récupération',
                    fontSize: 12.rsp,
                    color: AppColors.primary,
                  ),
                  const Spacer(),
                  AppText(
                    resource.mainCreditFcfa != null
                        ? '≈ ${_formatFcfa(resource.mainCreditFcfa!)} FCFA'
                        : '---',
                    fontSize: 12.rsp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  static String _formatFcfa(int value) {
    final s = value.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(' ');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}

class _MetricRow extends StatelessWidget {
  final ResourceCustomModel resource;

  const _MetricRow({required this.resource});

  FreeUnitModel? _unit(String measureUnit) =>
      resource.freeUnits?.where((u) => u.measureUnit == measureUnit).firstOrNull;

  String _smsValue() {
    final u = _unit('1101');
    if (u == null) return '---';
    return u.formattedTotalAmount ?? u.totalAmount?.toString() ?? '---';
  }

  String _dataValue() {
    final u = _unit('1106');
    if (u == null) return '---';
    if (u.formattedTotalAmount != null) return u.formattedTotalAmount!;
    final bytes = u.totalAmount ?? 0;
    if (bytes >= 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)}Go';
    } else if (bytes >= 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(0)}Mo';
    }
    return '${(bytes / 1024).toStringAsFixed(0)}Ko';
  }

  String _voixValue() {
    final u = _unit('1003');
    if (u == null) return '---';
    if (u.formattedTotalAmount != null) return u.formattedTotalAmount!;
    final secs = u.totalAmount ?? 0;
    return '${secs ~/ 60}min';
  }

  String _creditValue() {
    final v = resource.mainCreditFcfa;
    if (v == null) return '---';
    return '${RecoveryResourcePanel._formatFcfa(v)} FCFA';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _MetricCard(label: 'SMS', value: _smsValue()),
        SizedBox(width: 6.rw),
        _MetricCard(label: 'DATA', value: _dataValue()),
        SizedBox(width: 6.rw),
        _MetricCard(label: 'CRÉDIT', value: _creditValue()),
        SizedBox(width: 6.rw),
        _MetricCard(label: 'VOIX', value: _voixValue()),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;

  const _MetricCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.rh),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.rr),
          border: Border.all(color: AppColors.gray),
        ),
        child: Column(
          children: [
            AppText(
              label,
              fontSize: 10.rsp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
              fontFamily: FontFamily.syne,
            ),
            SizedBox(height: 4.rh),
            AppText(
              value,
              fontSize: 15.rsp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
