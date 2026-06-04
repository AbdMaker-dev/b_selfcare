import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/src/data/models/campaign/campaign_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/campagne/cubit/campagne_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/detail_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCampagne extends StatelessWidget {
  final CampaignModel campaign;
  final CampagneCubit campagneCubit;

  const DetailCampagne({super.key, required this.campaign, required this.campagneCubit});

  static void show(BuildContext context, {required CampaignModel campaign, required CampagneCubit campagneCubit}) {
    showGeneralDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: AppColors.primary.withValues(alpha: 0.7),
      pageBuilder: (_, __, ___) => Align(
        alignment: Alignment.centerRight,
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: 650.rw,
            height: double.infinity,
            child: DetailCampagne(campaign: campaign, campagneCubit: campagneCubit),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CampagneCubit, CampagneState>(
      bloc: campagneCubit,
      listener: (context, state) {
        state.maybeWhen(
          executeCampaignsLoaded: (_) => Navigator.of(context, rootNavigator: true).pop(),
          orElse: () {},
        );
      },
      child: Container(
        height: double.infinity.rh,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.rr),
            bottomLeft: Radius.circular(12.rr),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border(bottom: BorderSide(color: AppColors.gray)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.textHighlight(
                          'Détail campagne',
                          fontSize: 20.rsp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grayAsh,
                          highlight: 'campagne',
                          fontFamily: FontFamily.syne,
                          highlightColor: AppColors.primary,
                          highlightFontSize: 20.rsp,
                        ),
                        SizedBox(height: 4.rh),
                        AppText(
                          '${campaign.name ?? '---'} · ${campaign.frequency ?? '---'} · ${campaign.status ?? '---'}',
                          fontSize: 10.rsp,
                          color: AppColors.textMuted,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context, rootNavigator: true).pop(),
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 6.rh),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.graySilver),
                      ),
                      child: AppText(
                        'X',
                        fontSize: 13.rsp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // SCROLLABLE BODY
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.rw),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HeaderCard(campaign: campaign),
                    SizedBox(height: 16.rh),
                    _SectionInfos(campaign: campaign),
                    SizedBox(height: 16.rh),
                    const DetailDivider(),
                    SizedBox(height: 16.rh),
                    _SectionPlanification(campaign: campaign),
                    if (campaign.product != null) ...[
                      SizedBox(height: 16.rh),
                      const DetailDivider(),
                      SizedBox(height: 16.rh),
                      DetailProductSection(product: campaign.product!),
                    ],
                    SizedBox(height: 16.rh),
                  ],
                ),
              ),
            ),

            // FOOTER
            _Actions(campaign: campaign, campagneCubit: campagneCubit),
          ],
        ),
      ),
    );
  }
}

// ─── Header card ─────────────────────────────────────────────────────────────

class _HeaderCard extends StatelessWidget {
  final CampaignModel campaign;
  const _HeaderCard({required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.rw),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.rr),
        border: Border.all(color: AppColors.gray),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailIconBox(icon: Icons.campaign_outlined),
          SizedBox(width: 14.rw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  campaign.name ?? '---',
                  fontSize: 16.rsp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
                if (campaign.description?.isNotEmpty == true) ...[
                  SizedBox(height: 4.rh),
                  AppText(campaign.description!, fontSize: 13.rsp, color: AppColors.textMuted),
                ],
              ],
            ),
          ),
          DetailStatusBadge.fromStatus(campaign.status),
        ],
      ),
    );
  }
}

// ─── Section infos générales ─────────────────────────────────────────────────

class _SectionInfos extends StatelessWidget {
  final CampaignModel campaign;
  const _SectionInfos({required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailSectionTitle(label: 'Informations générales', icon: Icons.info_outline),
        SizedBox(height: 14.rh),
        DetailInfoRow(
          left: DetailInfoItem(label: 'Nom de la campagne', value: campaign.name ?? '---', icon: Icons.label_outline),
          right: DetailInfoItem(
            label: 'Description',
            value: campaign.description?.isNotEmpty == true ? campaign.description! : 'Aucune description',
            icon: Icons.notes_outlined,
          ),
        ),
        SizedBox(height: 12.rh),
        DetailInfoRow(
          left: DetailInfoItem(label: 'Date de création', value: AppDate.format(campaign.createdAt), icon: Icons.calendar_today_outlined),
        ),
      ],
    );
  }
}

