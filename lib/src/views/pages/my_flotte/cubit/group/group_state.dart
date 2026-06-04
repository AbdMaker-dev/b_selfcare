part of 'group_cubit.dart';

@freezed
class GroupState with _$GroupState {
  const factory GroupState.initial() = _Initial;
  const factory GroupState.getGroupsLoading() = GetGroupsLoading;
  const factory GroupState.getGroupsLoaded({required DataGroupResponseModel data}) = GetGroupsLoaded;
  const factory GroupState.getGroupsFailed(String message) = GetGroupsFailed;
  const factory GroupState.createGroupeLoading() = CreateGroupeLoading;
  const factory GroupState.createGroupeLoaded({required DataResponseModel data}) = CreateGroupeLoaded;
  const factory GroupState.createGroupeFailed(String message) = CreateGroupeFailed;
  const factory GroupState.updateGroupeLoading() = UpdateGroupeLoading;
  const factory GroupState.updateGroupeLoaded({required DataResponseModel data}) = UpdateGroupeLoaded;
  const factory GroupState.updateGroupeFailed(String message) = UpdateGroupeFailed;
  const factory GroupState.deleteGroupeLoading() = DeleteGroupeLoading;
  const factory GroupState.deleteGroupeLoaded({required DataResponseModel data}) = DeleteGroupeLoaded;
  const factory GroupState.deleteGroupeFailed(String message) = DeleteGroupeFailed;
  const factory GroupState.importEmployeLoading() = ImportEmployeLoading;
  const factory GroupState.importEmployeLoaded({required DataImportResponseModel data}) = ImportEmployeLoaded;
  const factory GroupState.importEmployeFailed(String message) = ImportEmployeFailed;
  const factory GroupState.getEmployeesGroupLoading() = GetEmployeesGroupLoading;
  const factory GroupState.getEmployeesGroupLoaded({required DataEmployeeResponseModel data}) = GetEmployeesGroupLoaded;
  const factory GroupState.getEmployeesGroupFailed(String message) = GetEmployeesGroupFailed;
  const factory GroupState.configNotifGroupeLoading() = ConfigNotifGroupeLoading;
  const factory GroupState.configNotifGroupeLoaded({required DataResponseModel data}) = ConfigNotifGroupeLoaded;
  const factory GroupState.configNotifGroupeFailed(String message) = ConfigNotifGroupeFailed;
}
