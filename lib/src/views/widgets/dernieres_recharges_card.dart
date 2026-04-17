import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'app_text.dart';

enum RechargeStatus { confirme, enAttente, echoue }

enum RechargeProvider { mixx, wave, orangeMoney }

class RechargeItem {
  final RechargeProvider provider;
  final String date;
  final int montant;
  final RechargeStatus status;

  const RechargeItem({
    required this.provider,
    required this.date,
    required this.montant,
    this.status = RechargeStatus.confirme,
  });

  String get providerName => switch (provider) {
    RechargeProvider.mixx        => 'Mixx by Yas',
    RechargeProvider.wave        => 'Wave',
    RechargeProvider.orangeMoney => 'Orange Money',
  };

  // Chemin de l'asset image
  String get assetPath => switch (provider) {
    RechargeProvider.mixx        => 'assets/images/providers/mixx.png',
    RechargeProvider.wave        => 'assets/images/providers/wave.png',
    RechargeProvider.orangeMoney => 'assets/images/providers/orange_money.png',
  };

  String get statusLabel => switch (status) {
    RechargeStatus.confirme  => 'CONFIRMÉ',
    RechargeStatus.enAttente => 'EN ATTENTE',
    RechargeStatus.echoue    => 'ÉCHOUÉ',
  };

  Color get badgeBg => switch (status) {
    RechargeStatus.confirme  => const Color(0xFFF0FBF7),
    RechargeStatus.enAttente => const Color(0xFFFFFBEB),
    RechargeStatus.echoue    => const Color(0xFFFEF2F2),
  };

  Color get badgeBorder => switch (status) {
    RechargeStatus.confirme  => const Color(0xFF9FE1CB),
    RechargeStatus.enAttente => const Color(0xFFFAC775),
    RechargeStatus.echoue    => const Color(0xFFFCA5A5),
  };

  Color get badgeText => switch (status) {
    RechargeStatus.confirme  => AppColors.success,
    RechargeStatus.enAttente => const Color(0xFFB45309),
    RechargeStatus.echoue    => AppColors.error,
  };
}

class DernieresRechargesCard extends StatelessWidget {
  final List<RechargeItem> recharges;
  final VoidCallback? onVoirTout;

  const DernieresRechargesCard({
    super.key,
    required this.recharges,
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
          ...recharges.asMap().entries.map((e) => _RechargeRow(
                item: e.value,
                isLast: e.key == recharges.length - 1,
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
          AppText('Dernières recharges', type: AppTextType.heading, fontSize: 22),
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

class _RechargeRow extends StatelessWidget {
  final RechargeItem item;
  final bool isLast;

  const _RechargeRow({required this.item, required this.isLast});

  String _formatMontant(int m) {
    return m.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'),
      (match) => '${match[1]} ',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: isLast ? null : const Border(bottom: BorderSide(color: Color(0xFFEEF0F6))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          // Logo provider
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFEEF0F6)),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              item.assetPath,
              fit: BoxFit.cover,
              // Fallback si l'image n'existe pas encore
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.background,
                child: Center(
                  child: AppText(
                    item.providerName[0],
                    type: AppTextType.heading,
                    fontSize: 20,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Nom + date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(item.providerName, type: AppTextType.heading, fontSize: 18, color: AppColors.primary),
                const SizedBox(height: 4),
                AppText(item.date, type: AppTextType.small, fontSize: 12, color: AppColors.textMuted, fontFamily: 'monospace'),
              ],
            ),
          ),
          // Montant + badge
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(
                '+${_formatMontant(item.montant)} Fcfa',
                type: AppTextType.body,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: AppColors.success,
                fontFamily: 'monospace',
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: item.badgeBg,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: item.badgeBorder, width: 1.5),
                ),
                child: AppText(
                  item.statusLabel,
                  type: AppTextType.small,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: item.badgeText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}