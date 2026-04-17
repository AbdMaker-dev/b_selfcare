import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'app_text.dart';

class BalanceCard extends StatelessWidget {
  final double amount;
  final String unit;
  final String title;
  final String status;
  final String rechargeDate;
  final List<double> chartData;
  final Color? amountColor;
  final Color? chartColor;

  const BalanceCard({
    super.key,
    this.amount = 2.85,
    this.unit = 'M FCFA',
    this.status = 'Sain',
    this.rechargeDate = '01/04',
    this.chartData = const [0.1, 0.15, 0.2, 0.35, 0.5, 0.65, 0.8, 1.0],
    this.amountColor,
    this.chartColor,
    this.title = 'Solde Principal',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 349.rw,
      height: 148.rh,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.rr),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha:  0.06), blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 79.rh,
            child: CustomPaint(
              size: Size.infinite,
              painter: _CurvePainter(data: chartData, color: chartColor ?? AppColors.success),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 12.rh),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  title,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textMuted,
                  fontSize: 11.5.rsp,
                ),
                SizedBox(height: 5.rh),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    AppText(
                      amount.toStringAsFixed(2),
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary,
                      fontSize: 40.rsp,
                      fontStyle: FontStyle.italic,
                    ),
                    SizedBox(width: 8.0.rh),
                    AppText(
                      unit,
                      fontWeight: FontWeight.w400,
                      color: chartColor?? AppColors.success,
                      fontSize: 15.rsp,
                    ),
                  ],
                ),
                SizedBox(height: 6.rh),
                Row(
                  children: [
                    Icon(Icons.arrow_upward, size: 11.rsp, color: AppColors.success),
                    const SizedBox(width: 4),
                    AppText(
                      '$status · rechargé le $rechargeDate',
                      fontWeight: FontWeight.w400,
                      color: chartColor ?? AppColors.success,
                      fontSize: 11.rsp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CurvePainter extends CustomPainter {
  final List<double> data;
  final Color color;
  const _CurvePainter({required this.data, required this.color});

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
        colors: [color.withValues(alpha: 0.2), color.withValues(alpha: 0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)));

    canvas.drawPath(path, Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round);

    canvas.drawCircle(points.last, 5, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_CurvePainter old) => old.data != data || old.color != color;
}