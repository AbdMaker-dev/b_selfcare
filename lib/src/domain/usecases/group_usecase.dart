import 'package:b_selfcare/src/data/models/failure.dart';
import 'package:b_selfcare/src/data/models/group/data_group_response_model.dart';
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

}