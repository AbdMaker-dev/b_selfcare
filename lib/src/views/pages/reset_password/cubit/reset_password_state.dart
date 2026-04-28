part of 'reset_password_cubit.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.initial() = _Initial;
  const factory ResetPasswordState.resetPasswordLoading() = ResetPasswordLoading;
  const factory ResetPasswordState.changePasswordLoading() = ChangePasswordLoading;
  const factory ResetPasswordState.resetPasswordLoaded({required DataResponseModel data}) = ResetPasswordLoaded;
  const factory ResetPasswordState.changePasswordLoaded({required DataResponseModel data}) = ChangePasswordLoaded;
  const factory ResetPasswordState.resetPasswordError({required DataResponseModel data}) = ResetPasswordError;
  const factory ResetPasswordState.changePasswordError({required DataResponseModel data}) = ChangePasswordError;
  const factory ResetPasswordState.resetPasswordFailed(String message) = ResetPasswordFailed;
  const factory ResetPasswordState.changePasswordFailed(String message) = ChangePasswordFailed;
}
