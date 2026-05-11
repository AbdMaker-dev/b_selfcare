import 'package:b_selfcare/src/data/models/campaign/data_campaign_response_model.dart';
import 'package:b_selfcare/src/data/models/failure.dart';
import 'package:b_selfcare/src/data/repositories/campaign_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CampaignUsecase {
  final CampaignRepo campaignRepo;
  CampaignUsecase({required this.campaignRepo});

  Future<Either<Failure, DataCampaignResponseModel>> getCampaigns({required dynamic data}) async {
    var res = await campaignRepo.getCampaigns(data: data);
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