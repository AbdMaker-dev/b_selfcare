import 'dart:async';

import 'package:b_selfcare/src/data/services/http_helper.dart';
import 'package:b_selfcare/src/data/services/local_helper.dart';
import 'package:b_selfcare/src/views/pages/layout/cubit/layout_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'login_state.dart';
part 'login_cubit.freezed.dart';

@lazySingleton
class LoginCubit extends Cubit<LoginState> {
  final HttpHelper _httpHelper;
  final LocaHelper _localHelper;
  final LayoutCubit _layoutCubit;

  Timer? _refreshTimer;
  
  static const _refreshBeforeExpiry = Duration(minutes: 5);
  LoginCubit(this._httpHelper, this._localHelper, this._layoutCubit) : super(LoginState.initial());

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

    String? errorMessage;
    Map<String, dynamic>? data;
    response.fold(
      (left) => errorMessage = left.message,
      (right) => data = right.response?['data'],
    );

    if (errorMessage != null || data == null) {
      emit(LoginState.otpError(errorMessage));
      return false;
    }

    final expiresIn = data!['expires_in'] as int? ?? 3600;
    await _localHelper.saveToken(
      data!['access_token'] ?? "",
      expiryDate: DateTime.now().add(Duration(seconds: expiresIn)),
    );
    await _layoutCubit.fetchCurrentUser();
    scheduleTokenRefresh();
    emit(LoginState.otpSuccess());
    return true;
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

  Future<void> scheduleTokenRefresh() async {
    _refreshTimer?.cancel();
    final expiryStr = await _localHelper.getExpireDate();
    if (expiryStr == null) return;
    final expiry = DateTime.tryParse(expiryStr);
    if (expiry == null) return;
    final refreshAt = expiry.subtract(_refreshBeforeExpiry);
    final delay = refreshAt.isAfter(DateTime.now())? refreshAt.difference(DateTime.now()): Duration.zero;
    _refreshTimer = Timer(delay, _refreshToken);
  }

  Future<void> _refreshToken() async {
    final response = await _httpHelper.handlePostRequest(
      "auth/refresh",
      {},
      showSuccessToast: false,
      showLoader: false,
      showErrorToast: false,
    );

    String? errorMessage;
    Map<String, dynamic>? data;
    response.fold(
      (left) => errorMessage = left.message,
      (right) => data = right.response?['data'],
    );
    if (errorMessage != null || data == null) return;
    final expiresIn = data!['expires_in'] as int? ?? 3600;
    await _localHelper.saveToken(
      data!['access_token'] ?? "",
      expiryDate: DateTime.now().add(Duration(seconds: expiresIn)),
    );
    scheduleTokenRefresh();
  }

  @override
  Future<void> close() {
    _refreshTimer?.cancel();
    return super.close();
  }
}
