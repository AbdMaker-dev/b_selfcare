part of 'users_cubit.dart';

@freezed
class UsersState with _$UsersState {
  const factory UsersState.initial()                        = _Initial;

  const factory UsersState.getUsersLoading()                = GetUsersLoading;
  const factory UsersState.getUsersLoaded()                 = GetUsersLoaded;
  const factory UsersState.getUsersFailed(String message)   = GetUsersFailed;

  const factory UsersState.createUserLoading()              = CreateUserLoading;
  const factory UsersState.createUserLoaded()               = CreateUserLoaded;
  const factory UsersState.createUserFailed(String message) = CreateUserFailed;

  const factory UsersState.updateUserLoading()              = UpdateUserLoading;
  const factory UsersState.updateUserLoaded()               = UpdateUserLoaded;
  const factory UsersState.updateUserFailed(String message) = UpdateUserFailed;

  const factory UsersState.disableUserLoading()                   = DisableUserLoading;
  const factory UsersState.disableUserLoaded()                    = DisableUserLoaded;
  const factory UsersState.disableUserFailed(String message)      = DisableUserFailed;

  const factory UsersState.resendInvitationLoading()              = ResendInvitationLoading;
  const factory UsersState.resendInvitationLoaded()               = ResendInvitationLoaded;
  const factory UsersState.resendInvitationFailed(String message) = ResendInvitationFailed;
}
