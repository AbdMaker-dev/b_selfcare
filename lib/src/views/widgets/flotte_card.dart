import 'dart:math';
import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';

import 'app_text.dart';

class FlotteCard extends StatelessWidget {
  final int total;
  final int actifs;
  final int suspendus;
  final int groupes;
  final int employes;
  final int simStock;

  const FlotteCard({
    super.key,
    this.total = 1240,
    this.actifs = 1240,
    this.suspendus = 0,
    this.groupes = 8,
    this.employes = 1150,
    this.simStock = 6200,
  });

  double get _pctActifs => total == 0 ? 0 : actifs / total;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          _buildHeader(),
          const Divider(height: 1, color: Color(0xFFEEF0F6)),
          _buildBody(),
          _buildStatsRow(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText('Ma flotte', type: AppTextType.heading, fontSize: 20),
          AppText(
            '${_fmt(total)} numéros',
            type: AppTextType.small,
            color: AppColors.textMuted,
            fontSize: 13,
            fontFamily: 'monospace',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    final pct = (_pctActifs * 100).round();
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      child: Row(
        children: [
          SizedBox(
            width: 120, height: 120,
            child: CustomPaint(
              painter: _DonutPainter(progress: _pctActifs),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText('$pct%', type: AppTextType.heading, color: AppColors.primary, fontSize: 22, fontStyle: FontStyle.italic),
                    AppText('Actifs', type: AppTextType.small, color: AppColors.textMuted, fontSize: 11),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 28),
          Expanded(
            child: Column(
              children: [
                _LegendRow(label: 'Actifs', count: actifs, total: total, color: AppColors.success),
                const SizedBox(height: 8),
                _LegendRow(label: 'Suspendus', count: suspendus, total: total, color: const Color(0xFFE2E8F0)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    String formatSim(int v) => v >= 1000 ? '${(v / 1000).toStringAsFixed(1)}K' : '$v';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: _StatBox(value: '$groupes', label: 'GROUPES', color: AppColors.success)),
          const SizedBox(width: 10),
          Expanded(child: _StatBox(value: '$employes', label: 'EMPLOYÉS', color: AppColors.primary)),
          const SizedBox(width: 10),
          Expanded(child: _StatBox(value: formatSim(simStock), label: 'SIM STOCK', color: AppColors.primary)),
        ],
      ),
    );
  }

  String _fmt(int n) =>
      n.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]} ');
}

class _LegendRow extends StatelessWidget {
  final String label;
  final int count;
  final int total;
  final Color color;
  const _LegendRow({required this.label, required this.count, required this.total, required this.color});

  @override
  Widget build(BuildContext context) {
    final pct = total == 0 ? 0 : (count / total * 100).round();
    final isActive = count > 0;
    return Row(
      children: [
        Container(
          width: 14, height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
            border: isActive ? null : Border.all(color: AppColors.inputBorderLight),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: AppText(label, type: AppTextType.body, fontSize: 15, fontWeight: FontWeight.w500)),
        AppText(_fmt(count), type: AppTextType.body, fontSize: 15, fontWeight: FontWeight.w700,
            color: isActive ? AppColors.primary : AppColors.textMuted),
        const SizedBox(width: 12),
        SizedBox(
          width: 40,
          child: AppText('$pct%', type: AppTextType.small, fontSize: 13, fontWeight: FontWeight.w600,
              textAlign: TextAlign.right,
              color: isActive ? AppColors.success : AppColors.textMuted),
        ),
      ],
    );
  }

  String _fmt(int n) =>
      n.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]} ');
}

class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const _StatBox({required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          AppText(value, type: AppTextType.heading, fontSize: 28, fontStyle: FontStyle.italic, color: color),
          const SizedBox(height: 6),
          AppText(label, type: AppTextType.small, fontSize: 9, color: AppColors.textMuted, fontFamily: 'monospace'),
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final double progress;
  const _DonutPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    const strokeWidth = 14.0;
    canvas.drawCircle(center, radius, Paint()
      ..color = AppColors.success.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, 2 * pi * progress, false,
      Paint()
        ..color = AppColors.success
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_DonutPainter old) => old.progress != progress;
}