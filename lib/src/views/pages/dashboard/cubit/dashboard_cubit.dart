import 'package:b_selfcare/src/data/models/dashboard/company_stats_model.dart';
import 'package:b_selfcare/src/data/services/http_helper.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'dashboard_state.dart';
part 'dashboard_cubit.freezed.dart';

@lazySingleton
class DashboardCubit extends Cubit<DashboardState> {
  final HttpHelper _httpHelper;
  DashboardCubit(this._httpHelper) : super(DashboardState.initial());

  CompanyStatsModel? companyStats;

  ProvisioningChartStats? get provisioningChart => companyStats?.provisioningChart;

  String get companySubtitle {
    final c = companyStats?.company;
    if (c == null) return 'Chargement...';
    return '${c.name} · ${c.cbsAccountId} · ${c.planName.toUpperCase()} · PRÉPAYÉ · Mise à jour ${AppDate.dashboardFmt(c.updatedAt)}';
  }

  Future<void> fetchCompanyStats() async {
    emit(DashboardState.dashboardLoading());
    final response = await _httpHelper.handleGetRequest("company/stats", showLoader: true);
    response.fold(
      (left) => emit(DashboardState.dashboardError(left.message)),
      (right) {
        final data = right.response?['data'] as Map<String, dynamic>?;
        if (data != null) companyStats = CompanyStatsModel.fromJson(data);
        emit(DashboardState.dashboardLoaded());
      },
    );
  }

  // Appeler uniquement pour changer la période (ex: 7d, 30d)
  Future<void> fetchProvisioningChartByPeriod(String period) async {
    emit(DashboardState.provisioningStatsLoading());
    final response = await _httpHelper.handleGetRequest("company/stats/provisioning-chart?period=$period", showLoader: true);
    response.fold(
      (left) => emit(DashboardState.provisioningStatsError(left.message)),
      (right) {
        final data = right.response?['data'] as Map<String, dynamic>?;
        if (data != null && companyStats != null) {
          companyStats = CompanyStatsModel(
            company: companyStats!.company,
            balanceCard: companyStats!.balanceCard,
            activeNumbersCard: companyStats!.activeNumbersCard,
            monthlySpendCard: companyStats!.monthlySpendCard,
            activeCampaignsCard: companyStats!.activeCampaignsCard,
            fleetSummary: companyStats!.fleetSummary,
            recentCampaigns: companyStats!.recentCampaigns,
            recentRecharges: companyStats!.recentRecharges,
            recentActivity: companyStats!.recentActivity,
            alerts: companyStats!.alerts,
            serviceStatus: companyStats!.serviceStatus,
            provisioningChart: ProvisioningChartStats.fromJson(data),
          );
        }
        emit(DashboardState.provisioningStatsLoaded());
      },
    );
  }
}
