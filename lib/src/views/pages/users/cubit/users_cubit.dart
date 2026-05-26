import 'package:b_selfcare/src/data/models/meta_model.dart';
import 'package:b_selfcare/src/data/models/role_model.dart';
import 'package:b_selfcare/src/data/models/user_profile_model.dart';
import 'package:b_selfcare/src/data/services/http_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'users_state.dart';
part 'users_cubit.freezed.dart';

@lazySingleton
class UsersCubit extends Cubit<UsersState> {
  final HttpHelper _httpHelper;

  UsersCubit(this._httpHelper) : super(const UsersState.initial());

  List<UserProfileModel> users = [];
  List<RoleModel> roles = [];
  UserProfileModel? selectedUser;
  int currentPage = 1;
  int totalCount  = 0;
  int lastPage    = 1;

  Future<void> getUsers({Map<String, dynamic>? data}) async {
    // if(users.isNotEmpty) return;
    emit(const UsersState.getUsersLoading());
    final response = await _httpHelper.handleGetRequest('users', params: data);
    response.fold(
      (left) => emit(UsersState.getUsersFailed(left.message)),
      (right) {
        final body  = right.response?['data'] as Map<String, dynamic>? ?? {};
        final list  = body['data'] as List<dynamic>? ?? [];
        final meta  = MetaModel.fromJson(body['meta'] as Map<String, dynamic>? ?? {});
        users        = list.whereType<Map<String, dynamic>>().map(UserProfileModel.fromJson).toList();
        currentPage  = meta.currentPage ?? 1;
        totalCount   = meta.total ?? 0;
        lastPage     = meta.lastPage ?? 1;
        emit(const UsersState.getUsersLoaded());
      },
    );
  }

  Future<void> createUser({required Map<String, dynamic> data}) async {
    emit(const UsersState.createUserLoading());
    final response = await _httpHelper.handlePostRequest('users', data);
    response.fold(
      (left) => emit(UsersState.createUserFailed(left.message)),
      (right) => emit(const UsersState.createUserLoaded()),
    );
  }

  Future<void> updateUser({required int id, required Map<String, dynamic> data}) async {
    emit(const UsersState.updateUserLoading());
    final response = await _httpHelper.handlePutRequest('users/$id', data);
    response.fold(
      (left) => emit(UsersState.updateUserFailed(left.message)),
      (right) => emit(const UsersState.updateUserLoaded()),
    );
  }

  Future<UserProfileModel?> getUserById(int id) async {
    final response = await _httpHelper.handleGetRequest('users/$id');
    return response.fold(
      (left) => null,
      (right) {
        final data = right.response?['data'] as Map<String, dynamic>?;
        if (data == null) return null;
        selectedUser = UserProfileModel.fromJson(data);
        return selectedUser;
      },
    );
  }

  Future<void> fetchRoles() async {
    final response = await _httpHelper.handleGetRequest('roles');
    response.fold(
      (left) => debugPrint('ROLES ERROR: ${left.message}'),
      (right) {
        final list = right.response?['data'] as List<dynamic>? ?? [];
        roles = list.whereType<Map<String, dynamic>>().map(RoleModel.fromJson).toList();
      },
    );
  }

  Future<void> disableUser({required int id}) async {
    emit(const UsersState.disableUserLoading());
    final response = await _httpHelper.handleDeleteRequest(
      'users/$id',
      {},
      showSuccessToast: false,
    );
    response.fold(
      (left) => emit(UsersState.disableUserFailed(left.message)),
      (right) {
        users = [];
        getUsers(data: {'page': currentPage});
        emit(const UsersState.disableUserLoaded());
      },
    );
  }
}
