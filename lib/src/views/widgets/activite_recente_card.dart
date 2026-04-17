import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'app_text.dart';

enum ActivityType { provisioning, recharge, campagne, facture, utilisateur }

class ActivityItem {
  final ActivityType type;
  final String title;
  final String meta;
  final String date;

  const ActivityItem({required this.type, required this.title, required this.meta, required this.date});

  Color get dotColor => switch (type) {
    ActivityType.provisioning => AppColors.success,
    ActivityType.recharge     => AppColors.warning,
    ActivityType.campagne     => const Color(0xFF3B82F6),
    ActivityType.facture      => AppColors.success,
    ActivityType.utilisateur  => const Color(0xFFA78BFA),
  };
}

class ActiviteRecenteCard extends StatelessWidget {
  final List<ActivityItem> items;
  final VoidCallback? onToutPressed;

  const ActiviteRecenteCard({super.key, required this.items, this.onToutPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha:0.06), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const Divider(height: 1, color: Color(0xFFEEF0F6)),
          ...items.asMap().entries.map((e) => _ActivityRow(item: e.value, isLast: e.key == items.length - 1)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText('Activité récente', type: AppTextType.heading, fontSize: 20),
          OutlinedButton(
            onPressed: onToutPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textMuted,
              side: BorderSide(color: AppColors.inputBorderLight),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            ),
            child: AppText('Tout', type: AppTextType.small, fontSize: 13, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final ActivityItem item;
  final bool isLast;
  const _ActivityRow({required this.item, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: isLast ? null : const Border(bottom: BorderSide(color: Color(0xFFEEF0F6))),
      ),
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 13,
            child: Column(
              children: [
                Container(width: 13, height: 13, decoration: BoxDecoration(color: item.dotColor, shape: BoxShape.circle)),
                if (!isLast)
                  Container(width: 2, height: 52, margin: const EdgeInsets.only(top: 4), color: const Color(0xFFEEF0F6)),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(item.title, type: AppTextType.heading, fontSize: 16),
                const SizedBox(height: 4),
                AppText(item.meta, type: AppTextType.small, color: AppColors.textBody, fontSize: 12, fontFamily: 'monospace'),
                const SizedBox(height: 3),
                AppText(item.date, type: AppTextType.small, color: AppColors.textMuted, fontSize: 12, fontFamily: 'monospace'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}