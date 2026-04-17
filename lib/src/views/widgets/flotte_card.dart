import 'dart:math';
import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';

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
      width: 466.rw,
      height: 237.rh,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.rr),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          _buildHeader(),
          const Divider(height: 1, color: Color(0xFFEEF0F6)),
          Expanded(child: _buildBody()),
          _buildStatsRow(),
          SizedBox(height: 12.rh),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 12.rh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText('Ma flotte', type: AppTextType.heading, fontSize: 13.rsp),
          AppText(
            '${_fmt(total)} numéros',
            type: AppTextType.small,
            color: AppColors.textMuted,
            fontSize: 11.rsp,
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    final pct = (_pctActifs * 100).round();
    return Padding(
      padding: EdgeInsets.fromLTRB(20.rw, 8.rh, 20.rw, 8.rh),
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: CustomPaint(
              painter: _DonutPainter(progress: _pctActifs),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText('$pct%', type: AppTextType.heading, color: AppColors.primary, fontSize: 15.rsp, fontStyle: FontStyle.italic),
                    AppText('Actifs', type: AppTextType.small, color: AppColors.textMuted, fontSize: 11.rsp),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 16.rw),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LegendRow(label: 'Actifs', count: actifs, total: total, color: AppColors.success),
                SizedBox(height: 8.rh),
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
      padding: EdgeInsets.symmetric(horizontal: 12.rw),
      child: Row(
        children: [
          Expanded(child: _StatBox(value: '$groupes', label: 'GROUPES', color: AppColors.success)),
          SizedBox(width: 8.rw),
          Expanded(child: _StatBox(value: '$employes', label: 'EMPLOYÉS', color: AppColors.primary)),
          SizedBox(width: 8.rw),
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
          width: 10.rw, height: 10.rw,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3.rr),
            border: isActive ? null : Border.all(color: AppColors.inputBorderLight),
          ),
        ),
        SizedBox(width: 8.rw),
        Expanded(child: AppText(label, type: AppTextType.body, fontSize: 12.rsp, fontWeight: FontWeight.w500)),
        AppText(_fmt(count), type: AppTextType.body, fontSize: 12.rsp, fontWeight: FontWeight.w700,
            color: isActive ? AppColors.primary : AppColors.textMuted),
        SizedBox(width: 8.rw),
        SizedBox(
          width: 32.rw,
          child: AppText('$pct%', type: AppTextType.small, fontSize: 11.rsp, fontWeight: FontWeight.w600,
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
      padding: EdgeInsets.fromLTRB(8.rw, 10.rh, 8.rw, 8.rh),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10.rr),
      ),
      child: Column(
        children: [
          AppText(value, type: AppTextType.heading, fontSize: 16.rsp, fontStyle: FontStyle.italic, color: color),
          SizedBox(height: 4.rh),
          AppText(label, type: AppTextType.small, fontSize: 9.rsp, color: AppColors.textMuted),
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
    final radius = size.width / 2 - 8;
    const strokeWidth = 10.0;
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
