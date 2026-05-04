part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;

  const factory LoginState.submitting() = _Submitting;
  const factory LoginState.success(String mfaToken) = _Success;
  const factory LoginState.error(String? message) = _Error;

  const factory LoginState.otpSubmitting() = _OtpSubmitting;
  const factory LoginState.otpSuccess() = _OtpSuccess;
  const factory LoginState.otpError(String? message) = _OtpError;

  const factory LoginState.resendOtpSubmitting() = _ResendOtpSubmitting;
  const factory LoginState.resendOtpSuccess(String mfaToken) = _ResendOtpSuccess;
  const factory LoginState.resendOtpError(String? message) = _ResendOtpError;
}
