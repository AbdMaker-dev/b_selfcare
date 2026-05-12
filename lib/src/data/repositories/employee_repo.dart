import 'package:b_selfcare/src/data/models/data_response_model.dart';
import 'package:b_selfcare/src/data/models/failure.dart';
import 'package:b_selfcare/src/data/services/http_helper.dart';
import 'package:b_selfcare/src/data/services/local_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../models/employee/data_employee_response_model.dart';

@singleton
class EmployeeRepo {
  final LocaHelper localHelper;
  final HttpHelper htttHelper;
  EmployeeRepo(this.localHelper, this.htttHelper);

  Future<Either<Failure, DataEmployeeResponseModel>> getEmployees({required dynamic data}) async {
    var res = await htttHelper.handleGetRequest("fleet/employees", params: data,showLoader: true);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) async{
        var forgetPasswordData = DataEmployeeResponseModel.fromJson(success.response);
        return Right(forgetPasswordData);
      },
    );
  }

  Future<Either<Failure, DataResponseModel>> createEmployee({required dynamic data}) async {
    var res = await htttHelper.handlePostRequest("fleet/employees", data,showLoader: true);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) async{
        var data = DataResponseModel.fromJson(success.response);
        return Right(data);
      },
    );
  }

  Future<Either<Failure, DataResponseModel>> updateEmployee({required int id, required dynamic data}) async {
    var res = await htttHelper.handlePutRequest("fleet/employees/$id", data, showLoader: true);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) async {
        var data = DataResponseModel.fromJson(success.response);
        return Right(data);
      },
    );
  }
}