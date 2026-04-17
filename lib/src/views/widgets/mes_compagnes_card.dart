import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'app_text.dart';

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
          _buildHeader(),
          const Divider(height: 1, color: Color(0xFFEEF0F6)),
          ...campagnes.asMap().entries.map((e) => _CampagneRow(
                item: e.value,
                isLast: e.key == campagnes.length - 1,
              )),
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
          AppText('Mes campagnes', type: AppTextType.heading, fontSize: 22),
          OutlinedButton(
            onPressed: onVoirTout,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textMuted,
              side: BorderSide(color: AppColors.inputBorderLight),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            ),
            child: AppText(
              'Voir tout →',
              type: AppTextType.small,
              fontSize: 13,
              color: AppColors.textMuted,
              fontFamily: 'monospace',
            ),
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          // Gauche
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  item.name,
                  type: AppTextType.heading,
                  fontSize: 17,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 5),
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
          // Badge statut
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
            decoration: BoxDecoration(
              color: item.badgeBg,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: item.badgeBorder, width: 1.5),
            ),
            child: AppText(
              item.statusLabel,
              type: AppTextType.small,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: item.badgeText,
            ),
          ),
        ],
      ),
    );
  }
}