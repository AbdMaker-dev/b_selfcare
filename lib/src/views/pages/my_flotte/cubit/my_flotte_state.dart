part of 'my_flotte_cubit.dart';

@freezed
class MyFlotteState with _$MyFlotteState {
  const factory MyFlotteState.initial() = _Initial;
  const factory MyFlotteState.getEmployeesLoading() = GetEmployeesLoading;
  const factory MyFlotteState.getEmployeesLoaded({required DataEmployeeResponseModel data}) = GetEmployeesLoaded;
  const factory MyFlotteState.getEmployeesFailed(String message) = GetEmployeesFailed;
}
