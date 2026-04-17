import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'app_text.dart';
import 'app_button.dart';

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
              children: recharges.asMap().entries.map((e) => _RechargeRow(
                item: e.value,
                isLast: e.key == recharges.length - 1,
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
          AppText('Dernières recharges', type: AppTextType.heading, fontSize: 13.rsp),
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
      padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 10.rh),
      child: Row(
        children: [
          Container(
            width: 36.rw,
            height: 36.rw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.rr),
              border: Border.all(color: const Color(0xFFEEF0F6)),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              item.assetPath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.background,
                child: Center(
                  child: AppText(item.providerName[0], type: AppTextType.heading, fontSize: 13.rsp, color: AppColors.primary),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.rw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(item.providerName, type: AppTextType.heading, fontSize: 13.rsp, color: AppColors.primary),
                SizedBox(height: 3.rh),
                AppText(item.date, type: AppTextType.small, fontSize: 11.rsp, color: AppColors.textMuted),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(
                '+${_formatMontant(item.montant)} Fcfa',
                type: AppTextType.body,
                fontSize: 13.rsp,
                fontWeight: FontWeight.w800,
                color: AppColors.success,
              ),
              SizedBox(height: 5.rh),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.rw, vertical: 4.rh),
                decoration: BoxDecoration(
                  color: item.badgeBg,
                  borderRadius: BorderRadius.circular(20.rr),
                  border: Border.all(color: item.badgeBorder, width: 1),
                ),
                child: AppText(item.statusLabel, type: AppTextType.small, fontSize: 10.rsp, fontWeight: FontWeight.w800, color: item.badgeText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
