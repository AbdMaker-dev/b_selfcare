import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';

import 'app_text.dart';

enum PeriodFilter { j14, j30, m3 }

class ProvisioningChartCard extends StatefulWidget {
  const ProvisioningChartCard({super.key});

  @override
  State<ProvisioningChartCard> createState() => _ProvisioningChartCardState();
}

class _ProvisioningChartCardState extends State<ProvisioningChartCard> {
  PeriodFilter _period = PeriodFilter.j14;

  final Map<PeriodFilter, List<_BarData>> _data = {
    PeriodFilter.j14: _generateData(14),
    PeriodFilter.j30: _generateData(30),
    PeriodFilter.m3:  _generateData(90),
  };

  static List<_BarData> _generateData(int n) {
    final now = DateTime.now();
    return List.generate(n, (i) {
      final date = now.subtract(Duration(days: n - 1 - i));
      final label = '${date.day.toString().padLeft(2,'0')}/${date.month.toString().padLeft(2,'0')}';
      return _BarData(label: label, value: 1180 + (i * 7 % 130).toDouble());
    });
  }

  String get _periodLabel => switch (_period) {
    PeriodFilter.j14 => '14 jours',
    PeriodFilter.j30 => '30 jours',
    PeriodFilter.m3  => '3 mois',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1073.rw,
      height: 390.rh,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.rr),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      padding: EdgeInsets.fromLTRB(20.rw, 20.rh, 20.rw, 12.rh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 16.rh),
          Expanded(child: _BarChart(data: _data[_period]!, maxValue: 1500)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText('Provisioning - $_periodLabel', type: AppTextType.heading, fontSize: 16.rsp),
              SizedBox(height: 4.rh),
              AppText('SUCCESS · ERROR · BLOCKED', type: AppTextType.small, color: AppColors.textMuted, fontSize: 11.rsp),
            ],
          ),
        ),
        _PeriodSelector(selected: _period, onChanged: (p) => setState(() => _period = p)),
      ],
    );
  }
}

class _PeriodSelector extends StatelessWidget {
  final PeriodFilter selected;
  final ValueChanged<PeriodFilter> onChanged;
  const _PeriodSelector({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _PeriodBtn(label: '14j', value: PeriodFilter.j14, selected: selected, onTap: onChanged),
        SizedBox(width: 4.rw),
        _PeriodBtn(label: '30j', value: PeriodFilter.j30, selected: selected, onTap: onChanged),
        SizedBox(width: 4.rw),
        _PeriodBtn(label: '3m',  value: PeriodFilter.m3,  selected: selected, onTap: onChanged),
      ],
    );
  }
}

class _PeriodBtn extends StatelessWidget {
  final String label;
  final PeriodFilter value;
  final PeriodFilter selected;
  final ValueChanged<PeriodFilter> onTap;
  const _PeriodBtn({required this.label, required this.value, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isActive = value == selected;
    return GestureDetector(
      onTap: () => onTap(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 5.rh),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8.rr),
          border: Border.all(color: isActive ? AppColors.primary : AppColors.inputBorderLight),
        ),
        child: AppText(
          label,
          type: AppTextType.small,
          fontSize: 12.rsp,
          fontWeight: FontWeight.w500,
          color: isActive ? AppColors.white : AppColors.textMuted,
        ),
      ),
    );
  }
}

class _BarData {
  final String label;
  final double value;
  const _BarData({required this.label, required this.value});
}

class _BarChart extends StatelessWidget {
  final List<_BarData> data;
  final double maxValue;
  const _BarChart({required this.data, required this.maxValue});

  @override
  Widget build(BuildContext context) {
    final labelStep = data.length <= 14 ? 1 : data.length <= 30 ? 2 : 7;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(16, (i) => AppText(
            '${(15 - i) * 100}',
            type: AppTextType.small,
            fontSize: 9.rsp,
            color: AppColors.textMuted,
          )),
        ),
        SizedBox(width: 8.rw),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: CustomPaint(
                  painter: _BarChartPainter(data: data, maxValue: maxValue),
                  child: const SizedBox.expand(),
                ),
              ),
              SizedBox(height: 6.rh),
              Row(
                children: data.asMap().entries.map((e) => Expanded(
                  child: AppText(
                    e.key % labelStep == 0 ? e.value.label : '',
                    type: AppTextType.small,
                    fontSize: 9.rsp,
                    color: AppColors.textMuted,
                    textAlign: TextAlign.center,
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final List<_BarData> data;
  final double maxValue;
  const _BarChartPainter({required this.data, required this.maxValue});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()..color = const Color(0xFFE2E8F0)..strokeWidth = 0.5;
    for (int i = 0; i <= 15; i++) {
      final y = size.height - (i / 15) * size.height;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    if (data.isEmpty) return;
    const gap = 4.0;
    final barWidth = (size.width - gap * (data.length - 1)) / data.length;
    for (int i = 0; i < data.length; i++) {
      final barHeight = (data[i].value / maxValue) * size.height;
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(i * (barWidth + gap), size.height - barHeight, barWidth, barHeight),
          topLeft: const Radius.circular(4), topRight: const Radius.circular(4),
        ),
        Paint()..color = AppColors.success,
      );
    }
  }

  @override
  bool shouldRepaint(_BarChartPainter old) => old.data != data;
}
