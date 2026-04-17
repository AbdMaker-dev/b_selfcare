import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/activite_recente_card.dart';
import 'package:b_selfcare/src/views/widgets/alertes_seuils_card.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/balance_card.dart';
import 'package:b_selfcare/src/views/widgets/dernieres_recharges_card.dart';
import 'package:b_selfcare/src/views/widgets/etat_services_card.dart';
import 'package:b_selfcare/src/views/widgets/flotte_card.dart';
import 'package:b_selfcare/src/views/widgets/mes_compagnes_card.dart';
import 'package:b_selfcare/src/views/widgets/provisioning_chart_card.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 50.rh),
      children: [
        AppText.textHighlight(
          "Bonjour, Alioune",
          highlight: "Alioune",
          fontSize: 22.rsp,
          fontFamily: FontFamily.syne,
        ),
        SizedBox(height: 8.rh),
        AppText(
          "CORTECH GROUP · C-0012 · PLAN PREMIUM · PRÉPAYÉ · Mise à jour 01/04 · 00h18",
          fontSize: 11.rsp,
          color: AppColors.textMuted,
        ),
        SizedBox(height: 30.rh),

        // Cartes de solde
        Row(
          spacing: 12.rw,
          children: [
            BalanceCard(
              title: 'SOLDE DISPONIBLE',
              amount: 2.85,
              unit: 'M FCFA',
              status: 'Sain',
              rechargeDate: '01/04',
              chartColor: AppColors.success,
              chartData: [0.05, 0.1, 0.18, 0.3, 0.5, 0.72, 0.88, 1.0],
            ),
            BalanceCard(
              title: "NUMEROS ACTIFS",
              amount: 1240,
              unit: 'MSISDN',
              status: '100% Actifs',
              rechargeDate: 'ce mois',
              chartColor: AppColors.primary,
              chartData: [0.05, 0.1, 0.18, 0.3, 0.5, 0.72, 0.88, 1.0],
            ),
            BalanceCard(
              title: 'DEPENSES CE MOIS',
              amount: 4.34,
              unit: 'M FCFA',
              status: 'Dands le budget',
              rechargeDate: 'estimé',
              chartColor: Colors.orange,
              chartData: [0.05, 0.1, 0.18, 0.3, 0.5, 0.72, 0.88, 1.0],
            ),
            BalanceCard(
              title: 'CAPAGNES ACTIVES',
              amount: 3,
              unit: 'Camp',
              status: '3 planifiées .',
              rechargeDate: '0 erreur',
              chartColor: Colors.blue,
              chartData: [0.05, 0.1, 0.18, 0.3, 0.5, 0.72, 0.88, 1.0],
            ),
          ],
        ),
        SizedBox(height: 20.rh),

        // Section activités récentes
        Row(
          spacing: 12.rw,
          children: [
            const ProvisioningChartCard(),
            ActiviteRecenteCard(
              items: const [
                ActivityItem(
                  type: ActivityType.provisioning,
                  title: 'Provisioning terminé',
                  meta: '1 240 numéros · 100% SUCCESS · 4m 12s',
                  date: '01/04 · 00h18',
                ),
                ActivityItem(
                  type: ActivityType.recharge,
                  title: 'Recharge Wave confirmée',
                  meta: '+500 000 FCFA · Solde: 2 850 000 FCFA',
                  date: '01/04 · 14h32',
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20.rh),

        Row(
          spacing: 12.rw,
          children: [
            const FlotteCard(),
            MesCampagnesCard(
              campagnes: const [
                CampagneItem(
                  name: 'Forfait Standard DAILY',
                  meta: 'DAILY · 1240 numéros',
                ),
                CampagneItem(
                  name: 'Direction WEEKLY',
                  meta: 'MONTHLY · 1195 numéros',
                ),
                CampagneItem(
                  name: 'Batch mensuel',
                  meta: 'MONTHLY · 1195 numéros',
                ),
              ],
            ),
            DernieresRechargesCard(
              recharges: const [
                RechargeItem(
                  provider: RechargeProvider.mixx,
                  date: '01/04 · 14h32',
                  montant: 500000,
                ),
                RechargeItem(
                  provider: RechargeProvider.wave,
                  date: '15/03 · 11h15',
                  montant: 1000000,
                ),
                RechargeItem(
                  provider: RechargeProvider.orangeMoney,
                  date: '01/03 · 09h44',
                  montant: 300000,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20.rh),

        Row(
          spacing: 12.rw,
          children: [
            const AlertesSeuilsCard(
              items: [
                AlerteItem(
                  title: "Seuil d'alerte solde",
                  meta: 'Notification SMS + email',
                  value: '500 000 Fcfa',
                  variant: AlerteVariant.green,
                ),
                AlerteItem(
                  title: 'Prochain provisioning',
                  meta: 'Job CBS quotidien',
                  value: '03/04 · 00h00',
                  variant: AlerteVariant.blue,
                ),
                AlerteItem(
                  title: 'Coût estimé prochain run',
                  meta: 'Forfait Standard · 1 240 numéros',
                  value: '2 170 000 Fcfa',
                  variant: AlerteVariant.yellow,
                ),
              ],
            ),

            const EtatServicesCard(
              services: [
                ServiceItem(
                  icon: '⚡',
                  name: 'Provisioning CBS',
                  meta: 'Dernier : 01/04 00h18',
                ),
                ServiceItem(
                  icon: '📱',
                  name: 'Mixx by Yas/Wave',
                  meta: 'API callbacks OK',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
