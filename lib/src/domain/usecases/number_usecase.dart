import 'package:b_selfcare/src/data/models/data_response_model.dart';
import 'package:b_selfcare/src/data/models/failure.dart';
import 'package:b_selfcare/src/data/models/flotte_number/data_flotte_number_response_model.dart';
import 'package:b_selfcare/src/data/repositories/numero_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NumberUsecase {
  final NumeroRepo numeroRepo;
  NumberUsecase({required this.numeroRepo});

  Future<Either<Failure, DataFlotteNumberResponseModel>> getNumbers({required dynamic data}) async {
    var res = await numeroRepo.getNumbers(data: data);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) {
        return Right(success);
      },
    );
  }

  Future<Either<Failure, DataResponseModel>> assignNumber({required int id,required dynamic data}) async {
    var res = await numeroRepo.assignNumber(data: data, id: id);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) {
        return Right(success);
      },
    );
  }

  Future<Either<Failure, DataResponseModel>> suspendNumber({required int id,required dynamic data}) async {
    var res = await numeroRepo.suspendNumber(data: data, id: id);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) {
        return Right(success);
      },
    );
  }

  Future<Either<Failure, DataResponseModel>> reactivateNumber({required int id, required dynamic data}) async {
    var res = await numeroRepo.reactivateNumber(data: data, id: id);
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