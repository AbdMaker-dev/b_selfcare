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

}