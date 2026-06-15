part of 'my_flotte_cubit.dart';

@freezed
class MyFlotteState with _$MyFlotteState {
  const factory MyFlotteState.initial() = _Initial;
  const factory MyFlotteState.getEmployeesLoading() = GetEmployeesLoading;
  const factory MyFlotteState.getEmployeesLoaded({required DataEmployeeResponseModel data}) = GetEmployeesLoaded;
  const factory MyFlotteState.getEmployeesFailed(String message) = GetEmployeesFailed;
  const factory MyFlotteState.createEmployeeLoading() = CreateEmployeeLoading;
  const factory MyFlotteState.createEmployeeLoaded({required DataResponseModel data}) = CreateEmployeeLoaded;
  const factory MyFlotteState.createEmployeeFailed(String message) = CreateEmployeeFailed;
  const factory MyFlotteState.updateEmployeeLoading() = UpdateEmployeeLoading;
  const factory MyFlotteState.updateEmployeeLoaded({required DataResponseModel data}) = UpdateEmployeeLoaded;
  const factory MyFlotteState.updateEmployeeFailed(String message) = UpdateEmployeeFailed;
  const factory MyFlotteState.disableEmployeeLoading() = DisableEmployeeLoading;
  const factory MyFlotteState.disableEmployeeLoaded({required DataResponseModel data}) = DisableEmployeeLoaded;
  const factory MyFlotteState.disableEmployeeFailed(String message) = DisableEmployeeFailed;
  const factory MyFlotteState.removeNumbersLoading() = RemoveNumbersLoading;
  const factory MyFlotteState.removeNumbersLoaded({required DataResponseModel data}) = RemoveNumbersLoaded;
  const factory MyFlotteState.removeNumbersFailed(String message) = RemoveNumbersFailed;
  const factory MyFlotteState.assignNumbersLoading() = AssignNumbersLoading;
  const factory MyFlotteState.assignNumbersLoaded({required DataResponseModel data}) = AssignNumbersLoaded;
  const factory MyFlotteState.assignNumbersFailed(String message) = AssignNumbersFailed;
  const factory MyFlotteState.downloadFileEmployesLoading() = DownloadFileEmployesLoading;
  const factory MyFlotteState.downloadFileEmployesLoaded() = DownloadFileEmployesLoaded;
  const factory MyFlotteState.downloadFileEmployesFailed(String message) = DownloadFileEmployesFailed;
  const factory MyFlotteState.manualProvisioningLoading() = ManualProvisioningLoading;
  const factory MyFlotteState.manualProvisioningLoaded({required DataResponseModel data}) = ManualProvisioningLoaded;
  const factory MyFlotteState.manualProvisioningFailed(String message) = ManualProvisioningFailed;
  const factory MyFlotteState.getResourceEmployeLoading() = GetResourceEmployeLoading;
  const factory MyFlotteState.getResourceEmployeLoaded({required DataResourceCustomResponseModel data}) = GetResourceEmployeLoaded;
  const factory MyFlotteState.getResourceEmployeFailed(String message) = GetResourceEmployeFailed;
  const factory MyFlotteState.getResourceAggregatedEmployeLoading() = GetResourceAggregatedEmployeLoading;
  const factory MyFlotteState.getResourceAggregatedEmployeLoaded({required DataResourceCustomAggregatedResponseModel data}) = GetResourceAggregatedEmployeLoaded;
  const factory MyFlotteState.getResourceAggregatedEmployeFailed(String message) = GetResourceAggregatedEmployeFailed;
  const factory MyFlotteState.recoveryConfirmEmployeeLoading() = RecoveryConfirmEmployeeLoading;
  const factory MyFlotteState.recoveryConfirmEmployeeLoaded({required DataResponseModel data}) = RecoveryConfirmEmployeeLoaded;
  const factory MyFlotteState.recoveryConfirmEmployeeFailed(String message) = RecoveryConfirmEmployeeFailed;
  const factory MyFlotteState.historiqueRecoveryEmployeeLoading() = HistoriqueRecoveryEmployeeLoading;
  const factory MyFlotteState.historiqueRecoveryEmployeeLoaded({required DataRecoveryHistoryResponseModel data}) = HistoriqueRecoveryEmployeeLoaded;
  const factory MyFlotteState.historiqueRecoveryEmployeeFailed(String message) = HistoriqueRecoveryEmployeeFailed;
}
