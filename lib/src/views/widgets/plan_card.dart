import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_text.dart';

enum PlanStatus { active, archive }

class PlanFeature {
  final String label;
  final String value;
  final String unit;
  final int? price;

  const PlanFeature({
    required this.label,
    required this.value,
    required this.unit,
    this.price,
  });
}

class PlanCard extends StatelessWidget {
  final String name;
  final PlanStatus status;
  final List<PlanFeature> features;
  final num? price;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDuplicate;
  final VoidCallback? onArchive;

  const PlanCard({
    super.key,
    required this.name,
    required this.features,
    this.status = PlanStatus.active,
    this.price,
    this.onTap,
    this.onEdit,
    this.onDuplicate,
    this.onArchive,
  });

  String get _statusLabel => switch (status) {
    PlanStatus.active  => 'ACTIF',
    PlanStatus.archive => 'ARCHIVÉ',
  };

  Color get _badgeBg => switch (status) {
    PlanStatus.active  => const Color(0xFFF0FBF7),
    PlanStatus.archive => const Color(0xFFFFF4F4),
  };

  Color get _badgeBorder => switch (status) {
    PlanStatus.active  => const Color(0xFF9FE1CB),
    PlanStatus.archive => const Color(0xFFFFCDD2),
  };

  Color get _badgeText => switch (status) {
    PlanStatus.active  => AppColors.success,
    PlanStatus.archive => AppColors.error,
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.rw, vertical: 14.rh),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.rr),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 12.rh),
            Expanded(
              child: features.isEmpty
              ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5.rw, color: AppColors.inputBorder),
                  borderRadius: BorderRadius.circular(5.r)
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.layers_outlined, size: 16, color: AppColors.textMuted),
                      SizedBox(width: 6.rw),
                      AppText('Aucun quota configuré', fontSize: 11.rsp, color: AppColors.textMuted),
                    ],
                  ),
                ),
              ) : _buildFeatureRow(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                name,
                fontSize: 17.rsp,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
                overflow: TextOverflow.ellipsis,
              ),
              if (price != null) ...[
                SizedBox(height: 2.rh),
                Row(
                  children: [
                    AppText(
                      '$price',
                      fontSize: 15.rsp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.warning,
                    ),
                    SizedBox(width: 3.rw),
                    AppText(
                      'FCFA',
                      fontSize: 12.rsp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 5.rh),
              decoration: BoxDecoration(
                color: _badgeBg,
                borderRadius: BorderRadius.circular(30.rr),
                border: Border.all(color: _badgeBorder, width: 1.5),
              ),
              child: AppText(
                _statusLabel,
                type: AppTextType.small,
                fontSize: 12.rsp,
                fontWeight: FontWeight.w700,
                color: _badgeText,
              ),
            ),
            if (onDuplicate != null) ...[
              SizedBox(width: 8.rw),
              GestureDetector(
                onTap: onDuplicate,
                child: Container(
                  padding: EdgeInsets.all(6.rw),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8.rr),
                    border: Border.all(color: AppColors.inputBorder),
                  ),
                  child: Icon(Icons.copy_outlined, size: 14.rsp, color: AppColors.textMuted),
                ),
              ),
            ],
            if (onEdit != null) ...[
              SizedBox(width: 8.rw),
              GestureDetector(
                onTap: onEdit,
                child: Container(
                  padding: EdgeInsets.all(6.rw),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8.rr),
                    border: Border.all(color: AppColors.inputBorder),
                  ),
                  child: Icon(Icons.edit_outlined, size: 14.rsp, color: AppColors.primary),
                ),
              ),
            ],
            if (onArchive != null) ...[
              SizedBox(width: 6.rw),
              GestureDetector(
                onTap: onArchive,
                child: Container(
                  padding: EdgeInsets.all(6.rw),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF4F4),
                    borderRadius: BorderRadius.circular(8.rr),
                    border: Border.all(color: const Color(0xFFFFCDD2)),
                  ),
                  child: Icon(Icons.archive_outlined, size: 14.rsp, color: AppColors.error),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureRow() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(child: features.isNotEmpty ?  _FeatureBox(feature: features[0]) : SizedBox()),
              SizedBox(width: 8.rw),
              Expanded(child: features.length>= 2 ? _FeatureBox(feature: features[1]): SizedBox()),
            ],
          ),
        ),
        SizedBox(height: 8.rh),
        Expanded(
          child: Row(
            children: [
              Expanded(child: features.length>= 3 ?  _FeatureBox(feature: features[2]) : SizedBox()),
              SizedBox(width: 8.rw),
              Expanded(child: features.length>= 4 ?  _FeatureBox(feature: features[3]) : SizedBox()),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeatureBox extends StatelessWidget {
  final PlanFeature feature;
  const _FeatureBox({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 6.rh),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10.rr),
        border: Border.all(color: AppColors.inputBorder, width: 1.5.rr)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                feature.label,
                type: AppTextType.small,
                fontSize: 13.rsp,
                color: AppColors.textMuted,
                fontWeight: FontWeight.w400,
              ),
              if (feature.price != null)
                AppText(
                  '${feature.price} F',
                  fontSize: 11.rsp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.success,
                ),
            ],
          ),
          SizedBox(height: 2.rh),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              AppText(
                feature.value,
                type: AppTextType.heading,
                fontSize: 14.rsp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
              SizedBox(width: 3.rw),
              AppText(
                feature.unit,
                type: AppTextType.body,
                fontSize: 11.rsp,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
