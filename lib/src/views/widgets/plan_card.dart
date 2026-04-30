import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:flutter/material.dart';
import 'app_text.dart';

enum PlanStatus { active, archive }

class PlanFeature {
  final String label;
  final String value;
  final String unit;

  const PlanFeature({
    required this.label,
    required this.value,
    required this.unit,
  });
}

class PlanCard extends StatelessWidget {
  final String name;
  final PlanStatus status;
  final List<PlanFeature> features;
  final VoidCallback? onTap;

  const PlanCard({
    super.key,
    required this.name,
    required this.features,
    this.status = PlanStatus.active,
    this.onTap,
  });

  String get _statusLabel => switch (status) {
    PlanStatus.active  => 'ACTIF',
    PlanStatus.archive => 'ARCHIVÉ',
  };

  Color get _badgeBg => switch (status) {
    PlanStatus.active  => const Color(0xFFF0FBF7),
    PlanStatus.archive => const Color(0xFFF1F5FF),
  };

  Color get _badgeBorder => switch (status) {
    PlanStatus.active  => const Color(0xFF9FE1CB),
    PlanStatus.archive => AppColors.inputBorderLight,
  };

  Color get _badgeText => switch (status) {
    PlanStatus.active  => AppColors.success,
    PlanStatus.archive => AppColors.textMuted,
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
            Expanded(child: _buildFeatureRow()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          name,
          fontSize: 15.rsp,
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        ),
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
            fontSize: 11.rsp,
            fontWeight: FontWeight.w700,
            color: _badgeText,
          ),
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
              Expanded(child: _FeatureBox(feature: features[0])),
              SizedBox(width: 8.rw),
              Expanded(child: _FeatureBox(feature: features[1])),
            ],
          ),
        ),
        SizedBox(height: 8.rh),
        Expanded(
          child: Row(
            children: [
              Expanded(child: _FeatureBox(feature: features[2])),
              SizedBox(width: 8.rw),
              Expanded(child: _FeatureBox(feature: features[3])),
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

        children: [
          AppText(
            feature.label,
            type: AppTextType.small,
            fontSize: 10.rsp,
            color: AppColors.textMuted,
            fontWeight: FontWeight.w400,
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
                fontSize: 9.5.rsp,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
