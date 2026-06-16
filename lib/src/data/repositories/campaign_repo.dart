import 'package:b_selfcare/src/data/models/campaign/data_campaign_response_model.dart';
import 'package:b_selfcare/src/data/models/data_response_model.dart';
import 'package:b_selfcare/src/data/models/failure.dart';
import 'package:b_selfcare/src/data/models/provisioning/provisioning_log_model.dart';
import 'package:b_selfcare/src/data/services/http_helper.dart';
import 'package:b_selfcare/src/data/services/local_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class CampaignRepo {
  final LocaHelper localHelper;
  final HttpHelper htttHelper;
  CampaignRepo(this.localHelper, this.htttHelper);

  Future<Either<Failure, DataCampaignResponseModel>> getCampaigns({required dynamic data}) async {
    var res = await htttHelper.handleGetRequest("campaigns", params: data,showLoader: true);
    return res.fold(
          (error) {
        return Left(error);
      },
          (success) async{
        var data = DataCampaignResponseModel.fromJson(success.response);
        return Right(data);
      },
    );
  }

  Future<Either<Failure, DataResponseModel>> triggerAndExecuteCampaigns({required int id,required String execute}) async {
    var res = await htttHelper.handlePostRequest("campaigns/${id}/${execute}",{},showLoader: true);
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

  Future<Either<Failure, DataResponseModel>> pauseAndCancelAndReactivateCampaigns({required int id,required String execute}) async {
    var res = await htttHelper.handlePutRequest("campaigns/${id}/${execute}",{},showLoader: true);
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

  Future<Either<Failure, ProvisioningLogsResponseModel>> getProvisioningLogs({dynamic params}) async {
    var res = await htttHelper.handleGetRequest("provisioning/logs", params: params, showLoader: true);
    return res.fold(
      (error) => Left(error),
      (success) => Right(ProvisioningLogsResponseModel.fromJson(success.response)),
    );
  }
}