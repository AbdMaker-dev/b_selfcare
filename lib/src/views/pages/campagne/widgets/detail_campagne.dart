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
    showDetailDialog(
      context,
      width: 700.rw,
      child: DetailCampagne(campaign: campaign, campagneCubit: campagneCubit),
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
      child: DetailContainer(children: [
        _Header(campaign: campaign),
        SizedBox(height: 20.rh),
        const DetailDivider(),
        SizedBox(height: 20.rh),
        _SectionInfos(campaign: campaign),
        SizedBox(height: 20.rh),
        const DetailDivider(),
        SizedBox(height: 20.rh),
        _SectionPlanification(campaign: campaign),
        if (campaign.product != null) ...[
          SizedBox(height: 20.rh),
          const DetailDivider(),
          SizedBox(height: 20.rh),
          DetailProductSection(product: campaign.product!),
        ],
        SizedBox(height: 24.rh),
        const DetailDivider(),
        SizedBox(height: 20.rh),
        _Actions(campaign: campaign, campagneCubit: campagneCubit),
      ]),
    );
  }
}

class _Header extends StatelessWidget {
  final CampaignModel campaign;
  const _Header({required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailIconBox(icon: Icons.campaign_outlined),
        SizedBox(width: 14.rw),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(campaign.name ?? '---', fontSize: 18.rsp, fontWeight: FontWeight.w700, color: AppColors.primary),
              if (campaign.description?.isNotEmpty == true) ...[
                SizedBox(height: 4.rh),
                AppText(campaign.description!, fontSize: 13.rsp, color: AppColors.textMuted),
              ],
            ],
          ),
        ),
        DetailStatusBadge.fromStatus(campaign.status),
      ],
    );
  }
}

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
        return Wrap(
          spacing: 10.rw,
          runSpacing: 10.rh,
          alignment: WrapAlignment.end,
          children: [
            DetailActionBtn(
              label: 'Fermer', icon: Icons.close, type: AppButtonType.outline, width: 130,
              onPressed: isLoading ? null : () => Navigator.of(context, rootNavigator: true).pop(),
            ),
            DetailActionBtn(
              label: 'Exécuter', icon: Icons.play_arrow_rounded, color: AppColors.success,
              onPressed: isLoading ? null : () => _execute(context, 'execute'),
            ),
            DetailActionBtn(
              label: 'Pause', icon: Icons.pause_rounded, color: AppColors.warning,
              onPressed: isLoading ? null : () => _execute(context, 'pause'),
            ),
            DetailActionBtn(
              label: 'Réactiver', icon: Icons.replay_rounded, color: AppColors.greenDull,
              onPressed: isLoading ? null : () => _execute(context, 'reactivate'),
            ),
            DetailActionBtn(
              label: 'Redéclencher', icon: Icons.restart_alt_rounded, color: AppColors.primary, width: 155,
              onPressed: isLoading ? null : () => _execute(context, 'retrigger'),
            ),
            DetailActionBtn(
              label: 'Annuler', icon: Icons.cancel_outlined, color: AppColors.error,
              onPressed: isLoading ? null : () => _execute(context, 'cancel'),
            ),
          ],
        );
      },
    );
  }
}
