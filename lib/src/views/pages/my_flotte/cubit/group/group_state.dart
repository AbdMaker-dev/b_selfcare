part of 'group_cubit.dart';

@freezed
class GroupState with _$GroupState {
  const factory GroupState.initial() = _Initial;
  const factory GroupState.getGroupsLoading() = GetGroupsLoading;
  const factory GroupState.getGroupsLoaded({required DataGroupResponseModel data}) = GetGroupsLoaded;
  const factory GroupState.getGroupsFailed(String message) = GetGroupsFailed;
}
