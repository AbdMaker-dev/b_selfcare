part of 'campagne_cubit.dart';

@freezed
class CampagneState with _$CampagneState {
  const factory CampagneState.initial() = _Initial;
  const factory CampagneState.getCampaignsLoading() = GetCampaignsLoading;
  const factory CampagneState.getCampaignsLoaded({required DataCampaignResponseModel data}) = GetCampaignsLoaded;
  const factory CampagneState.getCampaignsFailed(String message) = GetCampaignsFailed;
}
