import 'package:b_selfcare/src/data/models/products_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

// ─── Dialog helper ───────────────────────────────────────────────────────────

void showDetailDialog(
  BuildContext context, {
  double width = 680,
  required Widget child,
}) {
  showDialog<void>(
    context: context,
    useRootNavigator: true,
    barrierDismissible: true,
    barrierColor: AppColors.primary.withValues(alpha: 0.7),
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.rr),
      ),
      child: SizedBox(
        width: width.rw,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.rw),
          child: child,
        ),
      ),
    ),
  );
}

// ─── Conteneur principal ─────────────────────────────────────────────────────

class DetailContainer extends StatelessWidget {
  final List<Widget> children;

  const DetailContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.rw),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.rr),
        border: Border.all(color: AppColors.gray),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}

// ─── Séparateur ──────────────────────────────────────────────────────────────

class DetailDivider extends StatelessWidget {
  const DetailDivider({super.key});

  @override
  Widget build(BuildContext context) => Divider(color: AppColors.gray, height: 1);
}

// ─── Titre de section ─────────────────────────────────────────────────────────

class DetailSectionTitle extends StatelessWidget {
  final String label;
  final IconData icon;

  const DetailSectionTitle({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15.rsp, color: AppColors.primary),
        SizedBox(width: 6.rw),
        AppText(
          label.toUpperCase(),
          fontSize: 11.rsp,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ],
    );
  }
}

// ─── Carte info ──────────────────────────────────────────────────────────────

class DetailInfoItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const DetailInfoItem({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 12.rh),
      decoration: BoxDecoration(
        color: AppColors.grayWh,
        borderRadius: BorderRadius.circular(8.rr),
        border: Border.all(color: AppColors.gray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 12.rsp, color: AppColors.grayAsh),
              SizedBox(width: 5.rw),
              AppText(
                label.toUpperCase(),
                fontSize: 10.rsp,
                fontWeight: FontWeight.w600,
                color: AppColors.grayAsh,
              ),
            ],
          ),
          SizedBox(height: 6.rh),
          AppText(
            value,
            fontSize: 13.rsp,
            fontWeight: FontWeight.w600,
            color: AppColors.textHeading,
          ),
        ],
      ),
    );
  }
}

// ─── Ligne de 2 cartes info ───────────────────────────────────────────────────

class DetailInfoRow extends StatelessWidget {
  final Widget left;
  final Widget? right;

  const DetailInfoRow({super.key, required this.left, this.right});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        SizedBox(width: 16.rw),
        Expanded(child: right ?? const SizedBox()),
      ],
    );
  }
}

// ─── Icône en en-tête ─────────────────────────────────────────────────────────

class DetailIconBox extends StatelessWidget {
  final IconData icon;

  const DetailIconBox({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.rw),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.rr),
      ),
      child: Icon(icon, color: AppColors.primary, size: 26.rsp),
    );
  }
}

// ─── Badge de statut ─────────────────────────────────────────────────────────

class DetailStatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const DetailStatusBadge({super.key, required this.label, required this.color});

  factory DetailStatusBadge.fromStatus(String? status) {
    final (label, color) = switch (status?.toUpperCase()) {
      'ACTIVE'    => ('ACTIF',    AppColors.success),
      'INACTIVE'  => ('INACTIF',  AppColors.error),
      'PAUSED'    => ('PAUSED',   AppColors.warning),
      'CANCELLED' => ('ANNULÉ',  AppColors.error),
      'COMPLETED' => ('COMPLÉTÉ',AppColors.greenDull),
      'BLOCKED'   => ('BLOQUÉ',  AppColors.error),
      _           => ('INACTIF',  AppColors.grayAsh),
    };
    return DetailStatusBadge(label: label, color: color);
  }

  factory DetailStatusBadge.active()   => const DetailStatusBadge(label: 'ACTIF',   color: AppColors.success);
  factory DetailStatusBadge.inactive() => const DetailStatusBadge(label: 'INACTIF', color: AppColors.error);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 6.rh),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.rr),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.rw,
            height: 6.rh,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 5.rw),
          AppText(label, fontSize: 11.rsp, fontWeight: FontWeight.w700, color: color),
        ],
      ),
    );
  }
}

