import 'package:b_selfcare/src/data/services/http_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'dashboard_state.dart';
part 'dashboard_cubit.freezed.dart';

@lazySingleton
class DashboardCubit extends Cubit<DashboardState> {
  final HttpHelper _httpHelper;
  DashboardCubit(this._httpHelper) : super(DashboardState.initial());


  Future<void> fetchCompanyStats() async {
    emit(DashboardState.dashboardLoading());
    final response = await _httpHelper.handleGetRequest("company/stats", showLoader: true);
    response.fold(
      (left) => emit(DashboardState.dashboardError(left.message)),
      (right) {
        // final list = right.response?['data'] as List<dynamic>? ?? [];
        pragma("dashboard stats: ${right.response}");
        emit(DashboardState.dashboardLoaded());
      },
    );
  }

  Future<void> fetchCompanyProvisioningStats() async {
    emit(DashboardState.provisioningStatsLoading());
    final response = await _httpHelper.handleGetRequest("company/stats/provisioning-chart", showLoader: true);
    response.fold(
      (left) => emit(DashboardState.provisioningStatsError(left.message)),
      (right) {
        // final list = right.response?['data'] as List<dynamic>? ?? [];
        pragma("provisioning stats: ${right.response}");
        emit(DashboardState.provisioningStatsLoaded());
      },
    );
  }
}
