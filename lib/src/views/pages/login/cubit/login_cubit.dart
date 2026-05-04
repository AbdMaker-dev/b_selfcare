import 'package:b_selfcare/src/data/services/http_helper.dart';
import 'package:b_selfcare/src/data/services/local_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'login_state.dart';
part 'login_cubit.freezed.dart';

@lazySingleton
class LoginCubit extends Cubit<LoginState> {
  final HttpHelper _httpHelper;
  final LocaHelper _localHelper;
  LoginCubit(this._httpHelper, this._localHelper) : super(LoginState.initial());

  Future<bool> login(Map<String, dynamic> payload) async {
    emit(LoginState.submitting());
    final response = await _httpHelper.handlePostRequest("auth/login", payload);
    return response.fold(
      (left) {
        emit(LoginState.error(left.message));
        return false;
      },
      (right) {
        emit(LoginState.success(right.response?['data']['mfa_token'] ?? ""));
        return true;
      },
    );
  }

  Future<bool> verifyOtp(Map<String, dynamic> payload) async {
    emit(LoginState.otpSubmitting());
    final response = await _httpHelper.handlePostRequest("auth/mfa/challenge", payload);
    return response.fold(
      (left) {
        emit(LoginState.otpError(left.message));
        return false;
      },
      (right) {
        final expiresIn = right.response?['data']['expires_in'] as int? ?? 3600;
        _localHelper.saveToken(
          right.response?['data']['access_token'] ?? "",
          expiryDate: DateTime.now().add(Duration(seconds: expiresIn)),
        );
        emit(LoginState.otpSuccess());
        return true;
      },
    );
  }

  Future<bool> resendOtp(Map<String, dynamic> payload) async {
    emit(LoginState.resendOtpSubmitting());
    final response = await _httpHelper.handlePostRequest("auth/mfa/send", payload);
    return response.fold(
      (left) {
        emit(LoginState.resendOtpError(left.message));
        return false;
      },
      (right) {
        emit(LoginState.resendOtpSuccess(right.response?['data']['mfa_token'] ?? ""));
        return true;
      },
    );
  }
}
