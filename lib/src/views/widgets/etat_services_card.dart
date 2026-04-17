import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'app_text.dart';

enum ServiceStatus { ok, warning, error }

class ServiceItem {
  final String icon;
  final String name;
  final String meta;
  final ServiceStatus status;

  const ServiceItem({
    required this.icon,
    required this.name,
    required this.meta,
    this.status = ServiceStatus.ok,
  });

  Color get dotColor => switch (status) {
    ServiceStatus.ok      => AppColors.success,
    ServiceStatus.warning => AppColors.warning,
    ServiceStatus.error   => AppColors.error,
  };
}

class EtatServicesCard extends StatelessWidget {
  final List<ServiceItem> services;

  const EtatServicesCard({super.key, required this.services});

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
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
            child: AppText('État des services', type: AppTextType.heading, fontSize: 20),
          ),
          const Divider(height: 1, color: Color(0xFFEEF0F6)),
          // Liste
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: services
                  .map((s) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _ServiceRow(item: s),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceRow extends StatelessWidget {
  final ServiceItem item;
  const _ServiceRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEEF0F6)),
      ),
      child: Row(
        children: [
          // Icône
          Text(item.icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          // Nom
          Expanded(
            child: AppText(
              item.name,
              type: AppTextType.body,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          // Meta + dot
          AppText(
            item.meta,
            type: AppTextType.small,
            fontSize: 12,
            color: AppColors.textMuted,
            fontFamily: 'monospace',
          ),
          const SizedBox(width: 8),
          Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              color: item.dotColor,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}