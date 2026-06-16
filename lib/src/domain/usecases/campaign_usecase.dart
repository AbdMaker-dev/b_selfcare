import 'package:b_selfcare/src/data/models/campaign/campaign_execution_model.dart';
import 'package:b_selfcare/src/data/models/campaign/data_campaign_response_model.dart';
import 'package:b_selfcare/src/data/models/data_response_model.dart';
import 'package:b_selfcare/src/data/models/failure.dart';
import 'package:b_selfcare/src/data/models/provisioning/provisioning_log_model.dart';
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
  Future<Either<Failure, DataResponseModel>> triggerAndExecuteCampaigns({required int id, required String execute}) async {
    var res = await campaignRepo.triggerAndExecuteCampaigns(id: id, execute: execute);
    return res.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }

  Future<Either<Failure, DataResponseModel>> pauseAndCancelAndReactivateCampaigns({required int id, required String execute}) async {
    var res = await campaignRepo.pauseAndCancelAndReactivateCampaigns(id: id, execute: execute);
    return res.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }

  Future<Either<Failure, ProvisioningLogsResponseModel>> getProvisioningLogs({dynamic params}) async {
    return campaignRepo.getProvisioningLogs(params: params);
  }

  Future<Either<Failure, CampaignExecutionsResponseModel>> getExecutions({dynamic params}) async {
    return campaignRepo.getExecutions(params: params);
  }
}