// ─── Section planification ───────────────────────────────────────────────────

class _SectionPlanification extends StatelessWidget {
  final CampaignModel campaign;
  const _SectionPlanification({required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailSectionTitle(label: 'Planification', icon: Icons.schedule_outlined),
        SizedBox(height: 14.rh),
        DetailInfoRow(
          left: DetailInfoItem(label: 'Fréquence', value: campaign.frequency ?? '---', icon: Icons.repeat_outlined),
          right: DetailInfoItem(label: 'Détail fréquence', value: _frequencyDetail(campaign), icon: Icons.today_outlined),
        ),
        SizedBox(height: 12.rh),
        DetailInfoRow(
          left: DetailInfoItem(label: 'Date de début', value: AppDate.format(campaign.startDate), icon: Icons.play_circle_outline),
          right: DetailInfoItem(label: 'Date de fin', value: AppDate.format(campaign.endDate), icon: Icons.stop_circle_outlined),
        ),
        SizedBox(height: 12.rh),
        DetailInfoRow(
          left: DetailInfoItem(label: 'Prochain run', value: AppDate.format(campaign.nextExecution), icon: Icons.update_outlined),
        ),
      ],
    );
  }

  String _frequencyDetail(CampaignModel c) {
    switch (c.frequency?.toUpperCase()) {
      case 'WEEKLY':
        const days = ['', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];
        final day = c.dayOfWeek != null && c.dayOfWeek! >= 1 && c.dayOfWeek! <= 7 ? days[c.dayOfWeek!] : '---';
        return 'Chaque $day';
      case 'MONTHLY':
        return c.dayOfMonth != null ? 'Le ${c.dayOfMonth} du mois' : '---';
      case 'DAILY':
        return 'Tous les jours';
      default:
        return '---';
    }
  }
}

// ─── Footer actions ───────────────────────────────────────────────────────────

class _Actions extends StatelessWidget {
  final CampaignModel campaign;
  final CampagneCubit campagneCubit;
  const _Actions({required this.campaign, required this.campagneCubit});

  void _execute(BuildContext context, String action) {
    if (campaign.id == null) return;
    Navigator.of(context, rootNavigator: true).pop();
    campagneCubit.executeCampaigns(id: campaign.id!, execute: action);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampagneCubit, CampagneState>(
      bloc: campagneCubit,
      builder: (context, state) {
        final isLoading = state is ExecuteCampaignsLoading;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(top: BorderSide(color: AppColors.gray)),
          ),
          child: Row(
            children: [
              Expanded(
                child: AppButton(
                  text: 'Fermer',
                  type: AppButtonType.outline,
                  fontSize: 14.rsp,
                  onPressed: isLoading
                      ? null
                      : () => Navigator.of(context, rootNavigator: true).pop(),
                ),
              ),
              SizedBox(width: 12.rw),
              Expanded(
                child: PopupMenuButton<String>(
                  enabled: !isLoading,
                  offset: const Offset(0, -220),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: AppColors.gray),
                  ),
                  color: AppColors.white,
                  onSelected: (action) => _execute(context, action),
                  itemBuilder: (_) => [
                    _menuItem('execute',   'Exécuter',     Icons.play_arrow_rounded,  AppColors.success),
                    _menuItem('pause',     'Pause',         Icons.pause_rounded,        AppColors.warning),
                    _menuItem('reactivate','Réactiver',    Icons.replay_rounded,       AppColors.greenDull),
                    _menuItem('retrigger', 'Redéclencher', Icons.restart_alt_rounded,  AppColors.primary),
                    _menuItem('cancel',    'Annuler',       Icons.cancel_outlined,      AppColors.error),
                  ],
                  child: Container(
                    height: 62.rh,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10.rr),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          'Actions',
                          fontSize: 14.rsp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                        SizedBox(width: 6.rw),
                        Icon(Icons.keyboard_arrow_up_rounded,
                            color: AppColors.white, size: 18.rsp),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  PopupMenuItem<String> _menuItem(String value, String label, IconData icon, Color color) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: color, size: 18.rsp),
           SizedBox(width: 10.rw),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
