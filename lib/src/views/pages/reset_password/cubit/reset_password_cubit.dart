import 'package:bloc/bloc.dart';
import 'package:b_selfcare/src/data/models/data_response_model.dart';
import 'package:b_selfcare/src/domain/usecases/reset_password_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'reset_password_state.dart';
part 'reset_password_cubit.freezed.dart';

@lazySingleton
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUsecase resetPasswordUsecase;

  ResetPasswordCubit(this.resetPasswordUsecase)
      : super(const ResetPasswordState.initial());

  Future<void> forgetPassword({required String email}) async {
    emit(const ResetPasswordState.resetPasswordLoading());
    final res = await resetPasswordUsecase.forgetPassword(email: email);
    res.fold(
      (failure) => emit(ResetPasswordState.resetPasswordFailed(failure.message)),
      (data) => emit(ResetPasswordState.resetPasswordLoaded(data: data)),
    );
  }

  Future<void> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String token,
  }) async {
    emit(const ResetPasswordState.changePasswordLoading());
    final res = await resetPasswordUsecase.resetPassword(
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      token: token,
    );
    res.fold(
      (failure) => emit(ResetPasswordState.changePasswordFailed(failure.message)),
      (data) => emit(ResetPasswordState.changePasswordLoaded(data: data)),
    );
  }
}
