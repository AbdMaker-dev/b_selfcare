import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'app_text.dart';

enum AlerteVariant { green, blue, yellow }

class AlerteItem {
  final String title;
  final String meta;
  final String value;
  final AlerteVariant variant;

  const AlerteItem({
    required this.title,
    required this.meta,
    required this.value,
    required this.variant,
  });

  Color get bgColor => switch (variant) {
    AlerteVariant.green  => const Color(0xFFF0FBF7),
    AlerteVariant.blue   => const Color(0xFFF0F5FF),
    AlerteVariant.yellow => const Color(0xFFFFFBEB),
  };

  Color get borderColor => switch (variant) {
    AlerteVariant.green  => const Color(0xFF9FE1CB),
    AlerteVariant.blue   => const Color(0xFFB5D4F4),
    AlerteVariant.yellow => const Color(0xFFFAC775),
  };

  Color get valueColor => switch (variant) {
    AlerteVariant.green  => AppColors.success,
    AlerteVariant.blue   => AppColors.primary,
    AlerteVariant.yellow => const Color(0xFFB45309),
  };
}

class AlertesSeuilsCard extends StatelessWidget {
  final List<AlerteItem> items;

  const AlertesSeuilsCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText('Alertes & seuils', type: AppTextType.heading, fontSize: 20),
                const SizedBox(height: 3),
                AppText(
                  'Notifications configurées',
                  type: AppTextType.small,
                  color: AppColors.textMuted,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEF0F6)),
          // Rows
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: items
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _AlerteRow(item: item),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlerteRow extends StatelessWidget {
  final AlerteItem item;
  const _AlerteRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: item.bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: item.borderColor),
      ),
      child: Row(
        children: [
          // Gauche
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  item.title,
                  type: AppTextType.body,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 3),
                AppText(
                  item.meta,
                  type: AppTextType.small,
                  fontSize: 12,
                  color: AppColors.textMuted,
                  fontFamily: 'monospace',
                ),
              ],
            ),
          ),
          // Valeur
          AppText(
            item.value,
            type: AppTextType.body,
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: item.valueColor,
            fontFamily: 'monospace',
          ),
        ],
      ),
    );
  }
}