// ─── Bouton d'action ─────────────────────────────────────────────────────────

class DetailActionBtn extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? color;
  final AppButtonType type;
  final VoidCallback? onPressed;
  final double width;

  const DetailActionBtn({
    super.key,
    required this.label,
    this.icon,
    this.color,
    this.type = AppButtonType.primary,
    this.onPressed,
    this.width = 140,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.rw,
      height: 44.rh,
      child: AppButton(
        text: label,
        icon: icon,
        type: type,
        color: color,
        textColor: type == AppButtonType.outline
            ? (color ?? AppColors.textHeading)
            : AppColors.white,
        fontSize: 13.rsp,
        onPressed: onPressed,
      ),
    );
  }
}

// ─── Section produit + quotas ─────────────────────────────────────────────────

class DetailProductSection extends StatelessWidget {
  final ProductsModel product;

  const DetailProductSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final quotas = product.quotas;
    final totalPrice = quotas != null && quotas.isNotEmpty
        ? quotas.fold<num>(0, (s, q) => s + (q.price ?? 0))
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailSectionTitle(label: 'Produit associé', icon: Icons.inventory_2_outlined),
        SizedBox(height: 14.rh),
        DetailInfoRow(
          left: DetailInfoItem(
            label: 'Nom du produit',
            value: product.name ?? '---',
            icon: Icons.label_outline,
          ),
          right: DetailInfoItem(
            label: 'Prix total',
            value: totalPrice != null ? AppMoney.format(totalPrice) : '---',
            icon: Icons.monetization_on_outlined,
          ),
        ),
        if (product.description?.isNotEmpty == true) ...[
          SizedBox(height: 12.rh),
          DetailInfoItem(
            label: 'Description du produit',
            value: product.description!,
            icon: Icons.notes_outlined,
          ),
        ],
        if (product.isActive != null) ...[
          SizedBox(height: 12.rh),
          _ProductStatusRow(isActive: product.isActive!),
        ],
        if (quotas != null && quotas.isNotEmpty) ...[
          SizedBox(height: 16.rh),
          DetailSectionTitle(label: 'Quotas', icon: Icons.bar_chart_outlined),
          SizedBox(height: 10.rh),
          ...quotas.map((q) => DetailQuotaRow(quota: q)),
        ],
      ],
    );
  }
}

class _ProductStatusRow extends StatelessWidget {
  final bool isActive;
  const _ProductStatusRow({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText('Statut produit : ', fontSize: 12.rsp, color: AppColors.textMuted),
        SizedBox(width: 6.rw),
        DetailStatusBadge(
          label: isActive ? 'ACTIF' : 'INACTIF',
          color: isActive ? AppColors.success : AppColors.error,
        ),
      ],
    );
  }
}

// ─── Ligne de quota ───────────────────────────────────────────────────────────

class DetailQuotaRow extends StatelessWidget {
  final Quotas quota;

  const DetailQuotaRow({super.key, required this.quota});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.rh),
      padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 10.rh),
      decoration: BoxDecoration(
        color: AppColors.grayWh,
        borderRadius: BorderRadius.circular(8.rr),
        border: Border.all(color: AppColors.gray),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: AppText(
              quota.name ?? quota.code ?? '---',
              fontSize: 13.rsp,
              fontWeight: FontWeight.w600,
              color: AppColors.textHeading,
            ),
          ),
          if (quota.category != null)
            Expanded(
              flex: 2,
              child: AppText(
                quota.category!,
                fontSize: 12.rsp,
                color: AppColors.textMuted,
              ),
            ),
          Expanded(
            flex: 2,
            child: AppText(
              quota.quota != null ? '${quota.quota} ${quota.unit ?? ''}' : '---',
              fontSize: 13.rsp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
