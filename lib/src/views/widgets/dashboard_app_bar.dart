import 'package:b_selfcare/gen/assets.gen.dart';
import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';

import 'app_text.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String companyName;
  final String solde;
  final bool isActif;
  final VoidCallback? onActualiser;
  final VoidCallback? onRecharger;

  const DashboardAppBar({
    super.key,
    required this.companyName,
    required this.solde,
    this.isActif = true,
    this.onActualiser,
    this.onRecharger,
  });

  @override
  Size get preferredSize => Size.fromHeight(56.rh);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53.rh,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.white)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.rw),
      child: Row(
        children: [
          // Gauche : titre + breadcrumb
          Expanded(child: _buildLeft()),
          SizedBox(width: 12.rw),
          // Droite : badges + boutons
          _buildRight(context),
        ],
      ),
    );
  }

  Widget _buildLeft() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(
          'Accueil',
          fontSize: 19.rsp,
          fontFamily: FontFamily.syne,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
        SizedBox(width: 10.rw),
        AppText(
          "$companyName > Tableau de bord",
          fontSize: 11.5.rsp,
          fontWeight: FontWeight.w400,
          color: AppColors.primary,
        ),
      ],
    );
  }

  Widget _buildRight(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Badge Actif
        _BadgeActif(isActif: isActif),
        SizedBox(width: 8.rw),
        _BadgeSolde(solde: solde),
        SizedBox(width: 8.rw),
        AppButton(
          text: 'Actualiser',
          icon: Icons.refresh_rounded,
          type: AppButtonType.outline,
          onPressed: onActualiser,
          width: 97.rw,
          height: 29.rh,
          fontSize: 11.5.rsp,
        ),
        SizedBox(width: 8.rw),
        AppButton(
          text: 'Recharger',
          icon: Icons.add_circle_outline,
          type: AppButtonType.secondary,
          onPressed: onRecharger,
          width: 105.rw,
          height: 29.rh,
          fontSize: 12.5.rsp,
        ),
      ],
    );
  }
}

// --- Badge Actif ---
class _BadgeActif extends StatelessWidget {
  final bool isActif;
  const _BadgeActif({required this.isActif});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 61.rw,
      height: 22.rh,
      padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 5.rh),
      decoration: BoxDecoration(
        color: isActif ? AppColors.success.withValues(alpha: 0.1) : AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(11.5.rr),
        border: Border.all(
          color: isActif ? AppColors.success : AppColors.error,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.rw,
            height: 6.rh,
            decoration: BoxDecoration(
              color: isActif ? AppColors.success : AppColors.error,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 5.rw),
          AppText(
            isActif ? 'Actif' : 'Inactif',
            type: AppTextType.small,
            fontSize: 9.5.rsp,
            fontWeight: FontWeight.w500,
            color: isActif ? AppColors.success : AppColors.error,
          ),
        ],
      ),
    );
  }
}

// --- Badge Solde ---
class _BadgeSolde extends StatelessWidget {
  final String solde;
  const _BadgeSolde({required this.solde});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112.rw,
      height: 22.rh,
      padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 5.rh),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(11.5.rr),
        border: Border.all(color: AppColors.warning),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.rw,
            height: 6.rh,
            decoration: BoxDecoration(
              color: AppColors.warning,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 5.rw),
          AppText(
            solde,
            type: AppTextType.small,
            fontSize: 9.5.rsp,
            fontWeight: FontWeight.w500,
            color: AppColors.warning,
            fontFamily: 'monospace',
          ),
        ],
      ),
    );
  }
}
