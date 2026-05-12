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
}
