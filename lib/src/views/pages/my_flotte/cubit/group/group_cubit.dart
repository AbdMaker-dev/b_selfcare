import 'package:bloc/bloc.dart';
import 'package:b_selfcare/src/data/models/group/data_group_response_model.dart';
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
}
