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
}
