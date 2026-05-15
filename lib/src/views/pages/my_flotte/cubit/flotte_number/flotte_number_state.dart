part of 'flotte_number_cubit.dart';

@freezed
class FlotteNumberState with _$FlotteNumberState {
  const factory FlotteNumberState.initial() = _Initial;
  const factory FlotteNumberState.getNumbersLoading() = GetNumbersLoading;
  const factory FlotteNumberState.getNumbersLoaded({required DataFlotteNumberResponseModel data}) = GetNumbersLoaded;
  const factory FlotteNumberState.getNumbersFailed(String message) = GetNumbersFailed;
  const factory FlotteNumberState.assignNumberLoading() = AssignNumberLoading;
  const factory FlotteNumberState.assignNumberLoaded({required DataResponseModel data}) = AssignNumberLoaded;
  const factory FlotteNumberState.assignNumberFailed(String message) = AssignNumberFailed;
  const factory FlotteNumberState.suspendNumberLoading() = SuspendNumberLoading;
  const factory FlotteNumberState.suspendNumberLoaded({required DataResponseModel data}) = SuspendNumberLoaded;
  const factory FlotteNumberState.suspendNumberFailed(String message) = SuspendNumberFailed;
  const factory FlotteNumberState.reactivateNumberLoading() = ReactivateNumberLoading;
  const factory FlotteNumberState.reactivateNumberLoaded({required DataResponseModel data}) = ReactivateNumberLoaded;
  const factory FlotteNumberState.reactivateNumberFailed(String message) = ReactivateNumberFailed;
}
