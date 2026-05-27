import 'dart:typed_data';
import 'package:b_selfcare/src/data/models/data_response_model.dart';
import 'package:b_selfcare/src/data/models/employee/data_employee_response_model.dart';
import 'package:b_selfcare/src/data/models/failure.dart';
import 'package:b_selfcare/src/data/models/group/data_group_response_model.dart';
import 'package:b_selfcare/src/data/models/group/data_import_response_model.dart';
import 'package:b_selfcare/src/data/repositories/group_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GroupUsecase {
  final GroupRepo groupRepo;
  GroupUsecase({required this.groupRepo});

  Future<Either<Failure, DataGroupResponseModel>> getGroups({required dynamic data}) async {
    var res = await groupRepo.getGroups(data: data);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) {
        return Right(success);
      },
    );
  }

  Future<Either<Failure, DataResponseModel>> createGroupe({required dynamic data}) async {
    var res = await groupRepo.createGroupe(data: data);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) {
        return Right(success);
      },
    );
  }

  Future<Either<Failure, DataResponseModel>> updateGroupe({required int id,required dynamic data}) async {
    var res = await groupRepo.updateGroupe(id:id,data: data);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) {
        return Right(success);
      },
    );
  }
  Future<Either<Failure, DataResponseModel>> deleteGroupe({required int id}) async {
    var res = await groupRepo.deleteGroupe(id:id);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) {
        return Right(success);
      },
    );
  }

  Future<Either<Failure, DataEmployeeResponseModel>> getEmployeesGroup({required int id,required dynamic data}) async {
    var res = await groupRepo.getEmployeesGroup(id:id,data: data);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) {
        return Right(success);
      },
    );
  }


  Future<Either<Failure, DataImportResponseModel>> importEmployeInGroupe({
    required int id,
    required Uint8List file,
    required String fileName,
  }) async {
    var res = await groupRepo.importEmployeInGroupe(id: id, file: file, fileName: fileName);
    return res.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }

}