class CompanyStatsModel {
  final CompanyInfo company;
  final BalanceCardStats balanceCard;
  final ActiveNumbersCardStats activeNumbersCard;
  final MonthlySpendCardStats monthlySpendCard;
  final ActiveCampaignsCardStats activeCampaignsCard;
  final FleetSummaryStats fleetSummary;
  final List<RecentCampaignStats> recentCampaigns;
  final List<RecentRechargeStats> recentRecharges;
  final List<RecentActivityStats> recentActivity;
  final AlertsStats alerts;
  final ServiceStatusStats serviceStatus;
  final ProvisioningChartStats? provisioningChart;

  CompanyStatsModel({
    required this.company,
    required this.balanceCard,
    required this.activeNumbersCard,
    required this.monthlySpendCard,
    required this.activeCampaignsCard,
    required this.fleetSummary,
    required this.recentCampaigns,
    required this.recentRecharges,
    required this.recentActivity,
    required this.alerts,
    required this.serviceStatus,
    this.provisioningChart,
  });

  factory CompanyStatsModel.fromJson(Map<String, dynamic> json) {
    return CompanyStatsModel(
      company: CompanyInfo.fromJson(json['company']),
      balanceCard: BalanceCardStats.fromJson(json['balance_card']),
      activeNumbersCard: ActiveNumbersCardStats.fromJson(json['active_numbers_card']),
      monthlySpendCard: MonthlySpendCardStats.fromJson(json['monthly_spend_card']),
      activeCampaignsCard: ActiveCampaignsCardStats.fromJson(json['active_campaigns_card']),
      fleetSummary: FleetSummaryStats.fromJson(json['fleet_summary']),
      recentCampaigns: (json['recent_campaigns'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(RecentCampaignStats.fromJson)
          .toList(),
      recentRecharges: (json['recent_recharges'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(RecentRechargeStats.fromJson)
          .toList(),
      recentActivity: (json['recent_activity'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(RecentActivityStats.fromJson)
          .toList(),
      alerts: AlertsStats.fromJson(json['alerts']),
      serviceStatus: ServiceStatusStats.fromJson(json['service_status']),
      provisioningChart: json['provisioning_chart'] != null
          ? ProvisioningChartStats.fromJson(json['provisioning_chart'])
          : null,
    );
  }
}

class CompanyInfo {
  final int id;
  final String name;
  final String cbsAccountId;
  final String cbsNbAccount;
  final String status;
  final double currentBalance;
  final String planName;
  final String updatedAt;

  CompanyInfo({
    required this.id,
    required this.name,
    required this.cbsAccountId,
    required this.cbsNbAccount,
    required this.status,
    required this.currentBalance,
    required this.planName,
    required this.updatedAt,
  });

  factory CompanyInfo.fromJson(Map<String, dynamic> json) {
    return CompanyInfo(
      id: json['id'],
      name: json['name'],
      cbsAccountId: json['cbs_account_id'],
      cbsNbAccount: json['cbs_nb_account'],
      status: json['status'],
      currentBalance: (json['current_balance'] as num).toDouble(),
      planName: json['plan_name'],
      updatedAt: json['updated_at'],
    );
  }
}

class BalanceCardStats {
  final double currentBalance;
  final String status;
  final String lastRechargeDate;
  final String lastRechargeOperator;

  BalanceCardStats({
    required this.currentBalance,
    required this.status,
    required this.lastRechargeDate,
    required this.lastRechargeOperator,
  });

  factory BalanceCardStats.fromJson(Map<String, dynamic> json) {
    return BalanceCardStats(
      currentBalance: (json['current_balance'] as num).toDouble(),
      status: json['status'],
      lastRechargeDate: json['last_recharge_date'],
      lastRechargeOperator: json['last_recharge_operator'],
    );
  }
}

class ActiveNumbersCardStats {
  final int total;
  final int active;
  final int suspended;
  final double activePercentage;

  ActiveNumbersCardStats({
    required this.total,
    required this.active,
    required this.suspended,
    required this.activePercentage,
  });

  factory ActiveNumbersCardStats.fromJson(Map<String, dynamic> json) {
    return ActiveNumbersCardStats(
      total: json['total'],
      active: json['active'],
      suspended: json['suspended'],
      activePercentage: (json['active_percentage'] as num).toDouble(),
    );
  }
}

class MonthlySpendCardStats {
  final double amount;
  final double estimatedBudget;
  final bool withinBudget;

  MonthlySpendCardStats({
    required this.amount,
    required this.estimatedBudget,
    required this.withinBudget,
  });

  factory MonthlySpendCardStats.fromJson(Map<String, dynamic> json) {
    return MonthlySpendCardStats(
      amount: (json['amount'] as num).toDouble(),
      estimatedBudget: (json['estimated_budget'] as num).toDouble(),
      withinBudget: json['within_budget'],
    );
  }
}

class ActiveCampaignsCardStats {
  final int totalActive;
  final int plannedCount;
  final int errorCount;

  ActiveCampaignsCardStats({
    required this.totalActive,
    required this.plannedCount,
    required this.errorCount,
  });

  factory ActiveCampaignsCardStats.fromJson(Map<String, dynamic> json) {
    return ActiveCampaignsCardStats(
      totalActive: json['total_active'],
      plannedCount: json['planned_count'],
      errorCount: json['error_count'],
    );
  }
}

class FleetSummaryStats {
  final int active;
  final int suspended;
  final double activePercentage;
  final int groupsCount;
  final int employeesCount;
  final int simStockCount;

  FleetSummaryStats({
    required this.active,
    required this.suspended,
    required this.activePercentage,
    required this.groupsCount,
    required this.employeesCount,
    required this.simStockCount,
  });

  factory FleetSummaryStats.fromJson(Map<String, dynamic> json) {
    return FleetSummaryStats(
      active: json['active'],
      suspended: json['suspended'],
      activePercentage: (json['active_percentage'] as num).toDouble(),
      groupsCount: json['groups_count'],
      employeesCount: json['employees_count'],
      simStockCount: json['sim_stock_count'],
    );
  }
}

class RecentCampaignStats {
  final int id;
  final String name;
  final String frequency;
  final String lastExecutionStatus;
  final int targetCount;

  RecentCampaignStats({
    required this.id,
    required this.name,
    required this.frequency,
    required this.lastExecutionStatus,
    required this.targetCount,
  });

  factory RecentCampaignStats.fromJson(Map<String, dynamic> json) {
    return RecentCampaignStats(
      id: json['id'],
      name: json['name'],
      frequency: json['frequency'],
      lastExecutionStatus: json['last_execution_status'],
      targetCount: json['target_count'],
    );
  }
}

class RecentRechargeStats {
  final int id;
  final String operator;
  final double amount;
  final String status;
  final String confirmedAt;
  final String createdAt;

  RecentRechargeStats({
    required this.id,
    required this.operator,
    required this.amount,
    required this.status,
    required this.confirmedAt,
    required this.createdAt,
  });

  factory RecentRechargeStats.fromJson(Map<String, dynamic> json) {
    return RecentRechargeStats(
      id: json['id'],
      operator: json['operator'],
      amount: (json['amount'] as num).toDouble(),
      status: json['status'],
      confirmedAt: json['confirmed_at'],
      createdAt: json['created_at'],
    );
  }
}

class RecentActivityStats {
  final String action;
  final String label;
  final String description;
  final String createdAt;

  RecentActivityStats({
    required this.action,
    required this.label,
    required this.description,
    required this.createdAt,
  });

  factory RecentActivityStats.fromJson(Map<String, dynamic> json) {
    return RecentActivityStats(
      action: json['action'],
      label: json['label'],
      description: json['description'],
      createdAt: json['created_at'],
    );
  }
}

class AlertsStats {
  final double balanceAlertThreshold;
  final String nextProvisioningDate;
  final String nextProvisioningTime;
  final double estimatedNextRunCost;
  final String nextRunCampaignName;
  final int nextRunNumbers;

  AlertsStats({
    required this.balanceAlertThreshold,
    required this.nextProvisioningDate,
    required this.nextProvisioningTime,
    required this.estimatedNextRunCost,
    required this.nextRunCampaignName,
    required this.nextRunNumbers,
  });

  factory AlertsStats.fromJson(Map<String, dynamic> json) {
    return AlertsStats(
      balanceAlertThreshold: (json['balance_alert_threshold'] as num).toDouble(),
      nextProvisioningDate: json['next_provisioning_date'],
      nextProvisioningTime: json['next_provisioning_time'],
      estimatedNextRunCost: (json['estimated_next_run_cost'] as num).toDouble(),
      nextRunCampaignName: json['next_run_campaign_name'],
      nextRunNumbers: json['next_run_numbers'],
    );
  }
}

class ServiceStatusStats {
  final ServiceEntry provisioningCbs;
  final ServiceEntry mobileMoney;
  final ServiceEntry waf;
  final ServiceEntry smsGateway;

  ServiceStatusStats({
    required this.provisioningCbs,
    required this.mobileMoney,
    required this.waf,
    required this.smsGateway,
  });

  factory ServiceStatusStats.fromJson(Map<String, dynamic> json) {
    return ServiceStatusStats(
      provisioningCbs: ServiceEntry.fromJson(json['provisioning_cbs']),
      mobileMoney: ServiceEntry.fromJson(json['mobile_money']),
      waf: ServiceEntry.fromJson(json['waf']),
      smsGateway: ServiceEntry.fromJson(json['sms_gateway']),
    );
  }
}

class ServiceEntry {
  final String status;
  final String? lastAt;

  ServiceEntry({required this.status, this.lastAt});

  factory ServiceEntry.fromJson(Map<String, dynamic> json) {
    return ServiceEntry(
      status: json['status'],
      lastAt: json['last_at'],
    );
  }
}

class ProvisioningChartStats {
  final String period;
  final List<ProvisioningChartPoint> data;

  ProvisioningChartStats({required this.period, required this.data});

  factory ProvisioningChartStats.fromJson(Map<String, dynamic> json) {
    return ProvisioningChartStats(
      period: json['period'],
      data: (json['data'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(ProvisioningChartPoint.fromJson)
          .toList(),
    );
  }
}

class ProvisioningChartPoint {
  final String date;
  final int success;
  final int error;
  final int blocked;

  ProvisioningChartPoint({
    required this.date,
    required this.success,
    required this.error,
    required this.blocked,
  });

  factory ProvisioningChartPoint.fromJson(Map<String, dynamic> json) {
    return ProvisioningChartPoint(
      date: json['date'],
      success: json['success'],
      error: json['error'],
      blocked: json['blocked'],
    );
  }
}
