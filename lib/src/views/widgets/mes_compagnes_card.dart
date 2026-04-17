import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'app_text.dart';
import 'app_button.dart';

enum CampagneStatus { succes, erreur, enCours, planifie }

class CampagneItem {
  final String name;
  final String meta;
  final CampagneStatus status;

  const CampagneItem({
    required this.name,
    required this.meta,
    this.status = CampagneStatus.succes,
  });

  String get statusLabel => switch (status) {
    CampagneStatus.succes   => 'SUCCÈS',
    CampagneStatus.erreur   => 'ERREUR',
    CampagneStatus.enCours  => 'EN COURS',
    CampagneStatus.planifie => 'PLANIFIÉ',
  };

  Color get badgeBg => switch (status) {
    CampagneStatus.succes   => const Color(0xFFF0FBF7),
    CampagneStatus.erreur   => const Color(0xFFFEF2F2),
    CampagneStatus.enCours  => const Color(0xFFF0F5FF),
    CampagneStatus.planifie => const Color(0xFFFFFBEB),
  };

  Color get badgeBorder => switch (status) {
    CampagneStatus.succes   => const Color(0xFF9FE1CB),
    CampagneStatus.erreur   => const Color(0xFFFCA5A5),
    CampagneStatus.enCours  => const Color(0xFFB5D4F4),
    CampagneStatus.planifie => const Color(0xFFFAC775),
  };

  Color get badgeText => switch (status) {
    CampagneStatus.succes   => AppColors.success,
    CampagneStatus.erreur   => AppColors.error,
    CampagneStatus.enCours  => AppColors.primary,
    CampagneStatus.planifie => const Color(0xFFB45309),
  };
}

class MesCampagnesCard extends StatelessWidget {
  final List<CampagneItem> campagnes;
  final VoidCallback? onVoirTout;

  const MesCampagnesCard({
    super.key,
    required this.campagnes,
    this.onVoirTout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 466.rw,
      height: 237.rh,
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
          _buildHeader(),
          const Divider(height: 1, color: Color(0xFFEEF0F6)),
          Expanded(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              children: campagnes.asMap().entries.map((e) => _CampagneRow(
                item: e.value,
                isLast: e.key == campagnes.length - 1,
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.rw, 12.rh, 16.rw, 12.rh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText('Mes campagnes', type: AppTextType.heading, fontSize: 13.rsp),
          AppButton(
            text: 'Voir tout →',
            type: AppButtonType.outline,
            onPressed: onVoirTout,
            width: 80.rw,
            height: 29.rh,
            fontSize: 11.rsp,
          ),
        ],
      ),
    );
  }
}

class _CampagneRow extends StatelessWidget {
  final CampagneItem item;
  final bool isLast;

  const _CampagneRow({required this.item, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: isLast ? null : const Border(bottom: BorderSide(color: Color(0xFFEEF0F6))),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 12.rh),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(item.name, type: AppTextType.heading, fontSize: 13.rsp, color: AppColors.primary),
                SizedBox(height: 4.rh),
                AppText(item.meta, type: AppTextType.small, fontSize: 11.rsp, color: AppColors.textMuted),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 5.rh),
            decoration: BoxDecoration(
              color: item.badgeBg,
              borderRadius: BorderRadius.circular(20.rr),
              border: Border.all(color: item.badgeBorder, width: 1),
            ),
            child: AppText(item.statusLabel, type: AppTextType.small, fontSize: 10.rsp, fontWeight: FontWeight.w800, color: item.badgeText),
          ),
        ],
      ),
    );
  }
}
