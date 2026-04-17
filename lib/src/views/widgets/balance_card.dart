import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'app_text.dart';

class BalanceCard extends StatelessWidget {
  final double amount;
  final String unit;
  final String status;
  final String rechargeDate;
  final List<double> chartData;

  const BalanceCard({
    super.key,
    this.amount = 2.85,
    this.unit = 'M FCFA',
    this.status = 'Sain',
    this.rechargeDate = '01/04',
    this.chartData = const [0.1, 0.15, 0.2, 0.35, 0.5, 0.65, 0.8, 1.0],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'SOLDE DISPONIBLE',
                  type: AppTextType.small,
                  color: AppColors.textMuted,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    AppText(
                      amount.toStringAsFixed(2),
                      type: AppTextType.heading,
                      color: AppColors.primary,
                      fontSize: 52,
                      fontStyle: FontStyle.italic,
                    ),
                    const SizedBox(width: 8),
                    AppText(
                      unit,
                      type: AppTextType.heading,
                      color: AppColors.success,
                      fontSize: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.arrow_upward, size: 14, color: AppColors.success),
                    const SizedBox(width: 4),
                    AppText(
                      '$status · rechargé le $rechargeDate',
                      type: AppTextType.small,
                      color: AppColors.success,
                      fontSize: 13,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          SizedBox(
            height: 110,
            width: double.infinity,
            child: CustomPaint(painter: _CurvePainter(data: chartData)),
          ),
        ],
      ),
    );
  }
}

class _CurvePainter extends CustomPainter {
  final List<double> data;
  const _CurvePainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    final points = <Offset>[];
    for (int i = 0; i < data.length; i++) {
      points.add(Offset(
        (i / (data.length - 1)) * size.width,
        size.height - (data[i] * (size.height - 20)) - 10,
      ));
    }

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length - 1; i++) {
      final cp1 = Offset(points[i].dx + (points[i+1].dx - points[i].dx) / 2, points[i].dy);
      final cp2 = Offset(points[i].dx + (points[i+1].dx - points[i].dx) / 2, points[i+1].dy);
      path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, points[i+1].dx, points[i+1].dy);
    }

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fillPath, Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.success.withOpacity(0.2), AppColors.success.withOpacity(0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)));

    canvas.drawPath(path, Paint()
      ..color = AppColors.success
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round);

    canvas.drawCircle(points.last, 5, Paint()..color = AppColors.success);
  }

  @override
  bool shouldRepaint(_CurvePainter old) => old.data != data;
}