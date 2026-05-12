part of 'dashboard_cubit.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = _Initial;

  const factory DashboardState.dashboardLoading() = _DashboardLoading;
  const factory DashboardState.dashboardError(String? message) = _DashboardError;
  const factory DashboardState.dashboardLoaded() = _DashboardLoaded;

  const factory DashboardState.provisioningStatsLoading() = _ProvisioningStatsLoading;
  const factory DashboardState.provisioningStatsError(String? message) = _ProvisioningStatsError;
  const factory DashboardState.provisioningStatsLoaded() = _ProvisioningStatsLoaded;
}
