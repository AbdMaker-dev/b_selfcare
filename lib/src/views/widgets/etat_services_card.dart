import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
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
            padding: EdgeInsets.fromLTRB(20.rw, 12.rh, 20.rw, 12.rh),
            child: AppText('État des services', type: AppTextType.heading, fontSize: 13.rsp),
          ),
          const Divider(height: 1, color: Color(0xFFEEF0F6)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.rw),
              child: Column(
                children: services.map((s) => Padding(
                  padding: EdgeInsets.only(bottom: 8.rh),
                  child: _ServiceRow(item: s),
                )).toList(),
              ),
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
      padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 10.rh),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.rr),
        border: Border.all(color: const Color(0xFFEEF0F6)),
      ),
      child: Row(
        children: [
          Text(item.icon, style: TextStyle(fontSize: 15.rsp)),
          SizedBox(width: 10.rw),
          Expanded(
            child: AppText(item.name, type: AppTextType.body, fontSize: 13.rsp, fontWeight: FontWeight.w600, color: AppColors.primary),
          ),
          AppText(item.meta, type: AppTextType.small, fontSize: 11.rsp, color: AppColors.textMuted),
          SizedBox(width: 8.rw),
          Container(
            width: 9.rw,
            height: 9.rw,
            decoration: BoxDecoration(color: item.dotColor, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}
