import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/routers/app_router.dart';
import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:b_selfcare/src/utils/dashboard_mapper.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:b_selfcare/src/views/pages/layout/cubit/layout_cubit.dart';
import 'package:b_selfcare/src/views/widgets/activite_recente_card.dart';
import 'package:b_selfcare/src/views/widgets/alertes_seuils_card.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/balance_card.dart';
import 'package:b_selfcare/src/views/widgets/dernieres_recharges_card.dart';
import 'package:b_selfcare/src/views/widgets/flotte_card.dart';
import 'package:b_selfcare/src/views/widgets/mes_compagnes_card.dart';
import 'package:b_selfcare/src/views/widgets/provisioning_chart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}
class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardCubit _cubit = getIt<DashboardCubit>();

  @override
  void initState() {
    _cubit.fetchCompanyStats();
    super.initState();
  }

  ({double amount, String unit}) _scale(double value) {
    if (value >= 1000000) return (amount: value / 1000000, unit: 'M FCFA');
    return                       (amount: value,            unit: 'FCFA');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      bloc: _cubit,
      builder: (context, state) {
        final stats = _cubit.companyStats;

        return ListView(
          padding: EdgeInsets.only(bottom: 50.rh),
          children: [
            AppText.textHighlight(
              "Bonjour, ${getIt<LayoutCubit>().currentUser?.firstName ?? ''}",
              highlight: getIt<LayoutCubit>().currentUser?.firstName ?? '',
              fontSize: 24.rsp,
              fontFamily: FontFamily.montserrat,
              // fontStyle: FontStyle.italic,
              highlightColor: AppColors.warning,
              fontWeight: FontWeight.w400,
              highlightFontSize: 24.rsp,
            ),
            SizedBox(height: 8.rh),
            AppText(
              _cubit.companySubtitle,
              fontSize: 16.rsp,
              color: AppColors.inputBorderLight,
            ),
            SizedBox(height: 30.rh),

            // ── Cartes de résumé ─────────────────────────────────────────────
            Row(
              spacing: 12.rw,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BalanceCard(
                  title: 'SOLDE DISPONIBLE',
                  amount: _scale(stats?.balanceCard.currentBalance ?? 0).amount,
                  unit:   _scale(stats?.balanceCard.currentBalance ?? 0).unit,
                  rawAmount: stats?.balanceCard.currentBalance,
                  status: DashboardMapper.balanceStatus(stats?.balanceCard.status),
                  rechargeDate: AppDate.dashboardFmt(stats?.balanceCard.lastRechargeDate),
                  chartColor: AppColors.success,
                  chartData: const [0.05, 0.1, 0.18, 0.3, 0.5, 0.72, 0.88, 1.0],
                ),
                BalanceCard(
                  title: 'NUMÉROS ACTIFS',
                  amount: stats?.activeNumbersCard.total.toDouble() ?? 0,
                  unit: 'MSISDN',
                  status: stats != null ? '${stats.activeNumbersCard.activePercentage}% Actifs' : '',
                  rechargeDate: 'ce mois',
                  chartColor: AppColors.primary,
                  chartData: const [0.05, 0.1, 0.18, 0.3, 0.5, 0.72, 0.88, 1.0],
                ),
                BalanceCard(
                  title: 'DÉPENSES CE MOIS',
                  amount: _scale(stats?.monthlySpendCard.estimatedBudget ?? 0).amount,
                  unit:   _scale(stats?.monthlySpendCard.estimatedBudget ?? 0).unit,
                  rawAmount: stats?.monthlySpendCard.estimatedBudget,
                  status: stats != null ? (stats.monthlySpendCard.withinBudget ? 'Dans le budget' : 'Hors budget') : '',
                  rechargeDate: 'estimé',
                  chartColor: Colors.orange,
                  chartData: const [0.05, 0.1, 0.18, 0.3, 0.5, 0.72, 0.88, 1.0],
                ),
                BalanceCard(
                  title: 'CAMPAGNES ACTIVES',
                  amount: stats?.activeCampaignsCard.totalActive.toDouble() ?? 0,
                  unit: 'Camp',
                  status: stats != null ? '${stats.activeCampaignsCard.plannedCount} planifiées' : '',
                  rechargeDate: stats != null ? '${stats.activeCampaignsCard.errorCount} erreur' : '',
                  chartColor: Colors.blue,
                  chartData: const [0.05, 0.1, 0.18, 0.3, 0.5, 0.72, 0.88, 1.0],
                ),
              ],
            ),
            SizedBox(height: 20.rh),

            // ── Provisioning chart + Activité récente ────────────────────────
            Row(
              spacing: 12.rw,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProvisioningChartCard(),
                ActiviteRecenteCard(items: stats != null ? DashboardMapper.activityItems(stats.recentActivity) : []),
              ],
            ),
            SizedBox(height: 20.rh),

            // ── Flotte + Campagnes + Recharges ───────────────────────────────
            Row(
              spacing: 12.rw,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlotteCard(
                  total: (stats?.fleetSummary.active ?? 0) + (stats?.fleetSummary.suspended ?? 0),
                  actifs: stats?.fleetSummary.active ?? 0,
                  suspendus: stats?.fleetSummary.suspended ?? 0,
                  groupes: stats?.fleetSummary.groupsCount ?? 0,
                  employes: stats?.fleetSummary.employeesCount ?? 0,
                  simStock: stats?.fleetSummary.simStockCount ?? 0,
                ),
                MesCampagnesCard(
                  campagnes: stats != null ? DashboardMapper.campaignItems(stats.recentCampaigns) : [],
                  onVoirTout: () => context.router.pushPath('$routeApp/$routeAppMyCampagnes'),
                ),
                DernieresRechargesCard(
                  recharges: stats != null ? DashboardMapper.rechargeItems(stats.recentRecharges) : [],
                ),
              ],
            ),
            SizedBox(height: 20.rh),

            // ── Alertes + État des services ──────────────────────────────────
            Row(
              spacing: 12.rw,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AlertesSeuilsCard(
                    items: stats != null ? DashboardMapper.alertItems(stats.alerts) : [],
                  ),
                ),
              /*  EtatServicesCard(
                  services: stats != null ? DashboardMapper.serviceItems(stats.serviceStatus) : [],
                ),*/
              ],
            ),
          ],
        );
      },
    );
  }
}
