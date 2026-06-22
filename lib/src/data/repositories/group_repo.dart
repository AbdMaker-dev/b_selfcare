import 'dart:typed_data';
import 'package:b_selfcare/src/data/models/data_response_model.dart';
import 'package:b_selfcare/src/data/models/employee/data_employee_response_model.dart';
import 'package:b_selfcare/src/data/models/failure.dart';
import 'package:b_selfcare/src/data/models/group/data_group_response_model.dart';
import 'package:b_selfcare/src/data/models/group/data_import_response_model.dart';
import 'package:b_selfcare/src/data/services/http_helper.dart';
import 'package:b_selfcare/src/data/services/local_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class GroupRepo {
  final LocaHelper localHelper;
  final HttpHelper htttHelper;
  GroupRepo(this.localHelper, this.htttHelper);

  Future<Either<Failure, DataGroupResponseModel>> getGroups({required dynamic data}) async {
    var res = await htttHelper.handleGetRequest("fleet/groups", params: data,showLoader: true);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) async{
        var data = DataGroupResponseModel.fromJson(success.response);
        return Right(data);
      },
    );
  }

  Future<Either<Failure, DataResponseModel>> createGroupe({required dynamic data}) async {
    var res = await htttHelper.handlePostRequest("fleet/groups", data,showLoader: true);
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

  Future<Either<Failure, DataResponseModel>> updateGroupe({required int id,required dynamic data}) async {
    var res = await htttHelper.handlePutRequest("fleet/groups/${id}", data,showLoader: true);
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

  Future<Either<Failure, DataResponseModel>> configurationNotificationGroupe({required int id,required dynamic data}) async {
    var res = await htttHelper.handlePutRequest("fleet/groups/${id}/sms-notification", data,showLoader: true);
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

  Future<Either<Failure, DataResponseModel>> deleteGroupe({required int id}) async {
    var res = await htttHelper.handleDeleteRequest("fleet/groups/${id}",{},showLoader: true);
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

  Future<Either<Failure, DataEmployeeResponseModel>> getEmployeesGroup({required int id,required dynamic data}) async {
    var res = await htttHelper.handleGetRequest("fleet/groups/${id}/employees", params: data,showLoader: true);
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

  Future<Either<Failure, DataImportResponseModel>> importEmployeInGroupe({
    required int id,
    required Uint8List file,
    required String fileName,
  }) async {
    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        file,
        filename: fileName,
      ),
    });

    var res = await htttHelper.handleFormDataPostRequest(
      "fleet/groups/$id/employees/import",
      formData,
      showLoader: true,
    );

    return res.fold(
          (error) {
        return Left(error);
      },
          (success) async {
        var data = DataImportResponseModel.fromJson(success.response);
        return Right(data);
      },
    );
  }
}
