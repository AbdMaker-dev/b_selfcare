import 'package:b_selfcare/src/data/models/data_response_model.dart';
import 'package:b_selfcare/src/data/models/failure.dart';
import 'package:b_selfcare/src/data/models/flotte_number/data_flotte_number_response_model.dart';
import 'package:b_selfcare/src/data/services/http_helper.dart';
import 'package:b_selfcare/src/data/services/local_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class NumeroRepo {
  final LocaHelper localHelper;
  final HttpHelper htttHelper;
  NumeroRepo(this.localHelper, this.htttHelper);

  Future<Either<Failure, DataFlotteNumberResponseModel>> getNumbers({required dynamic data}) async {
    var res = await htttHelper.handleGetRequest("fleet/numbers", params: data,showLoader: true);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) async{
        var data = DataFlotteNumberResponseModel.fromJson(success.response);
        return Right(data);
      },
    );
  }

  Future<Either<Failure, DataResponseModel>> assignNumber({required int id,required dynamic data}) async {
    var res = await htttHelper.handlePostRequest("fleet/numbers/${id}/assign",data,showLoader: true);
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

  Future<Either<Failure, DataResponseModel>> suspendNumber({required int id,required dynamic data}) async {
    var res = await htttHelper.handlePostRequest("fleet/numbers/${id}/suspend",data ?? {},showLoader: true);
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

  Future<Either<Failure, DataResponseModel>> reactivateNumber({required int id, required dynamic data}) async {
    var res = await htttHelper.handlePostRequest("fleet/numbers/${id}/reactivate",data ?? {}, showLoader: true);
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
}