import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'app_text.dart';
import 'app_button.dart';

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
      width: 338.rw,
      height: 390.rh,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.rr),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 16, offset: const Offset(0, 4))],
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
      padding: EdgeInsets.fromLTRB(24.rw, 20.rh, 20.rw, 16.rh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText('Activité récente', type: AppTextType.heading, fontSize: 20.rsp),
          AppButton(
            text: 'Tout',
            type: AppButtonType.outline,
            onPressed: onToutPressed,
            width: 60.rw,
            height: 29.rh,
            fontSize: 11.rsp,
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
      padding: EdgeInsets.fromLTRB(24.rw, 18.rh, 24.rw, 18.rh),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 13.rw,
            child: Column(
              children: [
                Container(width: 13.rw, height: 13.rw, decoration: BoxDecoration(color: item.dotColor, shape: BoxShape.circle)),
                if (!isLast)
                  Container(width: 2.rw, height: 52.rh, margin: EdgeInsets.only(top: 4.rh), color: const Color(0xFFEEF0F6)),
              ],
            ),
          ),
          SizedBox(width: 14.rw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(item.title, type: AppTextType.heading, fontSize: 16.rsp),
                SizedBox(height: 4.rh),
                AppText(item.meta, type: AppTextType.small, color: AppColors.textBody, fontSize: 12.rsp),
                SizedBox(height: 3.rh),
                AppText(item.date, type: AppTextType.small, color: AppColors.textMuted, fontSize: 12.rsp),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
