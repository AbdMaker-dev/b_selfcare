import 'package:b_selfcare/src/data/models/dashboard/company_stats_model.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:b_selfcare/src/views/widgets/activite_recente_card.dart';
import 'package:b_selfcare/src/views/widgets/alertes_seuils_card.dart';
import 'package:b_selfcare/src/views/widgets/dernieres_recharges_card.dart';
import 'package:b_selfcare/src/views/widgets/etat_services_card.dart';
import 'package:b_selfcare/src/views/widgets/mes_compagnes_card.dart';

class DashboardMapper {
  DashboardMapper._();

  // ── Balance ────────────────────────────────────────────────────────────────

  static String balanceStatus(String? s) => switch (s) {
    'healthy'  => 'Sain',
    'low'      => 'Faible',
    'critical' => 'Critique',
    _          => s ?? '',
  };

  // ── Activité récente ───────────────────────────────────────────────────────

  static List<ActivityItem> activityItems(List<RecentActivityStats> list) {
    return list.map((a) => ActivityItem(
      type: _activityType(a.action),
      title: a.label ?? '',
      meta: a.description ?? '',
      date: AppDate.dashboardFmt(a.createdAt),
    )).toList();
  }

  static ActivityType _activityType(String? action) => switch (action?.toUpperCase()) {
    'JOB_STARTED' || 'JOB_COMPLETED'          => ActivityType.provisioning,
    'RECHARGE_CONFIRMED' || 'RECHARGE_PENDING' => ActivityType.recharge,
    'INVOICE_DOWNLOADED'                       => ActivityType.facture,
    'LOGIN' || 'CREATE' || 'UPDATE'            => ActivityType.utilisateur,
    _                                          => ActivityType.campagne,
  };

  // ── Campagnes ──────────────────────────────────────────────────────────────

  static List<CampagneItem> campaignItems(List<RecentCampaignStats> list) {
    return list.map((c) => CampagneItem(
      name: c.name ?? '',
      meta: '${c.frequency ?? ''} · ${c.targetCount} numéros',
      status: _campagneStatus(c.lastExecutionStatus),
    )).toList();
  }

  static CampagneStatus _campagneStatus(String? s) => switch (s?.toUpperCase()) {
    'SUCCESS'               => CampagneStatus.succes,
    'ERROR' || 'FAILED'    => CampagneStatus.erreur,
    'RUNNING' || 'STARTED' => CampagneStatus.enCours,
    _                      => CampagneStatus.planifie,
  };

  // ── Recharges ──────────────────────────────────────────────────────────────

  static List<RechargeItem> rechargeItems(List<RecentRechargeStats> list) {
    return list.map((r) => RechargeItem(
      provider: _rechargeProvider(r.operator),
      date: AppDate.dashboardFmt(r.confirmedAt),
      montant: r.amount.toInt(),
      status: _rechargeStatus(r.status),
    )).toList();
  }

  static RechargeProvider _rechargeProvider(String? op) => switch (op?.toUpperCase()) {
    'WAVE'         => RechargeProvider.wave,
    'ORANGE_MONEY' => RechargeProvider.orangeMoney,
    _              => RechargeProvider.mixx,
  };

  static RechargeStatus _rechargeStatus(String? s) => switch (s?.toUpperCase()) {
    'CONFIRMED' => RechargeStatus.confirme,
    'PENDING'   => RechargeStatus.enAttente,
    _           => RechargeStatus.echoue,
  };

  // ── Alertes ────────────────────────────────────────────────────────────────

  static List<AlerteItem> alertItems(AlertsStats a) => [
    AlerteItem(
      title: "Seuil d'alerte solde",
      meta: 'Notification SMS + email',
      value: AppMoney.format(a.balanceAlertThreshold, suffix: 'Fcfa'),
      variant: AlerteVariant.green,
    ),
    AlerteItem(
      title: 'Prochain provisioning',
      meta: 'Job CBS quotidien',
      value: '${AppDate.dayMonth(a.nextProvisioningDate)} · ${a.nextProvisioningTime ?? ''}',
      variant: AlerteVariant.blue,
    ),
    AlerteItem(
      title: 'Coût estimé prochain run',
      meta: '${a.nextRunCampaignName ?? ''} · ${a.nextRunNumbers} numéros',
      value: AppMoney.format(a.estimatedNextRunCost, suffix: 'Fcfa'),
      variant: AlerteVariant.yellow,
    ),
  ];

  // ── État des services ──────────────────────────────────────────────────────

  static List<ServiceItem> serviceItems(ServiceStatusStats s) => [
    _serviceItem('provisioning_cbs', s.provisioningCbs),
    _serviceItem('mobile_money', s.mobileMoney),
    _serviceItem('waf', s.waf),
    _serviceItem('sms_gateway', s.smsGateway),
  ];

  static ServiceItem _serviceItem(String key, ServiceEntry entry) {
    final hasMeta = entry.lastAt != null;
    return ServiceItem(
      icon: _serviceIcon(key),
      name: _serviceName(key),
      meta: hasMeta ? 'Dernier : ${AppDate.dashboardFmt(entry.lastAt)}' : 'Opérationnel',
      status: _serviceStatus(entry.status),
    );
  }

  static ServiceStatus _serviceStatus(String? s) => switch (s?.toLowerCase()) {
    'ok'      => ServiceStatus.ok,
    'warning' => ServiceStatus.warning,
    _         => ServiceStatus.error,
  };

  static String _serviceIcon(String key) => switch (key) {
    'provisioning_cbs' => '⚡',
    'mobile_money'     => '📱',
    'waf'              => '🛡️',
    'sms_gateway'      => '💬',
    _                  => '•',
  };

  static String _serviceName(String key) => switch (key) {
    'provisioning_cbs' => 'Provisioning CBS',
    'mobile_money'     => 'Mixx by Yas / Wave',
    'waf'              => 'Sécurité WAF',
    'sms_gateway'      => 'Gateway SMS',
    _                  => key,
  };
}
