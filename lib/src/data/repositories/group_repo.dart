import 'package:b_selfcare/src/data/models/failure.dart';
import 'package:b_selfcare/src/data/models/group/data_group_response_model.dart';
import 'package:b_selfcare/src/data/services/http_helper.dart';
import 'package:b_selfcare/src/data/services/local_helper.dart';
import 'package:dartz/dartz.dart';
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
}