import 'package:b_selfcare/src/data/models/data_response_model.dart';
import 'package:b_selfcare/src/data/models/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/employee/data_employee_response_model.dart';
import '../../data/repositories/employee_repo.dart';

@lazySingleton
class EmployeeUsecase {
  final EmployeeRepo employeeRepo;
  EmployeeUsecase({required this.employeeRepo});

  Future<Either<Failure, DataEmployeeResponseModel>> getEmployees({required dynamic data}) async {
    var res = await employeeRepo.getEmployees(data: data);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) {
        return Right(success);
      },
    );
  }
  Future<Either<Failure, DataResponseModel>> createEmployee({required dynamic data}) async {
    var res = await employeeRepo.createEmployee(data: data);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) {
        return Right(success);
      },
    );
  }

  Future<Either<Failure, DataResponseModel>> updateEmployee({required int id, required dynamic data}) async {
    var res = await employeeRepo.updateEmployee(id: id, data: data);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) {
        return Right(success);
      },
    );
  }

  Future<Either<Failure, DataResponseModel>> removeNumbersForEmploye({required int id, required dynamic data}) async {
    var res = await employeeRepo.removeNumbersForEmploye(id: id, data: data);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) {
        return Right(success);
      },
    );
  }

  Future<Either<Failure, DataResponseModel>> assignNumbersForEmploye({required int id, required dynamic data}) async {
    var res = await employeeRepo.assignNumbersForEmploye(id: id, data: data);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) {
        return Right(success);
      },
    );
  }

  Future<Either<Failure, DataResponseModel>> disableEmployee({required int id}) async {
    var res = await employeeRepo.disableEmployee(id: id);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) {
        return Right(success);
      },
    );
  }

  Future<Either<Failure, bool>> downloadFileEmployes() async {
    var res = await employeeRepo.downloadFileEmployes();
    return res.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }

}