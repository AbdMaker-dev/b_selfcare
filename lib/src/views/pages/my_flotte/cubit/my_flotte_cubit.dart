import 'package:bloc/bloc.dart';
import 'package:b_selfcare/src/data/models/data_response_model.dart';
import 'package:b_selfcare/src/data/models/employee/data_employee_response_model.dart';
import 'package:b_selfcare/src/domain/usecases/employee_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'my_flotte_state.dart';
part 'my_flotte_cubit.freezed.dart';

@lazySingleton
class MyFlotteCubit extends Cubit<MyFlotteState> {
  final EmployeeUsecase employeeUsecase;

  MyFlotteCubit(this.employeeUsecase) : super(const MyFlotteState.initial());

  Future<void> getEmployees({required dynamic data}) async {
    emit(const MyFlotteState.getEmployeesLoading());
    final res = await employeeUsecase.getEmployees(data: data);
    res.fold(
      (failure) => emit(MyFlotteState.getEmployeesFailed(failure.message)),
      (data) => emit(MyFlotteState.getEmployeesLoaded(data: data)),
    );
  }

  Future<void> createEmployee({required dynamic data}) async {
    emit(const MyFlotteState.createEmployeeLoading());
    final res = await employeeUsecase.createEmployee(data: data);
    res.fold(
      (failure) => emit(MyFlotteState.createEmployeeFailed(failure.message)),
      (data) => emit(MyFlotteState.createEmployeeLoaded(data: data)),
    );
  }

  Future<void> updateEmployee({required int id, required dynamic data}) async {
    emit(const MyFlotteState.updateEmployeeLoading());
    final res = await employeeUsecase.updateEmployee(id: id, data: data);
    res.fold(
      (failure) => emit(MyFlotteState.updateEmployeeFailed(failure.message)),
      (data) => emit(MyFlotteState.updateEmployeeLoaded(data: data)),
    );
  }

  Future<void> disableEmployee({required int id}) async {
    emit(const MyFlotteState.disableEmployeeLoading());
    final res = await employeeUsecase.disableEmployee(id: id);
    res.fold(
      (failure) => emit(MyFlotteState.disableEmployeeFailed(failure.message)),
      (data) => emit(MyFlotteState.disableEmployeeLoaded(data: data)),
    );
  }

  Future<void> removeNumbersForEmploye({required int id, required dynamic data}) async {
    emit(const MyFlotteState.removeNumbersLoading());
    final res = await employeeUsecase.removeNumbersForEmploye(id: id, data: data);
    res.fold(
      (failure) => emit(MyFlotteState.removeNumbersFailed(failure.message)),
      (data) => emit(MyFlotteState.removeNumbersLoaded(data: data)),
    );
  }

  Future<void> assignNumbersForEmploye({required int id, required dynamic data}) async {
    emit(const MyFlotteState.assignNumbersLoading());
    final res = await employeeUsecase.assignNumbersForEmploye(id: id, data: data);
    res.fold(
      (failure) => emit(MyFlotteState.assignNumbersFailed(failure.message)),
      (data) => emit(MyFlotteState.assignNumbersLoaded(data: data)),
    );
  }

  Future<void> manualProvisioning({required dynamic data}) async {
    emit(const MyFlotteState.manualProvisioningLoading());
    final res = await employeeUsecase.manualProvisioning(data: data);
    res.fold(
      (failure) => emit(MyFlotteState.manualProvisioningFailed(failure.message)),
      (data) => emit(MyFlotteState.manualProvisioningLoaded(data: data)),
    );
  }

  Future<void> downloadFileEmployes() async {
    emit(const MyFlotteState.downloadFileEmployesLoading());
    final res = await employeeUsecase.downloadFileEmployes();
    res.fold(
      (failure) => emit(MyFlotteState.downloadFileEmployesFailed(failure.message)),
      (_) => emit(const MyFlotteState.downloadFileEmployesLoaded()),
    );
  }

}
