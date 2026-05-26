import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:b_selfcare/src/data/models/data_response_model.dart';
import 'package:b_selfcare/src/data/models/employee/data_employee_response_model.dart';
import 'package:b_selfcare/src/data/models/group/data_group_response_model.dart';
import 'package:b_selfcare/src/data/models/group/data_import_response_model.dart';
import 'package:b_selfcare/src/domain/usecases/group_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'group_state.dart';
part 'group_cubit.freezed.dart';

@lazySingleton
class GroupCubit extends Cubit<GroupState> {
  final GroupUsecase groupUsecase;

  GroupCubit(this.groupUsecase) : super(const GroupState.initial());

  Future<void> getGroups({required dynamic data}) async {
    emit(const GroupState.getGroupsLoading());
    final res = await groupUsecase.getGroups(data: data);
    res.fold(
      (failure) => emit(GroupState.getGroupsFailed(failure.message)),
      (data) => emit(GroupState.getGroupsLoaded(data: data)),
    );
  }

  Future<void> createGroupe({required dynamic data}) async {
    emit(const GroupState.createGroupeLoading());
    final res = await groupUsecase.createGroupe(data: data);
    res.fold(
      (failure) => emit(GroupState.createGroupeFailed(failure.message)),
      (data) => emit(GroupState.createGroupeLoaded(data: data)),
    );
  }

  Future<void> updateGroupe({required int id, required dynamic data}) async {
    emit(const GroupState.updateGroupeLoading());
    final res = await groupUsecase.updateGroupe(id: id, data: data);
    res.fold(
      (failure) => emit(GroupState.updateGroupeFailed(failure.message)),
      (data) => emit(GroupState.updateGroupeLoaded(data: data)),
    );
  }

  Future<void> deleteGroupe({required int id}) async {
    emit(const GroupState.deleteGroupeLoading());
    final res = await groupUsecase.deleteGroupe(id: id);
    res.fold(
      (failure) => emit(GroupState.deleteGroupeFailed(failure.message)),
      (data) => emit(GroupState.deleteGroupeLoaded(data: data)),
    );
  }

  Future<void> importEmployeInGroupe({
    required int id,
    required Uint8List file,
    required String fileName,
  }) async {
    emit(const GroupState.importEmployeLoading());
    final res = await groupUsecase.importEmployeInGroupe(id: id, file: file, fileName: fileName);
    res.fold(
      (failure) => emit(GroupState.importEmployeFailed(failure.message)),
      (data) => emit(GroupState.importEmployeLoaded(data: data)),
    );
  }

  Future<void> getEmployeesGroup({required int id, required dynamic data}) async {
    emit(const GroupState.getEmployeesGroupLoading());
    final res = await groupUsecase.getEmployeesGroup(id: id, data: data);
    res.fold(
      (failure) => emit(GroupState.getEmployeesGroupFailed(failure.message)),
      (data) => emit(GroupState.getEmployeesGroupLoaded(data: data)),
    );
  }
}
