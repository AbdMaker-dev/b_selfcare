part of 'invitation_cubit.dart';

@freezed
class InvitationState with _$InvitationState {
  const factory InvitationState.initial()                      = _Initial;
  const factory InvitationState.submitting()                   = _Submitting;
  const factory InvitationState.success()                      = _Success;
  const factory InvitationState.error(String? message)         = _Error;
}
