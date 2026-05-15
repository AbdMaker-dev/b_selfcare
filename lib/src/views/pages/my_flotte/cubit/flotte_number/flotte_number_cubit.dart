import 'package:bloc/bloc.dart';
import 'package:b_selfcare/src/data/models/flotte_number/data_flotte_number_response_model.dart';
import 'package:b_selfcare/src/data/models/data_response_model.dart';
import 'package:b_selfcare/src/domain/usecases/number_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'flotte_number_state.dart';
part 'flotte_number_cubit.freezed.dart';

@lazySingleton
class FlotteNumberCubit extends Cubit<FlotteNumberState> {
  final NumberUsecase numberUsecase;

  FlotteNumberCubit(this.numberUsecase) : super(const FlotteNumberState.initial());

  Future<void> getNumbers({required dynamic data}) async {
    emit(const FlotteNumberState.getNumbersLoading());
    final res = await numberUsecase.getNumbers(data: data);
    res.fold(
      (failure) => emit(FlotteNumberState.getNumbersFailed(failure.message)),
      (data) => emit(FlotteNumberState.getNumbersLoaded(data: data)),
    );
  }

  Future<void> assignNumber({required int id, required dynamic data}) async {
    emit(const FlotteNumberState.assignNumberLoading());
    final res = await numberUsecase.assignNumber(id: id, data: data);
    res.fold(
      (failure) => emit(FlotteNumberState.assignNumberFailed(failure.message)),
      (data) => emit(FlotteNumberState.assignNumberLoaded(data: data)),
    );
  }

  Future<void> suspendNumber({required int id, required dynamic data}) async {
    emit(const FlotteNumberState.suspendNumberLoading());
    final res = await numberUsecase.suspendNumber(id: id, data: data);
    res.fold(
      (failure) => emit(FlotteNumberState.suspendNumberFailed(failure.message)),
      (data) => emit(FlotteNumberState.suspendNumberLoaded(data: data)),
    );
  }

  Future<void> reactivateNumber({required int id, required dynamic data}) async {
    emit(const FlotteNumberState.reactivateNumberLoading());
    final res = await numberUsecase.reactivateNumber(id: id, data: data);
    res.fold(
      (failure) => emit(FlotteNumberState.reactivateNumberFailed(failure.message)),
      (data) => emit(FlotteNumberState.reactivateNumberLoaded(data: data)),
    );
  }
}
