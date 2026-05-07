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
}
