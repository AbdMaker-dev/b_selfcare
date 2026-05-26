import 'package:b_selfcare/src/data/services/http_helper.dart';
import 'package:b_selfcare/src/data/services/local_helper.dart';
import 'package:b_selfcare/src/views/pages/layout/cubit/layout_cubit.dart';
import 'package:b_selfcare/src/views/pages/login/cubit/login_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'invitation_state.dart';
part 'invitation_cubit.freezed.dart';

@lazySingleton
class InvitationCubit extends Cubit<InvitationState> {
  final HttpHelper _httpHelper;
  final LocaHelper _localHelper;
  final LayoutCubit _layoutCubit;
  final LoginCubit _loginCubit;

  InvitationCubit(
    this._httpHelper,
    this._localHelper,
    this._layoutCubit,
    this._loginCubit,
  ) : super(const InvitationState.initial());

  Future<void> acceptInvitation({
    required String token,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(const InvitationState.submitting());

    final response = await _httpHelper.handlePostRequest(
      'invitation/accept',
      {
        'token': token,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
      showLoader: true,
      showSuccessToast: true,
      showErrorToast: true,
    );

    response.fold(
      (left) => emit(InvitationState.error(left.message)),
      (right) async {
        final data = right.response?['data'] as Map<String, dynamic>?;
        if (data == null) {
          emit(const InvitationState.error('Réponse invalide du serveur.'));
          return;
        }
        final expiresIn = data['expires_in'] as int? ?? 3600;
        await _localHelper.saveToken(
          data['access_token'] ?? '',
          expiryDate: DateTime.now().add(Duration(seconds: expiresIn)),
        );
        await _layoutCubit.fetchCurrentUser();
        _loginCubit.scheduleTokenRefresh();
        emit(const InvitationState.success());
      },
    );
  }
}
