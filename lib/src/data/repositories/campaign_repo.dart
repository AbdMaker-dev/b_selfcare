import 'package:b_selfcare/src/data/models/campaign/data_campaign_response_model.dart';
import 'package:b_selfcare/src/data/models/failure.dart';
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
}