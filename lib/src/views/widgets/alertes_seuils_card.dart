import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
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
      width: 708.rw,
      height: 251.rh,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.rr),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.rw, 12.rh, 20.rw, 10.rh),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText('Alertes & seuils', type: AppTextType.heading, fontSize: 13.rsp),
                SizedBox(height: 3.rh),
                AppText('Notifications configurées', type: AppTextType.small, color: AppColors.textMuted, fontSize: 11.rsp),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEF0F6)),
          Expanded(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(12.rw),
              itemCount: items.length,
              separatorBuilder: (_, _) => SizedBox(height: 8.rh),
              itemBuilder: (_, i) => _AlerteRow(item: items[i]),
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
      padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 10.rh),
      decoration: BoxDecoration(
        color: item.bgColor,
        borderRadius: BorderRadius.circular(10.rr),
        border: Border.all(color: item.borderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(item.title, type: AppTextType.body, fontSize: 13.rsp, fontWeight: FontWeight.w700, color: AppColors.primary),
                SizedBox(height: 3.rh),
                AppText(item.meta, type: AppTextType.small, fontSize: 11.rsp, color: AppColors.textMuted),
              ],
            ),
          ),
          AppText(item.value, type: AppTextType.body, fontSize: 13.rsp, fontWeight: FontWeight.w800, color: item.valueColor),
        ],
      ),
    );
  }
}
